// Paquete que contiene la clase, parte del módulo de DTOs para respuestas
package com.go2super.dto.response;

// Importaciones de Jackson para serialización JSON
import com.fasterxml.jackson.annotation.JsonInclude; // Anotación para incluir solo campos no null

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@JsonInclude(JsonInclude.Include.NON_NULL) // Incluye solo campos no null en JSON
// Clase DTO para representar respuesta básica del servidor
public class BasicResponse {

    // Campos de respuesta estándar
    private int code; // Código de respuesta (0=éxito, otros=códigos de error)
    private String message; // Mensaje descriptivo de la respuesta
    private String display = "Unknown error"; // Mensaje para mostrar al usuario
    private Object data; // Datos adicionales de la respuesta (puede ser cualquier objeto)

}
