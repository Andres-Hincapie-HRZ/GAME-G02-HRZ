// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de entidades relacionadas con Discord y tipos de cuenta
import com.go2super.database.entity.sub.DiscordHook; // Entidad para hook de Discord
import com.go2super.database.entity.type.AccountStatus; // Enum para estado de cuenta
import com.go2super.database.entity.type.UserRank; // Enum para rango de usuario

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB y JPA
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB
import org.springframework.data.mongodb.core.mapping.Field; // Anotación para campo personalizado

// Importaciones de JPA
import javax.persistence.Column; // Anotación para columna de base de datos
import javax.persistence.Id; // Anotación para ID de entidad

// Importación estándar de Java
import java.util.Date; // Clase para fechas

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_accounts"
@Document(collection = "game_accounts")
// Anotaciones Lombok para generar código boilerplate
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor sin argumentos
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa una cuenta de usuario en el sistema
public class Account {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único de la cuenta

    // Campos únicos para nombre de usuario y email
    @Column(unique = true) private String username; // Nombre de usuario único
    @Column(unique = true) private String email; // Email único

    // Campo para hook de Discord, mapeado con nombre personalizado en DB
    @Field(name = "discord_hook") private DiscordHook discordHook; // Configuración de Discord

    // Campos de autenticación y red
    private String password; // Contraseña del usuario
    private String lastIp; // Última IP de conexión

    // Campos de estado y privilegios
    private int vip; // Nivel VIP del usuario
    private Date banUntil; // Fecha hasta la que está baneado
    private Boolean maintenanceBypass; // Si puede saltar mantenimiento

    // Campos de timestamps
    private Date lastConnection; // Última conexión
    private Date registerDate; // Fecha de registro

    // Campos de estado y rango
    private AccountStatus accountStatus; // Estado actual de la cuenta
    private UserRank userRank; // Rango del usuario en el sistema

}
