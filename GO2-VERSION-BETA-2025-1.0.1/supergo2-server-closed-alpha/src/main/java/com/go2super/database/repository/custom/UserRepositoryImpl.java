// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista
import java.util.stream.Collectors; // Operaciones de stream

// Implementación de la interfaz UserRepositoryCustom
public class UserRepositoryImpl implements UserRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para obtener usuarios con mejoras de naves en progreso
    public List<User> getByShipUpgrading() {
        // Crea criterio para buscar usuarios con factory no null en ships
        Criteria criteria = Criteria.where("game_ships.factory").ne(null);

        Query query = new Query();
        query.addCriteria(criteria);

        List<User> users = mongoTemplate.find(query, User.class); // Ejecuta consulta
        // Filtra usuarios que tienen factory no vacía
        users = users.stream().filter(user -> !user.getShips().getFactory().isEmpty()).collect(Collectors.toList());

        return users; // Retorna lista filtrada
    }

    // Implementación del método para obtener usuarios con mejoras tecnológicas en progreso
    public List<User> getByTechUpgrading() {
        // Crea criterio para buscar usuarios con upgrade no null en user_techs
        Criteria criteria = Criteria.where("game_user_techs.upgrade").ne(null);

        Query query = new Query();
        query.addCriteria(criteria);

        List<User> users = mongoTemplate.find(query, User.class); // Ejecuta consulta

        return users; // Retorna lista
    }

}
