// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Commander
import com.go2super.database.entity.Commander; // Entidad de comandante

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad Commander, extiende MongoRepository
public interface CommanderRepository extends MongoRepository<Commander, String>, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    Commander findTopByOrderByIdDesc(); // Retorna el comandante con ID más alto

    // Método para buscar comandante por habilidad y usuario
    Commander findBySkillAndUserId(int skill, long userId); // Retorna comandante por skill y userId

    // Método para buscar comandante por ID de comandante y usuario
    Commander findByCommanderIdAndUserId(int commanderId, long userId); // Retorna comandante por commanderId y userId

    // Método para buscar comandante por ID de comandante
    Commander findByCommanderId(int commanderId); // Retorna comandante por commanderId

    // Método para buscar comandante por ID de equipo de naves
    Commander findByShipTeamId(int shipTeamId); // Retorna comandante por shipTeamId

    // Método para obtener todos los comandantes de un usuario
    List<Commander> findByUserId(long userId); // Retorna lista de comandantes por userId

    // Método para contar el total de comandantes
    long count(); // Retorna el número total de comandantes

}