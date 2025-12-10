// Paquete que contiene la clase, parte del módulo de DTOs para login de dashboard
package com.go2super.dto.dashboard.login;

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar datos de login de dashboard
public class DashboardLoginDTO {

    // Campos para autenticación en dashboard
    private String username; // Nombre de usuario para login
    private String password; // Contraseña para login

}