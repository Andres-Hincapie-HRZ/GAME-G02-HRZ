// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importación de tipo de sanción
import com.go2super.database.entity.type.SanctionType; // Enum para tipos de sanción

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Id; // Anotación para ID de entidad

// Importación estándar de Java
import java.util.Date; // Clase para fechas

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_sanctions"
@Document(collection = "game_sanctions")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa una sanción aplicada a un usuario
public class Sanction {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único de la sanción

    // Campo para el tipo de sanción
    private SanctionType sanctionType; // Tipo de sanción aplicada

    // Campos descriptivos de la sanción
    private String label; // Etiqueta/descripción de la sanción
    private Date creation; // Fecha de creación de la sanción

    // Campos del staff que aplicó la sanción
    private String staffAccountId; // ID de cuenta del staff
    private String staffName; // Nombre del staff
    private int staffGuid; // GUID del staff

    // Campos del usuario sancionado
    private String userAccountId; // ID de cuenta del usuario
    private String userName; // Nombre del usuario
    private int userGuid; // GUID del usuario

}
