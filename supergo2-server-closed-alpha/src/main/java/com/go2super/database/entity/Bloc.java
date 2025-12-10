// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

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

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_blocs"
@Document(collection = "game_blocs")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa un bloque o alianza en el juego
public class Bloc {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del bloque

    // Campos de información básica del bloque
    private Date creation; // Fecha de creación del bloque
    private String name; // Nombre del bloque
    private int organizer; // ID del organizador del bloque

    // Campos de código de invitación y expiración
    private String code; // Código de invitación para unirse al bloque
    private Date until; // Fecha hasta la que es válido el bloque

}
