// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad Fleet
import com.go2super.database.entity.Fleet; // Entidad de flota

// Importación de objeto de juego CreateShipInfo
import com.go2super.obj.game.CreateShipInfo; // Información para crear naves

// Importación de objeto de juego ShipTeamNum
import com.go2super.obj.game.ShipTeamNum; // Número de naves en equipo

// Importación de servicio PacketService
import com.go2super.service.PacketService; // Servicio de paquetes

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que maneja las naves de un usuario
public class UserShips {

    public List<ShipTeamNum> ships = new ArrayList<>(); // Lista de naves almacenadas
    public List<FactoryShip> factory = new ArrayList<>(); // Lista de naves en fabricación

    public List<BruiseShip> repair = new ArrayList<>(); // Lista de naves en reparación
    public FactoryShip repairFactory; // Fábrica de reparación

    // Método para obtener lista de naves (inicializa si null)
    public List<ShipTeamNum> getShips() {
        if(ships == null) // Si es null
            ships = new ArrayList<>(); // Inicializa nueva lista
        return ships; // Retorna la lista
    }

    // Método para obtener lista de fábrica (inicializa si null)
    public List<FactoryShip> getFactory() {
        if(factory == null) // Si es null
            factory = new ArrayList<>(); // Inicializa nueva lista
        return factory; // Retorna la lista
    }

    // Método para obtener ShipTeamNum por ID de modelo
    public ShipTeamNum getShipTeamNum(int shipModelId) {
        for(ShipTeamNum shipTeamNum : ships) // Itera sobre naves
            if(shipTeamNum.getShipModelId() == shipModelId) // Si coincide ID
                return shipTeamNum; // Retorna el equipo
        return null; // Retorna null si no encuentra
    }

    // Método para obtener información de fábrica como lista de CreateShipInfo
    public List<CreateShipInfo> getFactoryAsBuffer() {
        List<CreateShipInfo> infos = new ArrayList<>(); // Lista resultado

        for(FactoryShip factoryShip : getFactory()) // Itera sobre naves en fábrica
            infos.add(factoryShip.packet()); // Agrega info de paquete

        return infos; // Retorna lista de infos
    }

    // Método para agregar naves a reparación
    public void addRepair(int shipModelId, int num) {
        if(repair == null) repair = new ArrayList<>(); // Inicializa si null

        Optional<BruiseShip> optionalBruiseShip = repair.stream().filter(ship -> ship.getShipModelId() == shipModelId).findFirst(); // Busca nave existente
        if(!optionalBruiseShip.isPresent()) repair.add(new BruiseShip(shipModelId, num)); // Si no existe, agrega nueva
        else optionalBruiseShip.get().setNum(optionalBruiseShip.get().getNum() + num); // Sino, incrementa cantidad
    }

    // Método para verificar si tiene diseño de nave
    public boolean hasDesign(int shipModel) {
        return getFactory().stream().anyMatch(factoryShip -> factoryShip.getShipModelId() == shipModel); // Verifica si existe en fábrica
    }

    // Método para fabricar naves
    public boolean fabricate(int shipModel, int num, double buildTime) {
        if(getFactory().size() >= 5) // Si fábrica llena (máximo 5)
            return false; // Retorna false

        getFactory().add(FactoryShip.of(shipModel, num, buildTime)); // Agrega a fábrica
        return true; // Retorna true
    }

    // Método para agregar naves al almacenamiento
    public void addShip(int shipModel, int num) {
        for(ShipTeamNum shipTeamNum : getShips()) // Itera sobre naves almacenadas
            if(shipTeamNum.getShipModelId() == shipModel) { // Si coincide modelo
                shipTeamNum.setNum(shipTeamNum.getNum() + num); // Incrementa cantidad
                return; // Sale
            }
        getShips().add(new ShipTeamNum(shipModel, num)); // Sino, agrega nueva entrada
    }

    // Método para remover naves del almacenamiento
    public boolean removeShip(int shipModel, int num) {
        for(ShipTeamNum shipTeamNum : getShips()) // Itera sobre naves almacenadas
            if(shipTeamNum.getShipModelId() == shipModel) { // Si coincide modelo
                if(shipTeamNum.getNum() < num) // Si no tiene suficientes
                    return false; // Retorna false

                shipTeamNum.setNum(shipTeamNum.getNum() - num); // Reduce cantidad
                if(shipTeamNum.getNum() == 0) getShips().remove(shipTeamNum); // Si llega a 0, remueve

                return true; // Retorna true
            }

        return false; // Retorna false si no encontró el modelo
    }

    // Método para contar naves almacenadas
    public int countStoredShips() {
        int result = 0; // Contador

        for(ShipTeamNum team : getShips()) // Itera sobre equipos de naves
            result += team.getNum(); // Suma cantidad

        return result; // Retorna total
    }

    // Método para contar naves totales (almacenadas + en flotas)
    public int countTotalShips(int guid) {
        int result = 0; // Contador

        for(Fleet fleet : PacketService.getInstance().getFleetCache().findAllByGuid(guid)) // Itera sobre flotas del usuario
            for(ShipTeamNum team : fleet.getFleetBody().getCells()) // Itera sobre celdas de flota
                if(team.getShipModelId() != -1) // Si hay nave válida
                    result += team.getNum(); // Suma cantidad

        return countStoredShips() + result; // Retorna total almacenadas + en flotas
    }

}
