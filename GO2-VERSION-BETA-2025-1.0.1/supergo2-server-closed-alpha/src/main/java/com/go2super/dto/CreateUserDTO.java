// Paquete que contiene la clase, parte del módulo de DTOs para transferencia de datos
package com.go2super.dto;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotación Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
// Clase DTO para representar datos de creación de usuario
public class CreateUserDTO {

    // Campos para crear un nuevo usuario
    private String username; // Nombre de usuario a crear
    private int ground; // Tipo de terreno del planeta (0=Desierto, 1=Nieve, 2=Llanuras)

}
