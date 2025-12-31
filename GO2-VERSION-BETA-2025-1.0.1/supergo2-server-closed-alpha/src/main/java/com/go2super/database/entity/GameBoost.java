// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importación de tipo de bono
import com.go2super.obj.type.BonusType; // Enum para tipos de bonos

// Importaciones de Lombok
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Id; // Anotación para ID de entidad

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_boosts"
@Document(collection = "game_boosts")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa un boost/mejora temporal en el juego
public class GameBoost {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del boost

    // Campos de configuración del boost
    private int propId; // ID de la propiedad/item que otorga el boost
    private int mimeType; // Tipo MIME (posiblemente para recursos multimedia)
    private List<BonusType> bonuses = new ArrayList<>(); // Lista de tipos de bonos que otorga

    // Campo de duración
    private int seconds; // Duración del boost en segundos

}
