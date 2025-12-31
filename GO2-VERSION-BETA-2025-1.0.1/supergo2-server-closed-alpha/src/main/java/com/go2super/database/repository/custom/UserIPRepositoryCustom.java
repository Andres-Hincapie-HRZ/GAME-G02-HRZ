// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de entidad UserIP
import com.go2super.database.entity.UserIP; // Entidad de IPs de usuario

// Importación de clase GameServerReceiver
import com.go2super.server.GameServerReceiver; // Receptor del servidor de juego

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Interfaz personalizada para consultas específicas de UserIPRepository
public interface UserIPRepositoryCustom {

    // Método para actualizar IP de usuario
    void updateUserIP(Account account, User user, GameServerReceiver serverReceiver); // Actualiza registro de IP

    // Método para verificar conflicto de IP
    boolean hasIPConflict(Account account, String ip); // Verifica si hay conflicto de IP con otras cuentas

    // Método para obtener conflictos de IP
    List<UserIP> getIPConflict(String ip); // Retorna lista de registros con IP conflictiva

}