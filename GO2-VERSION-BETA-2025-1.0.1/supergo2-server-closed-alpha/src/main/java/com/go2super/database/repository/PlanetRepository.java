// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Planet
import com.go2super.database.entity.Planet; // Entidad de planeta

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.PlanetRepositoryCustom; // Interfaz personalizada para Planet

// Importación de utilidad GalaxyTile
import com.go2super.obj.utility.GalaxyTile; // Utilidad para coordenadas galácticas

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB
import org.springframework.data.mongodb.repository.Query; // Anotación para consultas personalizadas

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.Collection; // Interfaz de colección
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad Planet, extiende MongoRepository y la interfaz personalizada
public interface PlanetRepository extends MongoRepository<Planet, String>, PlanetRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    Planet findTopByOrderByIdDesc(); // Retorna el planeta con ID más alto

    // Método para buscar planeta por posición
    Planet findByPosition(GalaxyTile position); // Retorna planeta por posición

    // Método para buscar planeta por ID de usuario
    Planet findByUserId(long userId); // Retorna planeta por userId

    // Consulta personalizada para buscar planetas por lista de IDs
    @Query(value = "{ 'id' : {'$in' : ?0 } }") // Consulta MongoDB para IDs en lista
    List<Planet> findById(Collection<String> ids); // Retorna lista de planetas por ids

    // Método para obtener todos los planetas
    List<Planet> findAll(); // Retorna lista de todos los planetas

    // Método para contar el total de planetas
    long count(); // Retorna el número total de planetas

}