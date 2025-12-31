// Paquete que contiene la clase, parte del módulo de DTOs para respuestas
package com.go2super.dto.response;

// Importación de entidad para recursos de usuario
import com.go2super.database.entity.sub.UserResources; // Entidad de recursos del usuario

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar datos de usuario en respuestas
public class UserDTO {

    // Campo de identificación
    private long userId; // ID único del usuario

    // Campos de información básica
    private String username; // Nombre de usuario
    private String star; // Tipo de estrella del planeta
    private int ground; // Tipo de terreno del planeta (0=Desierto, 1=Nieve, 2=Llanuras)

    // Campo de recursos
    private UserResources resources; // Recursos del usuario (metal, oro, he3, etc.)

}
