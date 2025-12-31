// Paquete que contiene la clase, parte del módulo de DTOs para transferencia de datos
package com.go2super.dto;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones de validación de Java
import javax.validation.constraints.Email; // Anotación para validar formato de email
import javax.validation.constraints.NotNull; // Anotación para validar que no sea null
import javax.validation.constraints.Size; // Anotación para validar tamaño de string

// Anotación Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
// Clase DTO para representar datos de cuenta de usuario
public class AccountDTO {

    // Campo de email con validaciones
    @Email // Valida que sea un formato de email válido
    @NotNull // No puede ser null
    private String email; // Dirección de email del usuario

    // Campo de nombre de usuario con validaciones
    @NotNull // No puede ser null
    @Size(min = 3, max = 18) // Tamaño mínimo 3, máximo 18 caracteres
    private String username; // Nombre de usuario

    // Campo de contraseña con validaciones
    @NotNull // No puede ser null
    @Size(min = 4, max = 26) // Tamaño mínimo 4, máximo 26 caracteres
    private String password; // Contraseña del usuario

    // Campos opcionales para captcha y OTP
    private String captcha; // Código captcha para verificación
    private String otp; // Código OTP para autenticación de dos factores

}
