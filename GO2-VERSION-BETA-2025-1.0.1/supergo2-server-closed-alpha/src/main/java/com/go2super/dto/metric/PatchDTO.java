// Paquete que contiene la clase, parte del módulo de DTOs para métricas
package com.go2super.dto.metric;

// Importaciones de Jackson para serialización JSON
import com.fasterxml.jackson.annotation.JsonInclude; // Anotación para incluir solo campos no null

// Importación de utilidad GameCell (no usada en este DTO)
import com.go2super.obj.utility.GameCell; // Utilidad para celdas del juego

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@JsonInclude(JsonInclude.Include.NON_NULL) // Incluye solo campos no null en JSON
// Clase DTO para representar datos de parche/version
public class PatchDTO {

    // Campo de versión
    private String patch; // Versión del parche del juego

}
