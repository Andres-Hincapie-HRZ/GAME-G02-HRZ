// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad RiskIncident
import com.go2super.database.entity.RiskIncident; // Entidad de incidente de riesgo

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.RiskIncidentRepositoryCustom; // Interfaz personalizada para RiskIncident

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad RiskIncident, extiende MongoRepository y la interfaz personalizada
public interface RiskIncidentRepository extends MongoRepository<RiskIncident, String>, RiskIncidentRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    RiskIncident findTopByOrderByIdDesc(); // Retorna el incidente con ID más alto

    // Método para buscar incidente por ID
    Optional<RiskIncident> findById(String id); // Retorna incidente opcional por id

    // Método para obtener todos los incidentes de riesgo
    List<RiskIncident> findAll(); // Retorna lista de todos los incidentes

    // Método para contar el total de incidentes
    long count(); // Retorna el número total de incidentes

}