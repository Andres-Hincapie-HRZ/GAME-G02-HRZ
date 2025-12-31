// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Sanction
import com.go2super.database.entity.Sanction; // Entidad de sanción

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad Sanction, extiende MongoRepository
public interface SanctionRepository extends MongoRepository<Sanction, String>, Serializable {

    // Método para obtener todas las sanciones
    List<Sanction> findAll(); // Retorna lista de todas las sanciones

    // Método para contar el total de sanciones
    long count(); // Retorna el número total de sanciones

}