// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Interfaz personalizada para consultas específicas de UserRepository
public interface UserRepositoryCustom {

    // Método para obtener usuarios con mejoras de naves en progreso
    List<User> getByTechUpgrading(); // Retorna lista de usuarios con mejoras tecnológicas activas

    // Método para obtener usuarios con mejoras de naves en progreso
    List<User> getByShipUpgrading(); // Retorna lista de usuarios con mejoras de naves activas

}
