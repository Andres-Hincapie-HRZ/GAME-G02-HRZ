// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Bloc
import com.go2super.database.entity.Bloc; // Entidad de bloque/alianza

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz de repositorio para la entidad Bloc, extiende MongoRepository
public interface BlocRepository extends MongoRepository<Bloc, String>, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    Bloc findTopByOrderByIdDesc(); // Retorna el bloque con ID más alto

    // Método para obtener todos los bloques
    List<Bloc> findAll(); // Retorna lista de todos los bloques

    // Método para buscar bloque por nombre
    Optional<Bloc> findByName(String name); // Retorna bloque opcional por nombre

    // Método para buscar bloque por organizador
    Optional<Bloc> findByOrganizer(int organizer); // Retorna bloque opcional por ID de organizador

    // Método para buscar bloque por código de invitación
    Optional<Bloc> findByCode(String code); // Retorna bloque opcional por código

}