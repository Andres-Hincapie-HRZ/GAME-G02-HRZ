// Declaración del paquete donde se encuentra esta clase
package com.go2super.controller;

// Importaciones necesarias para DTOs, respuestas, servicios y anotaciones de Spring
import com.go2super.dto.dashboard.login.DashboardLoginDTO; // DTO para login del dashboard
import com.go2super.dto.response.BasicResponse; // Clase de respuesta básica
import com.go2super.service.DashboardLoginService; // Servicio para operaciones de login del dashboard
import lombok.extern.slf4j.Slf4j; // Anotación para logging con SLF4J
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.web.bind.annotation.*; // Anotaciones para controladores REST

import javax.servlet.http.HttpServletRequest; // Clase para manejar solicitudes HTTP

// Anotación para habilitar logging en la clase
@Slf4j
// Anotación que indica que esta clase es un controlador REST
@RestController
// Anotación para permitir solicitudes CORS desde cualquier origen
@CrossOrigin(origins = "*")
// Anotación que define el mapeo base para las rutas de este controlador, usando una propiedad de configuración
@RequestMapping("${application.services.dashboard}")
public class DashboardLoginController {

    // Inyección del servicio de login del dashboard
    @Autowired
    private DashboardLoginService dashboardLoginService;

    // Método POST mapeado a "/login" para manejar el login del dashboard
    @PostMapping("/login")
    public BasicResponse login(@RequestBody DashboardLoginDTO dto, HttpServletRequest request) {
        // Delega el login al servicio del dashboard y retorna la respuesta
        return dashboardLoginService.login(dto, request);
    }

}
