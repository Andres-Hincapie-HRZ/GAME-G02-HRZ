// Paquete que contiene la clase, parte del módulo de DTOs para login de dashboard
package com.go2super.dto.dashboard.login;

// Importación de enum para rangos de dashboard
import com.go2super.database.entity.type.DashboardRank; // Enum de rangos de dashboard

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase DTO para representar datos de usuario logueado en dashboard
public class DashboardLoggedDTO {

    // Campos de información del usuario
    private String username; // Nombre de usuario del dashboard
    private String[] permissions; // Array de permisos del usuario

    // Campos de autorización
    private DashboardRank rank; // Rango del usuario en el dashboard
    private String token; // Token de sesión del dashboard

}
