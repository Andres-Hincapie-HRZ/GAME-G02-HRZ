// Paquete que contiene la clase, parte del módulo de DTOs para pagos
package com.go2super.dto.payment;

// Importación de sub-DTO para información de usuario
import com.go2super.dto.payment.sub.UserInformationDTO; // DTO de información de usuario de Xsolla

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar información de usuario de Xsolla
public class XsollaUserInfoDTO {

    // Campo de estado de la transacción
    private String status; // Estado de la verificación de usuario en Xsolla

    // Campo de información detallada del usuario
    private UserInformationDTO user; // Información detallada del usuario

}
