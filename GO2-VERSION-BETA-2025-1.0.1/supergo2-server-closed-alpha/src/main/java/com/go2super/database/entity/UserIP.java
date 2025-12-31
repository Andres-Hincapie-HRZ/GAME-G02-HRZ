// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importación de subentidad para información de IP
import com.go2super.database.entity.sub.UserIPInfo; // Entidad para información de IP del usuario

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Id; // Anotación para ID de entidad

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_users_ips"
@Document(collection = "game_users_ips")
// Anotaciones Lombok para generar código boilerplate
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa las direcciones IP asociadas a un usuario
public class UserIP {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del registro de IPs del usuario

    private String email; // Email del usuario
    private String accountId; // ID de la cuenta del usuario
    private String accountName; // Nombre de la cuenta del usuario

    private List<UserIPInfo> ips = new ArrayList<>(); // Lista de información de IPs asociadas al usuario

}
