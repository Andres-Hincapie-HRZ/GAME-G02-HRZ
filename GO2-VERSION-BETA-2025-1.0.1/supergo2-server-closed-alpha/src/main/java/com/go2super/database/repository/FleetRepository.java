// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Fleet
import com.go2super.database.entity.Fleet; // Entidad de flota

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.FleetRepositoryCustom; // Interfaz personalizada para Fleet

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad Fleet, extiende MongoRepository y la interfaz personalizada
public interface FleetRepository extends MongoRepository<Fleet, String>, FleetRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    Fleet findTopByOrderByIdDesc(); // Retorna la flota con ID más alto

    // Método para buscar flota por ID de comandante
    Fleet findByCommanderId(int commanderId); // Retorna flota por commanderId

    // Método para buscar flota por ID de equipo de naves
    Fleet findByShipTeamId(int shipTeamId); // Retorna flota por shipTeamId

    // Método para obtener todas las flotas
    List<Fleet> findAll(); // Retorna lista de todas las flotas

    // Método para obtener flotas por ID de galaxia
    List<Fleet> findAllByGalaxyId(int galaxyId); // Retorna lista de flotas por galaxyId

    // Método para obtener flotas por ID de galaxia y estado de coincidencia
    List<Fleet> findAllByGalaxyIdAndMatch(int galaxyId, boolean match); // Retorna lista de flotas por galaxyId y match

    // Método para obtener flotas por GUID
    List<Fleet> findAllByGuid(int guid); // Retorna lista de flotas por guid

    // Método para contar el total de flotas
    long count(); // Retorna el número total de flotas

}