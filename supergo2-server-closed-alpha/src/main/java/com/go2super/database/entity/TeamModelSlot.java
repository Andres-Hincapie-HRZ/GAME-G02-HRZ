// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importación de objeto de juego TeamModel
import com.go2super.obj.game.TeamModel;

// Importación de servicio TeamModelService
import com.go2super.service.TeamModelService;

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Id; // Anotación para ID de entidad

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_team_models"
@Document(collection = "game_team_models")
// Anotaciones Lombok para generar código boilerplate
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa un slot de modelo de equipo en el juego
public class TeamModelSlot {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del slot de modelo de equipo

    private int guid; // GUID del usuario propietario
    private int indexId; // ID de índice del slot
    private TeamModel teamModel; // Modelo de equipo almacenado

    // Método para guardar el slot en el repositorio
    public void save() { // Guarda el slot de modelo de equipo
        TeamModelService.getInstance().getTeamModelsRepository().save(this); // Delega al servicio
    }

}
