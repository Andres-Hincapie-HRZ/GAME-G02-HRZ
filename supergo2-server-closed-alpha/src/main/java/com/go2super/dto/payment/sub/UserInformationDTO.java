// Paquete que contiene la clase, parte del submódulo de DTOs para pagos
package com.go2super.dto.payment.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar información detallada de usuario de Xsolla
public class UserInformationDTO {

    // Campos de identificación del usuario
    private int id; // ID único del usuario en Xsolla
    private String name; // Nombre del usuario
    private String level; // Nivel del usuario

}
