// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta de usuario

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.AccountRepositoryCustom; // Interfaz personalizada para Account

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad Account, extiende MongoRepository y la interfaz personalizada
public interface AccountRepository extends MongoRepository<Account, String>, AccountRepositoryCustom, Serializable {

    // Método para obtener todas las cuentas
    List<Account> findAll(); // Retorna lista de todas las cuentas

    // Método para buscar cuenta por ID
    Optional<Account> findById(String id); // Retorna cuenta opcional por ID

    // Método para buscar cuenta por email
    Optional<Account> findByEmail(String email); // Retorna cuenta opcional por email

    // Método para buscar cuenta por nombre de usuario
    Optional<Account> findByUsername(String username); // Retorna cuenta opcional por username

}