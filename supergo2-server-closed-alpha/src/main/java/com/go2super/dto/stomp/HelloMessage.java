// Paquete que contiene la clase, parte del módulo de DTOs para STOMP
package com.go2super.dto.stomp;

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase DTO para representar mensaje de hola en STOMP
public class HelloMessage {

    // Campo de nombre del usuario
    private String name; // Nombre del usuario que envía el mensaje

}
