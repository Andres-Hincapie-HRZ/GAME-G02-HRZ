// Declaración del paquete donde se encuentra esta clase
package com.go2super.controller;

// Importaciones necesarias para respuestas, servicios y anotaciones de Spring
import com.go2super.dto.response.BasicResponse; // Clase de respuesta básica
import com.go2super.service.MetricService; // Servicio para métricas
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
@RequestMapping("${application.services.metric}")
public class MetricController {

    // Inyección del servicio de métricas
    @Autowired
    private MetricService service;

    // Método GET mapeado a "/online" para obtener jugadores en línea
    @GetMapping("/online")
    public BasicResponse online(HttpServletRequest request) {
        // Delega la obtención de jugadores en línea al servicio y retorna la respuesta
        return service.onlinePlayers(request);
    }

    // Método GET mapeado a "/last/planet" para obtener el último planeta (método nombrado incorrectamente como "create")
    @GetMapping("/last/planet")
    public BasicResponse create(HttpServletRequest request) {
        // Delega la obtención del último planeta al servicio y retorna la respuesta
        return service.lastPlanet(request);
    }

    // Método GET mapeado a "/patch" para obtener información del parche
    @GetMapping("/patch")
    public BasicResponse patch(HttpServletRequest request) {
        // Delega la obtención de información del parche al servicio y retorna la respuesta
        return service.patch(request);
    }

}
