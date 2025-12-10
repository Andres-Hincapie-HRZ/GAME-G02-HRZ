// Declaración del paquete donde se encuentra esta clase
package com.go2super.controller;

// Importaciones necesarias para JSON, DTOs, respuestas, servicios y anotaciones de Spring
import com.fasterxml.jackson.databind.JsonNode; // Clase para manejar nodos JSON
import com.go2super.dto.CreateUserDTO; // DTO para crear usuario (no usado en este controlador)
import com.go2super.dto.response.BasicResponse; // Clase de respuesta básica (no usada en este controlador)
import com.go2super.service.AccountService; // Servicio de cuenta (no usado en este controlador)
import com.go2super.service.raids.PaymentService; // Servicio para pagos
import lombok.extern.slf4j.Slf4j; // Anotación para logging con SLF4J
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.http.ResponseEntity; // Clase para respuestas HTTP
import org.springframework.web.bind.annotation.*; // Anotaciones para controladores REST

import javax.servlet.http.HttpServletRequest; // Clase para manejar solicitudes HTTP

// Anotación para habilitar logging en la clase
@Slf4j
// Anotación que indica que esta clase es un controlador REST
@RestController
// Anotación para permitir solicitudes CORS desde cualquier origen
@CrossOrigin(origins = "*")
// Anotación que define el mapeo base para las rutas de este controlador, usando una propiedad de configuración
@RequestMapping("${application.services.payment}")
public class PaymentController {

    // Inyección del servicio de pagos
    @Autowired
    private PaymentService paymentService;

    // Método POST mapeado a "/xsolla" para procesar pagos de Xsolla
    @PostMapping("/xsolla")
    public ResponseEntity create(@RequestBody JsonNode body, HttpServletRequest request) {
        // Delega el procesamiento del pago de Xsolla al servicio y retorna la respuesta HTTP
        return paymentService.paymentXsolla(body, request);
    }

}
