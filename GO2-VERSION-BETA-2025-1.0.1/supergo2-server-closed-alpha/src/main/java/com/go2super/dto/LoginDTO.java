// Paquete que contiene la clase, parte del módulo de DTOs para transferencia de datos
package com.go2super.dto;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotación Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
// Clase DTO para representar datos de login
public class LoginDTO {

    // Campos para autenticación
    private String email; // Email para login
    private String password; // Contraseña para login

}
