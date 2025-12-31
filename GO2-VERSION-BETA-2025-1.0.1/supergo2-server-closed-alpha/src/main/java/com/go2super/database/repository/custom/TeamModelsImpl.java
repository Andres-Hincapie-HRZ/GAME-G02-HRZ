// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad TeamModelSlot
import com.go2super.database.entity.TeamModelSlot; // Entidad de slot de modelo de equipo

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Implementación de la interfaz TeamModelsCustomRepository
public class TeamModelsImpl implements TeamModelsCustomRepository{

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para buscar slot por GUID e ID de índice
    public TeamModelSlot findByGuidAndIndexId(int guid, int indexId) {
        // Crea criterios para GUID e indexId
        Criteria criteriaGuid = Criteria.where("guid").is(guid);
        Criteria criteriaIndexId = Criteria.where("indexId").is(indexId);

        // Crea consulta y agrega criterios
        Query query = new Query();
        query.addCriteria(criteriaGuid);
        query.addCriteria(criteriaIndexId);

        // Ejecuta la consulta y retorna resultado
        return mongoTemplate.findOne(query, TeamModelSlot.class);
    }

}
