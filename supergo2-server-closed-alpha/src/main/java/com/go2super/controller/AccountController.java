// Declaración del paquete donde se encuentra esta clase
package com.go2super.controller;

// Importaciones necesarias para DTOs, respuestas, servicios y anotaciones de Spring
import com.go2super.dto.CreateUserDTO; // DTO para crear un usuario
import com.go2super.dto.response.BasicResponse; // Clase de respuesta básica
import com.go2super.service.AccountService; // Servicio para operaciones de cuenta
import com.go2super.service.LoginService; // Servicio para operaciones de login
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
@RequestMapping("${application.services.account}")
public class AccountController {

    // Inyección del servicio de login
    @Autowired
    private LoginService loginService;

    // Inyección del servicio de cuenta
    @Autowired
    private AccountService accountService;

    // Método GET mapeado a "/play/user/{userId}" para manejar la acción de "play" de un usuario
    @GetMapping("/play/user/{userId}")
    public BasicResponse play(@PathVariable("userId") long userId, HttpServletRequest request) {
        // Delega la lógica al servicio de cuenta y retorna la respuesta
        return accountService.play(userId, request);
    }

    // Método POST mapeado a "/create/user" para crear un nuevo usuario
    @PostMapping("/create/user")
    public BasicResponse create(@RequestBody CreateUserDTO dto, HttpServletRequest request) {
        // Delega la creación del usuario al servicio de cuenta y retorna la respuesta
        return accountService.createUser(dto, request);
    }

    // Método GET mapeado a "/list/user" para obtener la lista de usuarios
    @GetMapping("/list/user")
    public BasicResponse listOfUser(HttpServletRequest request) {
        // Delega la obtención de la lista de usuarios al servicio de cuenta y retorna la respuesta
        return accountService.listOfUser(request);
    }

}
