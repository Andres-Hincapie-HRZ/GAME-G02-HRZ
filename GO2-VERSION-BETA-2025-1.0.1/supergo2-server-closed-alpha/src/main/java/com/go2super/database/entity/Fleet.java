// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de entidades relacionadas con flotas
import com.go2super.database.entity.sub.BattleFleet; // Entidad para flota en batalla
import com.go2super.database.entity.sub.FleetInitiator; // Iniciador de flota
import com.go2super.database.entity.sub.FleetMatch; // Coincidencia de flota
import com.go2super.database.entity.sub.FleetTransmission; // Transmisión de flota

// Importaciones de objetos de juego
import com.go2super.obj.game.ShipTeamBody; // Cuerpo del equipo de naves
import com.go2super.obj.game.ShipTeamNum; // Número de naves en equipo
import com.go2super.obj.game.TeamModel; // Modelo de equipo
import com.go2super.obj.game.ViewTeamModel; // Modelo de vista de equipo

// Importaciones de servicios
import com.go2super.service.BattleService; // Servicio de batalla
import com.go2super.service.CommanderService; // Servicio de comandante
import com.go2super.service.PacketService; // Servicio de paquetes
import com.go2super.service.UserService; // Servicio de usuario
import com.go2super.service.battle.Match; // Clase de coincidencia de batalla

// Importaciones de Lombok
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Column; // Anotación para columna de base de datos
import javax.persistence.Id; // Anotación para ID de entidad

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_fleets"
@Document(collection = "game_fleets")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa una flota de naves en el juego
public class Fleet {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único de la flota

    // Campos de identificación y ubicación
    private int shipTeamId; // ID del equipo de naves
    private int galaxyId; // ID de la galaxia donde está la flota

    // Campo único para GUID del usuario propietario
    @Column(unique = true)
    private int guid; // GUID único del usuario propietario
    private String name; // Nombre de la flota

    // Campos del comandante y recursos
    private int commanderId; // ID del comandante que lidera la flota
    private int he3; // Cantidad de Helio-3 (combustible)

    // Campos de configuración de la flota
    private int bodyId; // ID del cuerpo/casco de la flota
    private int rangeType; // Tipo de rango de la flota
    private int preferenceType; // Tipo de preferencia de la flota

    // Campos de posición en el mapa
    private int posX; // Coordenada X de posición
    private int posY; // Coordenada Y de posición

    // Campos de estado y dirección
    private int direction; // Dirección de la flota
    private boolean match; // Si está en una coincidencia/batalla

    // Campos de crecimiento y tecnologías
    private double additionalGrowth; // Crecimiento adicional
    private boolean forceTechs; // Forzar uso de tecnologías

    // Campos complejos de composición de la flota
    private ShipTeamBody fleetBody; // Cuerpo/composición de la flota
    private FleetMatch fleetMatch; // Información de coincidencia

    // Campos de transmisión e iniciador
    private FleetTransmission fleetTransmission; // Información de transmisión
    private FleetInitiator fleetInitiator; // Información del iniciador

    // Método para eliminar la flota del cache
    public void remove() { // Elimina la flota del cache de paquetes
        PacketService.getInstance().getFleetCache().delete(this);
    }

    // Método para guardar la flota en el cache
    public void save() { // Guarda la flota en el cache de paquetes
        PacketService.getInstance().getFleetCache().save(this);
    }

    // Método para obtener el comandante de la flota
    public Commander getCommander() { // Retorna el comandante por ID
        return CommanderService.getInstance().getCommander(commanderId);
    }

    // Método para obtener el ID del mejor casco del cuerpo de la flota
    public int bodyId() { // Retorna ID del mejor casco disponible
        return getFleetBody().getBestHull().getId();
    }

    // Método para calcular el máximo almacenamiento de He3 de la flota
    public int getMaxHe3() { // Retorna capacidad máxima de combustible
        int storage = 0; // Almacenamiento total acumulado

        for(ShipTeamNum teamNum : fleetBody.cells) { // Itera sobre cada celda de la flota
            if(teamNum.getShipModelId() < 0) // Si no hay modelo de nave
                continue; // Salta esta celda

            ShipModel model = PacketService.getShipModel(teamNum.getShipModelId()); // Obtiene modelo de nave

            if(model == null) // Si el modelo no existe
                continue; // Salta esta celda

            storage += (teamNum.getNum() * model.getFuelStorage()); // Suma capacidad por número de naves
        }

        return storage; // Retorna capacidad total de almacenamiento
    }

    // Método para obtener el suministro necesario (redondeado hacia arriba)
    public int getSupply() { // Retorna suministro como entero redondeado hacia arriba
        return (int) Math.ceil(getHe3Consumption()); // Redondea consumo hacia arriba
    }

    // Método para calcular el consumo de He3 de la flota
    public double getHe3Consumption() { // Retorna consumo total de combustible
        double result = 0; // Consumo total acumulado

        for(ShipTeamNum teamNum : fleetBody.cells) { // Itera sobre cada celda de la flota
            if(teamNum.getShipModelId() < 0) // Si no hay modelo de nave
                continue; // Salta esta celda

            ShipModel model = PacketService.getShipModel(teamNum.getShipModelId()); // Obtiene modelo de nave

            if(model == null) // Si el modelo no existe
                continue; // Salta esta celda

            double usage = (teamNum.getNum() * model.getFuelUsage()); // Calcula uso por número de naves
            result += usage; // Suma al consumo total
        }

        return result; // Retorna consumo total
    }

    // Método para obtener la tasa de transmisión máxima de la flota
    public double getTransmissionRate() { // Retorna la tasa de transmisión más alta
        double result = -1; // Inicializa con -1 para encontrar máximo

        for(ShipTeamNum teamNum : fleetBody.cells) { // Itera sobre celdas de la flota
            if(teamNum.getShipModelId() < 0) // Si no hay modelo de nave
                continue; // Salta

            ShipModel model = PacketService.getShipModel(teamNum.getShipModelId()); // Obtiene modelo
            if(model == null) continue; // Si no existe, salta

            double rate = model.getTransmissionRate(); // Obtiene tasa del modelo
            if(result == -1 || rate > result) result = rate; // Actualiza si es mayor
        }

        return result == -1 ? 0 : result; // Retorna 0 si no hay modelos, sino el máximo
    }

    // Método para obtener el inicio de transmisión máximo de la flota
    public double getTransmissionStart() { // Retorna el inicio de transmisión más alto
        double result = -1; // Inicializa con -1 para encontrar máximo

        for(ShipTeamNum teamNum : fleetBody.cells) { // Itera sobre celdas de la flota
            if(teamNum.getShipModelId() < 0) // Si no hay modelo de nave
                continue; // Salta

            ShipModel model = PacketService.getShipModel(teamNum.getShipModelId()); // Obtiene modelo
            if(model == null) continue; // Si no existe, salta

            double start = model.getTransmissionStart(); // Obtiene inicio del modelo
            if(result == -1 || start > result) result = start; // Actualiza si es mayor
        }

        return result == -1 ? 0 : result; // Retorna 0 si no hay modelos, sino el máximo
    }

    // Método para contar el número total de naves en la flota
    public int ships() { // Retorna número total de naves
        int number = 0; // Contador de naves
        for(ShipTeamNum cell : fleetBody.getCells()) // Itera sobre celdas
            if(cell.getShipModelId() >= 0) // Si hay modelo de nave válido
                number += cell.getNum(); // Suma el número de naves en la celda
        return number; // Retorna total de naves
    }

    // Método para obtener el modelo de vista del equipo
    public ViewTeamModel getViewTeamModel() { // Retorna modelo de vista del cuerpo de la flota
        return getFleetBody().getViewTeamModel();
    }

    // Método para obtener el modelo del equipo
    public TeamModel getTeamModel() { // Retorna modelo del cuerpo de la flota
        return getFleetBody().getTeamModel();
    }

    // Método para obtener la flota de batalla actual
    public BattleFleet getBattleFleet() { // Retorna la flota de batalla si existe
        Match match = getCurrentMatch(); // Obtiene la batalla actual
        if(match == null) return null; // Si no hay batalla, retorna null

        BattleFleet result = match.getBattleFleetByShipTeamId(shipTeamId); // Busca flota por ID de equipo
        if(result == null) return null; // Si no encuentra, retorna null

        return result; // Retorna la flota de batalla
    }

    // Método para obtener el usuario propietario de la flota
    public User getUser() { // Retorna el usuario por GUID
        User user = UserService.getInstance().getUserCache().findByGuid(this.getGuid());
        return user; // Retorna el usuario encontrado
    }

    // Método para obtener la batalla actual de la flota
    public Match getCurrentMatch() { // Retorna la batalla actual si existe
        Match match = BattleService.getInstance().getCurrent(this); // Busca batalla actual
        return match; // Retorna la batalla (puede ser null)
    }

    // Método para verificar si la flota está en transmisión
    public boolean isInTransmission() { // Retorna true si hay transmisión activa
        return getFleetTransmission() != null; // Verifica si existe objeto de transmisión
    }

    // Método para verificar si la flota está en una batalla
    public boolean isInMatch() { // Retorna true si está en batalla
        return getCurrentMatch() != null; // Verifica si hay batalla actual
    }

}
