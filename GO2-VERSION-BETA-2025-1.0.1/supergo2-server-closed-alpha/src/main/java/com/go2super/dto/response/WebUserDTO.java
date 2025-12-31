// Paquete que contiene la clase, parte del módulo de DTOs para respuestas
package com.go2super.dto.response;

// Importación de enum para rangos de usuario
import com.go2super.database.entity.type.UserRank; // Enum de rangos de usuario

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar datos de usuario web
public class WebUserDTO {

    // Campos de autenticación
    private String email; // Dirección de email del usuario
    private String username; // Nombre de usuario

    // Campos de privilegios
    private int vip; // Nivel VIP del usuario
    private UserRank rank; // Rango del usuario en el sistema

    // Campo de token
    private String token; // Token de sesión web

    // Campo de límites
    private int maxPlanet; // Número máximo de planetas permitidos

}
