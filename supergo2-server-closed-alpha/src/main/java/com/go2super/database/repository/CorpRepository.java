// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Corp
import com.go2super.database.entity.Corp; // Entidad de corporación

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.CorpRepositoryCustom; // Interfaz personalizada para Corp

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB
import org.springframework.data.mongodb.repository.Query; // Anotación para consultas personalizadas

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad Corp, extiende MongoRepository y la interfaz personalizada
public interface CorpRepository extends MongoRepository<Corp, String>, CorpRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    Corp findTopByOrderByIdDesc(); // Retorna la corporación con ID más alto

    // Método para obtener todas las corporaciones
    List<Corp> findAll(); // Retorna lista de todas las corporaciones

    // Método para buscar corporaciones por ID de bloque
    List<Corp> findByBlocId(String blocId); // Retorna lista de corporaciones por blocId

    // Consulta personalizada para buscar corporaciones por lista de IDs de corp
    @Query(value = "{ 'corpId' : {'$in' : ?0 } }") // Consulta MongoDB para IDs en lista
    List<Corp> findByCorpId(List<Integer> corpIds); // Retorna lista de corporaciones por corpIds

    // Método para buscar corporación por ID de corp
    Corp findByCorpId(int corpId); // Retorna corporación por corpId

    // Método para contar el total de corporaciones
    long count(); // Retorna el número total de corporaciones

    // Método para buscar corporación por acrónimo
    Corp findByAcronym(String acronym); // Retorna corporación por acrónimo

}