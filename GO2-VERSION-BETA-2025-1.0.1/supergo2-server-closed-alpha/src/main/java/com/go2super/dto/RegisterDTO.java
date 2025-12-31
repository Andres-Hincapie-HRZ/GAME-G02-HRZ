// Paquete que contiene la clase, parte del módulo de DTOs para transferencia de datos
package com.go2super.dto;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotación Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
// Clase DTO para representar datos de registro de usuario
public class RegisterDTO {

    // Campos de configuración del usuario
    private int icon; // Ícono del usuario
    private int ground; // Tipo de terreno del planeta (0=Desierto, 1=Nieve, 2=Llanuras)

    // Campos de autenticación
    private String email; // Dirección de email
    private String username; // Nombre de usuario

    // Campo de seguridad
    private String password; // Contraseña

}
