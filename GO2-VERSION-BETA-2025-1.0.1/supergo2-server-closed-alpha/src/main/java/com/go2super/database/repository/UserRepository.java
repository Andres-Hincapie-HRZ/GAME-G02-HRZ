// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.UserRepositoryCustom; // Interfaz personalizada para User

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB
import org.springframework.data.mongodb.repository.Query; // Anotación para consultas personalizadas

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.Collection; // Interfaz de colección
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad User, extiende MongoRepository y la interfaz personalizada
public interface UserRepository extends MongoRepository<User, String>, UserRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    User findTopByOrderByIdDesc(); // Retorna el usuario con ID más alto

    // Método para obtener todos los usuarios
    List<User> findAll(); // Retorna lista de todos los usuarios

    // Método para buscar usuarios por ID de cuenta
    List<User> findByAccountId(String accountId); // Retorna lista de usuarios por accountId

    // Consulta personalizada para buscar usuarios por lista de GUIDs
    @Query(value = "{ 'guid' : {'$in' : ?0 } }") // Consulta MongoDB para GUIDs en lista
    List<User> findByGuid(Collection<Integer> guids); // Retorna lista de usuarios por guids

    // Método para buscar usuario por GUID
    User findByGuid(int guid); // Retorna usuario por guid

    // Método para buscar usuarios por ID de corporación
    List<User> findByConsortiaId(int ConsortiaId); // Retorna lista de usuarios por consortiaId

    // Método para buscar usuario por ID de usuario
    User findByUserId(long userId); // Retorna usuario por userId

    // Método para buscar usuario por nombre de usuario
    Optional<User> findByUsername(String username); // Retorna usuario opcional por username

}