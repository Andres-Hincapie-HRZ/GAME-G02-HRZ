// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad UserIP
import com.go2super.database.entity.UserIP; // Entidad de IPs de usuario

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.UserIPRepositoryCustom; // Interfaz personalizada para UserIP

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad UserIP, extiende MongoRepository y la interfaz personalizada
public interface UserIPRepository extends MongoRepository<UserIP, String>, UserIPRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    UserIP findTopByOrderByIdDesc(); // Retorna el registro con ID más alto

    // Método para obtener todos los registros de IPs de usuario
    List<UserIP> findAll(); // Retorna lista de todos los registros

    // Método para contar el total de registros
    long count(); // Retorna el número total de registros

}