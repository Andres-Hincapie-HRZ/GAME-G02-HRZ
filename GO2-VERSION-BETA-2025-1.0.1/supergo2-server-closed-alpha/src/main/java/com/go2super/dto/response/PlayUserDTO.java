// Paquete que contiene la clase, parte del módulo de DTOs para respuestas
package com.go2super.dto.response;

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar respuesta de usuario que juega
public class PlayUserDTO {

    // Campo de sesión
    private  String sessionKey; // Clave de sesión del usuario

    // Campo de identificación
    private long userId; // ID único del usuario

}
