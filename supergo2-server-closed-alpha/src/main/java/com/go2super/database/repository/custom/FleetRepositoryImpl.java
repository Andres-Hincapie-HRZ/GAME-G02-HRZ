// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Fleet
import com.go2super.database.entity.Fleet; // Entidad de flota

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Implementación de la interfaz FleetRepositoryCustom
public class FleetRepositoryImpl implements FleetRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para obtener flotas en transmisión por GUID
    @Override
    public List<Fleet> getInTransmissionFleets(int guid) {
        // Crea criterio compuesto: fleetTransmission no null Y guid igual al parámetro
        Criteria criteria = new Criteria();
        criteria.andOperator(Criteria.where("fleetTransmission").ne(null), Criteria.where("guid").is(guid));
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Fleet.class);
    }

    // Implementación del método para obtener flotas en radar
    @Override
    public List<Fleet> getRadarFleets(int guid, int toGalaxyId) {
        // Crea criterio OR: guid propio O fleetTransmission.galaxyId igual a toGalaxyId
        Criteria criteria = new Criteria();
        criteria.orOperator(Criteria.where("guid").is(guid),
                            Criteria.where("fleetTransmission.galaxyId").is(toGalaxyId));
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Fleet.class);
    }

    // Implementación del método para obtener flotas en guerra
    @Override
    public List<Fleet> getInWarFleets() {
        // Crea criterio para buscar flotas con fleetInitiator no null
        Criteria criteria = Criteria.where("fleetInitiator").ne(null);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Fleet.class);
    }

    // Implementación del método para obtener todas las flotas en transmisión
    @Override
    public List<Fleet> getInTransmissionFleets() {
        // Crea criterio para buscar flotas con fleetTransmission no null
        Criteria criteria = Criteria.where("fleetTransmission").ne(null);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Fleet.class);
    }

}
