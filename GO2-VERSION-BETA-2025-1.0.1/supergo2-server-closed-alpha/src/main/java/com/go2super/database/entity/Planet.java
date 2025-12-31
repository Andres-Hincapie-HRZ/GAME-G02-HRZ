// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de tipos y utilidades
import com.go2super.database.entity.type.PlanetType; // Enum para tipos de planeta
import com.go2super.obj.utility.GalaxyTile; // Utilidad para coordenadas galácticas
import com.go2super.service.BattleService; // Servicio de batalla
import com.go2super.service.GalaxyService; // Servicio de galaxia
import com.go2super.service.PacketService; // Servicio de paquetes
import com.go2super.service.battle.match.WarMatch; // Clase de batalla de guerra

// Importaciones de Lombok
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Column; // Anotación para columna de base de datos
import javax.persistence.Id; // Anotación para ID de entidad

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_planets"
@Document(collection = "game_planets")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa un planeta en el juego
public class Planet {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del planeta

    // Campo único para ID del usuario propietario
    @Column(unique = true) // Restricción de unicidad
    private long userId; // ID del usuario que controla el planeta

    // Campos de propiedades del planeta
    private PlanetType type; // Tipo de planeta (ej. normal, capital, etc.)
    private GalaxyTile position; // Posición en la galaxia

    // Método para obtener todas las flotas en la galaxia del planeta
    public List<Fleet> getFleets() { // Retorna lista de flotas en la galaxia
        return PacketService.getInstance().getFleetCache().findAllByGalaxyId(position.galaxyId());
    }

    // Método para verificar si el planeta está en guerra
    public boolean isInWar() { // Retorna true si hay guerra activa y no pausada
        Optional<WarMatch> optionalWar = BattleService.getInstance().getWar(this); // Busca guerra
        return optionalWar.isPresent() && !optionalWar.get().isPause(); // Verifica presencia y no pausa
    }

    // Método para guardar el planeta en el cache
    public void save() { // Guarda el planeta en el cache de galaxia
        GalaxyService.getInstance().getPlanetCache().save(this);
    }

}
