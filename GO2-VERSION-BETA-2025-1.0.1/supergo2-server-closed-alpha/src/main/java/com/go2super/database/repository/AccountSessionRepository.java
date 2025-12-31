// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad AccountSession
import com.go2super.database.entity.AccountSession; // Entidad de sesión de cuenta

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad AccountSession, extiende MongoRepository
public interface AccountSessionRepository extends MongoRepository<AccountSession, String>, Serializable {

    // Método para obtener todas las sesiones de cuenta
    List<AccountSession> findAll(); // Retorna lista de todas las sesiones

    // Método para buscar sesiones por ID de cuenta
    List<AccountSession> findByAccountId(String accountId); // Retorna lista de sesiones por accountId

    // Método para buscar sesión por token
    Optional<AccountSession> findByToken(String token); // Retorna sesión opcional por token

}