// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad DashboardAccount
import com.go2super.database.entity.DashboardAccount; // Entidad de cuenta de dashboard

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad DashboardAccount, extiende MongoRepository
public interface DashboardAccountRepository extends MongoRepository<DashboardAccount, String>, Serializable {

    // Método para obtener todas las cuentas de dashboard
    List<DashboardAccount> findAll(); // Retorna lista de todas las cuentas de dashboard

    // Método para buscar cuenta de dashboard por ID
    Optional<DashboardAccount> findById(String id); // Retorna cuenta opcional por ID

    // Método para buscar cuenta de dashboard por email
    Optional<DashboardAccount> findByEmail(String email); // Retorna cuenta opcional por email

}