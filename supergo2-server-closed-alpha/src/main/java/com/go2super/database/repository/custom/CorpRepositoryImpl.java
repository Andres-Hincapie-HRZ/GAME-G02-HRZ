// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Corp
import com.go2super.database.entity.Corp; // Entidad de corporación

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Implementación de la interfaz CorpRepositoryCustom
public class CorpRepositoryImpl implements CorpRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para buscar corporación por GUID
    @Override
    public Corp findByGuid(int guid) {
        // Crea criterio para buscar en el campo anidado corp_members.members.guid
        Criteria criteria = Criteria.where("corp_members.members.guid").is(guid);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna resultado
        return mongoTemplate.findOne(query, Corp.class);
    }

    // Implementación del método para buscar corporaciones con mejoras
    public List<Corp> findByCorpUpgrade() {
        // Crea criterio para buscar corporaciones que tengan corp_upgrade no null
        Criteria criteria = Criteria.where("corp_upgrade").ne(null);
        // Crea consulta con el criterio
        Query query = new Query();
        query.addCriteria(criteria);
        // Ejecuta la consulta y retorna lista
        List<Corp> corps = mongoTemplate.find(query, Corp.class);
        return corps;
    }

    // Implementación del método para buscar corporación por nombre
    public Corp findByName(String name) {
        // Crea criterio para buscar por campo name
        Criteria criteria = Criteria.where("name").is(name);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna resultado
        return mongoTemplate.findOne(query, Corp.class);
    }

    // Implementación del método para buscar corporaciones reclutadoras por GUID
    public List<Corp> findRecruitsByGuid(int guid) {
        // Crea criterio para buscar en el campo anidado corp_members.recruits.guid
        Criteria criteria = Criteria.where("corp_members.recruits.guid").is(guid);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Corp.class);
    }

    // Implementación del método para buscar corporaciones que empiecen con un nombre
    public List<Corp> findByStartWithName(String name) {
        // Crea criterio para buscar nombres que empiecen con el string dado (regex)
        Criteria criteria = Criteria.where("name").regex("^" + name);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, Corp.class);
    }

}
