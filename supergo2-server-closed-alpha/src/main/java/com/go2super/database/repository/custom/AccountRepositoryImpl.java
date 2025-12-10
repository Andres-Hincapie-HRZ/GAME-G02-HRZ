// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta de usuario

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.Optional; // Para valores opcionales

// Implementación de la interfaz AccountRepositoryCustom
public class AccountRepositoryImpl implements AccountRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para buscar cuenta por ID de Discord
    @Override
    public Optional<Account> findByDiscordId(String discordId) {
        // Crea criterio para buscar en el campo anidado discord_hook.discord_id
        Criteria criteria = Criteria.where("discord_hook.discord_id").is(discordId);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna opcional
        return Optional.ofNullable(mongoTemplate.findOne(query, Account.class));
    }

    // Implementación del método para buscar cuenta por código de Discord
    @Override
    public Optional<Account> findByDiscordCode(String discordCode) {
        // Crea criterio para buscar en el campo anidado discord_hook.discord_code
        Criteria criteria = Criteria.where("discord_hook.discord_code").is(discordCode);
        // Crea consulta con el criterio
        Query query = new Query(criteria);
        // Ejecuta la consulta y retorna opcional
        return Optional.ofNullable(mongoTemplate.findOne(query, Account.class));
    }

}
