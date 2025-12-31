// Paquete que contiene la clase, parte del módulo de DTOs para hCaptcha
package com.go2super.dto.hcaptcha;

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar datos de verificación hCaptcha
public class Hcaptcha {

    // Campos para verificación de captcha
    private String secret; // Clave secreta de hCaptcha
    private String response; // Respuesta del usuario al captcha

}
