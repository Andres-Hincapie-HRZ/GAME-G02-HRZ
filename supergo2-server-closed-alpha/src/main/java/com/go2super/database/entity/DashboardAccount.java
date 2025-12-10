// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importación de tipo de rango para dashboard
import com.go2super.database.entity.type.DashboardRank; // Enum para rangos de dashboard

// Importaciones de Lombok para generar código automáticamente
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

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_dashboard_accounts"
@Document(collection = "game_dashboard_accounts")
// Anotaciones Lombok para generar código boilerplate
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa una cuenta de dashboard administrativo
public class DashboardAccount {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único de la cuenta de dashboard

    // Campo único para email de la cuenta
    @Column(unique = true) private String email; // Email único para autenticación
    private String password; // Contraseña de la cuenta

    // Campo para el rango/permisos en el dashboard
    private DashboardRank rank; // Rango que determina permisos en el dashboard

}
