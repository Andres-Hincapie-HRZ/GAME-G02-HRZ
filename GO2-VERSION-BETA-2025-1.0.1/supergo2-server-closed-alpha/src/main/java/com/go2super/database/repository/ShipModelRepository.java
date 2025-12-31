// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad ShipModel
import com.go2super.database.entity.ShipModel; // Entidad de modelo de nave

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad ShipModel, extiende MongoRepository
public interface ShipModelRepository extends MongoRepository<ShipModel, String>, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    ShipModel findTopByOrderByIdDesc(); // Retorna el modelo con ID más alto

    // Método para obtener todos los modelos de naves
    List<ShipModel> findAll(); // Retorna lista de todos los modelos

    // Método para obtener modelos por GUID y estado eliminado
    List<ShipModel> findAllByGuidAndDeleted(int guid, boolean deleted); // Retorna lista de modelos por guid y deleted

    // Método para buscar modelo por ID de modelo de nave
    ShipModel findByShipModelId(int shipModelId); // Retorna modelo por shipModelId

    // Método para buscar modelo por GUID
    ShipModel findByGuid(int guid); // Retorna modelo por guid

    // Método para obtener modelos por nombre y GUID
    List<ShipModel> findAllByNameAndGuid(String name, int guid); // Retorna lista de modelos por name y guid

    // Método para contar el total de modelos
    long count(); // Retorna el número total de modelos

}