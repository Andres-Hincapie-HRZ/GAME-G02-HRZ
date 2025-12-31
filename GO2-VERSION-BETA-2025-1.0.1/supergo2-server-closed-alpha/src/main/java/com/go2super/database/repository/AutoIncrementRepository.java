// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad AutoIncrement
import com.go2super.database.entity.AutoIncrement; // Entidad de autoincremento

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad AutoIncrement, extiende MongoRepository
public interface AutoIncrementRepository extends MongoRepository<AutoIncrement, String>, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    AutoIncrement findTopByOrderByIdDesc(); // Retorna el registro con ID más alto

    // Método para obtener todos los registros de autoincremento
    List<AutoIncrement> findAll(); // Retorna lista de todos los registros

    // Método para buscar registro por nombre
    Optional<AutoIncrement> findByName(String name); // Retorna registro opcional por nombre

}