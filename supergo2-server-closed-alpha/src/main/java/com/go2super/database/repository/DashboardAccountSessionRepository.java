// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad DashboardAccountSession
import com.go2super.database.entity.DashboardAccountSession; // Entidad de sesión de cuenta de dashboard

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad DashboardAccountSession, extiende MongoRepository
public interface DashboardAccountSessionRepository extends MongoRepository<DashboardAccountSession, String>, Serializable {

    // Método para obtener todas las sesiones de dashboard
    List<DashboardAccountSession> findAll(); // Retorna lista de todas las sesiones

    // Método para buscar sesiones por ID de cuenta y estado expirado
    List<DashboardAccountSession> findByAccountIdAndExpired(String accountId, boolean expired); // Retorna lista de sesiones por accountId y expired

    // Método para buscar sesión por token
    Optional<DashboardAccountSession> findByToken(String token); // Retorna sesión opcional por token

}