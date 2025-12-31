// Declaración del paquete donde se encuentra esta clase
package com.go2super.controller;

// Importaciones necesarias para DTOs, respuestas, servicios y anotaciones de Spring
import com.go2super.dto.AccountDTO; // DTO para cuenta de usuario
import com.go2super.dto.AccountLoginDTO; // DTO para login de cuenta
import com.go2super.dto.response.BasicResponse; // Clase de respuesta básica
import com.go2super.dto.stomp.Greeting; // DTO para saludo STOMP (no usado en este controlador)
import com.go2super.dto.stomp.HelloMessage; // DTO para mensaje de saludo STOMP (no usado en este controlador)
import com.go2super.service.LoginService; // Servicio para operaciones de login
import lombok.extern.slf4j.Slf4j; // Anotación para logging con SLF4J
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.messaging.handler.annotation.MessageMapping; // Anotación para mapeo de mensajes STOMP
import org.springframework.messaging.handler.annotation.SendTo; // Anotación para enviar mensajes STOMP
import org.springframework.web.bind.annotation.*; // Anotaciones para controladores REST
import org.springframework.web.util.HtmlUtils; // Utilidad para escapar HTML (no usada en este controlador)

import javax.validation.Valid; // Anotación para validación

// Anotación para habilitar logging en la clase
@Slf4j
// Anotación que indica que esta clase es un controlador REST
@RestController
// Anotación para permitir solicitudes CORS desde cualquier origen
@CrossOrigin(origins = "*")
// Anotación que define el mapeo base para las rutas de este controlador, usando una propiedad de configuración
@RequestMapping("${application.services.login}")
public class LoginController {

    // Inyección del servicio de login
    @Autowired
    private LoginService loginService;

    // Anotación adicional para CORS en este método específico
    @CrossOrigin(origins = "*")
    // Método POST mapeado a "/login/account" para login de cuenta
    @PostMapping("/login/account")
    public BasicResponse loginAccount(@Valid @RequestBody AccountLoginDTO dto) {
        // Delega el login al servicio y retorna la respuesta
        return loginService.login(dto);
    }

    // Método POST mapeado a "/register/account" para registro de cuenta
    @PostMapping("/register/account")
    public BasicResponse registerAccount(@Valid @RequestBody AccountDTO dto) {
        // Delega el registro al servicio y retorna la respuesta
        return loginService.register(dto);
    }

}