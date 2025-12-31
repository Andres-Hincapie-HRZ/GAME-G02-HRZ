// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Planet
import com.go2super.database.entity.Planet; // Entidad de planeta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importaciones de subentidades
import com.go2super.database.entity.sub.ResourcePlanet; // Entidad de planeta de recursos
import com.go2super.database.entity.sub.UserPlanet; // Entidad de planeta de usuario

// Importación de utilidad GalaxyRegion
import com.go2super.obj.utility.GalaxyRegion; // Utilidad para región galáctica

// Importación de utilidad GalaxyTile
import com.go2super.obj.utility.GalaxyTile; // Utilidad para coordenadas galácticas

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista
import java.util.stream.Collectors; // Para operaciones de stream

// Implementación de la interfaz PlanetRepositoryCustom
public class PlanetRepositoryImpl implements PlanetRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para obtener planeta de usuario
    @Override
    public UserPlanet getUserPlanet(User user) {
        return getUserPlanet(user.getUserId()); // Delega al método por ID
    }

    // Implementación del método para obtener planeta de usuario por ID
    @Override
    public UserPlanet getUserPlanet(long userId) {
        // Crea criterio para buscar por userId
        Criteria criteria = Criteria.where("userId").is(userId);
        // Crea consulta con el criterio y restricción a UserPlanet
        Query query = new Query(criteria).restrict(UserPlanet.class);
        // Ejecuta la consulta y retorna resultado
        return mongoTemplate.findOne(query, UserPlanet.class);
    }

    // Implementación del método para obtener posiciones tomadas
    @Override
    public List<GalaxyTile> getTakenPositions() {
        // Crea consulta vacía (todos los documentos)
        Criteria criteria = new Criteria();
        // Crea consulta con restricción a UserPlanet y selección de campo position
        Query query = new Query(criteria).restrict(UserPlanet.class);
        query.fields().include("position");
        // Ejecuta consulta y mapea posiciones
        return mongoTemplate.find(query, UserPlanet.class).stream().map(UserPlanet::getPosition).collect(Collectors.toList());
    }

    // Implementación del método para obtener planetas en región galáctica
    @Override
    public List<Planet> getPlanets(GalaxyRegion galaxyRegion) {
        // Obtiene coordenadas mínima y máxima de la región
        GalaxyTile min = galaxyRegion.getMinBoundingTile();
        GalaxyTile max = galaxyRegion.getMaxBoundingTile();
        // Crea criterio compuesto para coordenadas X e Y dentro del rango
        Criteria criteria = new Criteria();
        criteria.andOperator(
                Criteria.where("position.x")
                        .gte(min.getX())
                        .lte(max.getX()),
                Criteria.where("position.y")
                        .gte(min.getY())
                        .lte(max.getY()));
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Planet.class);
    }

    // Implementación del método para obtener planetas de recursos
    @Override
    public List<ResourcePlanet> findResourcePlanets() {
        // Crea consulta vacía
        Criteria criteria = new Criteria();
        // Crea consulta con restricción a ResourcePlanet
        Query query = new Query(criteria).restrict(ResourcePlanet.class);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, ResourcePlanet.class);
    }

    // Implementación del método para obtener planetas de usuario en región galáctica
    @Override
    public List<UserPlanet> getUserPlanets(GalaxyRegion galaxyRegion) {
        // Obtiene coordenadas mínima y máxima de la región
        GalaxyTile min = galaxyRegion.getMinBoundingTile();
        GalaxyTile max = galaxyRegion.getMaxBoundingTile();
        // Crea criterio compuesto para coordenadas X e Y dentro del rango
        Criteria criteria = new Criteria();
        criteria.andOperator(
                Criteria.where("position.x")
                        .gte(min.getX())
                        .lte(max.getX()),
                Criteria.where("position.y")
                        .gte(min.getY())
                        .lte(max.getY()));
        // Crea consulta con el criterio y restricción a UserPlanet
        Query query = new Query(criteria);
        query.restrict(UserPlanet.class);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, UserPlanet.class);
    }

    // Implementación del método para obtener planetas de recursos por ID de corporación
    @Override
    public List<ResourcePlanet> findResourcePlanets(int corpId) {
        // Crea criterio para buscar por currentCorp
        Criteria criteria = Criteria.where("currentCorp").is(corpId);
        // Crea consulta con el criterio y restricción a ResourcePlanet
        Query query = new Query(criteria);
        query.restrict(ResourcePlanet.class);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, ResourcePlanet.class);
    }

}
