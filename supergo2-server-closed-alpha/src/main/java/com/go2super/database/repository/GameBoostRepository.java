// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad GameBoost
import com.go2super.database.entity.GameBoost; // Entidad de boost de juego

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad GameBoost, extiende MongoRepository
public interface GameBoostRepository extends MongoRepository<GameBoost, String>, Serializable {

    // Método para obtener todos los boosts de juego
    List<GameBoost> findAll(); // Retorna lista de todos los boosts

    // Método para buscar boost por tipo MIME
    GameBoost findByMimeType(int mimeType); // Retorna boost por mimeType

    // Método para buscar boost por ID de propiedad
    GameBoost findByPropId(int propId); // Retorna boost por propId

    // Método para contar el total de boosts
    long count(); // Retorna el número total de boosts

}