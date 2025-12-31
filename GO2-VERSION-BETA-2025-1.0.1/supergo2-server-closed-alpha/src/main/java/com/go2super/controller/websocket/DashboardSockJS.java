// Declaración del paquete donde se encuentra esta clase
package com.go2super.controller.websocket;

// Importaciones necesarias para anotaciones de Spring y WebSocket
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.messaging.handler.annotation.MessageMapping; // Anotación para mapeo de mensajes STOMP
import org.springframework.messaging.simp.SimpMessagingTemplate; // Plantilla para enviar mensajes a través de WebSocket

// Comentario indicando que esta clase podría ser un controlador (actualmente comentado)
// @Controller
public class DashboardSockJS {

    // Campo final para la plantilla de mensajería
    private final SimpMessagingTemplate template;

    // Constructor con inyección de dependencias para la plantilla de mensajería
    @Autowired
    DashboardSockJS(SimpMessagingTemplate template){
        this.template = template;
    }

    // Método mapeado a "/send/message" para manejar mensajes entrantes
    @MessageMapping("/send/message")
    public void sendMessage(String message) throws Exception {
        // Imprime el mensaje recibido en la consola
        System.out.println(message);
        // Convierte y envía el mensaje modificado al destino "/message"
        this.template.convertAndSend("/message",  message + " 1");
    }

}
