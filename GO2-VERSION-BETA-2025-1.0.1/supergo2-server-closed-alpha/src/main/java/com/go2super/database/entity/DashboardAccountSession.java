// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.annotation.Transient; // Campo no persistente en DB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Column; // Anotación para columna de base de datos
import javax.persistence.Id; // Anotación para ID de entidad

// Importación estándar de Java
import java.util.Date; // Clase para fechas

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_dashboard_account_sessions"
@Document(collection = "game_dashboard_account_sessions")
// Anotaciones Lombok para generar código boilerplate
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa una sesión de cuenta de dashboard administrativo
public class DashboardAccountSession {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único de la sesión de dashboard

    // Campo transitorio que referencia la cuenta, no se guarda en DB
    @Transient // No se persiste en la base de datos
    private DashboardAccount reference; // Referencia a la cuenta de dashboard asociada

    // Campos únicos para ID de cuenta y token de sesión
    @Column(unique = true) private String accountId; // ID de la cuenta de dashboard asociada
    @Column(unique = true) private String token; // Token único de la sesión

    // Campo que indica si la sesión ha expirado
    private boolean expired; // Estado de expiración de la sesión

    // Campos de timestamps para la sesión
    private Date loginDate; // Fecha de inicio de sesión
    private Date untilDate; // Fecha hasta la que es válida la sesión

    // Método para establecer la referencia a la cuenta y retornar la instancia (patrón fluent)
    public DashboardAccountSession reference(DashboardAccount account) { // Establece referencia a cuenta
        this.reference = account; // Asigna la cuenta
        return this; // Retorna this para encadenamiento
    }

}
