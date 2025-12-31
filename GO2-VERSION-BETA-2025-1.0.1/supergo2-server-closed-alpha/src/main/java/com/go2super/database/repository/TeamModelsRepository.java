// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad TeamModelSlot
import com.go2super.database.entity.TeamModelSlot; // Entidad de slot de modelo de equipo

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad TeamModelSlot, extiende MongoRepository
public interface TeamModelsRepository extends MongoRepository<TeamModelSlot, String>, Serializable {

    // Método para obtener todos los slots de modelos de equipo
    List<TeamModelSlot> findAll(); // Retorna lista de todos los slots

    // Método para buscar slot por GUID e ID de índice
    TeamModelSlot findByGuidAndIndexId(int guid, int indexId); // Retorna slot por guid e indexId

    // Método para obtener slots por GUID
    List<TeamModelSlot> findByGuid(int guid); // Retorna lista de slots por guid

}