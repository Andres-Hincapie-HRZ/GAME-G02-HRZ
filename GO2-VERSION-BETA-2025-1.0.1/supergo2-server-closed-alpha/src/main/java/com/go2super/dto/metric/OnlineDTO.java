// Paquete que contiene la clase, parte del módulo de DTOs para métricas
package com.go2super.dto.metric;

// Importaciones de Jackson para serialización JSON
import com.fasterxml.jackson.annotation.JsonInclude; // Anotación para incluir solo campos no null

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@JsonInclude(JsonInclude.Include.NON_NULL) // Incluye solo campos no null en JSON
// Clase DTO para representar datos de usuarios online
public class OnlineDTO {

    // Campo de conteo
    private int online; // Número de usuarios actualmente online

}
