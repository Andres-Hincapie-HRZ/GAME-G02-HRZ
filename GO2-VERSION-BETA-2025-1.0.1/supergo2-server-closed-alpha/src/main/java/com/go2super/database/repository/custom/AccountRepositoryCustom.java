// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta de usuario

// Importaciones estándar de Java
import java.util.Optional; // Para valores opcionales

// Interfaz personalizada para consultas específicas de AccountRepository
public interface AccountRepositoryCustom {

    // Método para buscar cuenta por código de Discord
    Optional<Account> findByDiscordCode(String discordCode); // Retorna cuenta opcional por discordCode

    // Método para buscar cuenta por ID de Discord
    Optional<Account> findByDiscordId(String discordId); // Retorna cuenta opcional por discordId

}