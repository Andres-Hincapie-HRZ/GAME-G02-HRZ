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

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_increments"
@Document(collection = "game_increments")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa un contador autoincremental para IDs únicos
public class AutoIncrement {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del registro de autoincremento

    // Campos para el nombre del contador y su valor actual
    private String name; // Nombre identificador del contador
    private int current; // Valor actual del contador

    // Campo que indica si este registro debe guardarse
    private boolean toSave; // Bandera para determinar si guardar cambios

    // Método para marcar el registro para guardar
    public void save() { // Marca el registro para ser guardado
        toSave = true; // Establece la bandera en true
    }

}
