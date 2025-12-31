// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Account; // Entidad Account
import com.go2super.database.repository.AccountRepository; // Repositorio para Account
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.List; // Interfaz List
import java.util.Optional; // Clase Optional
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe

// Anotación que marca esta clase como un componente de Spring
@Component
public class AccountCache {

    // Campo estático final para el caché de cuentas, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Account> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de cuentas
    private AccountRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void AccountCache(AccountRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todas las cuentas del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todas las cuentas del caché
    public List<Account> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una cuenta en el repositorio y añadirla al caché si no existe
    public void save(Account value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar una cuenta (alias para remove)
    public void delete(Account value) {
        remove(value);
    }

    // Método para eliminar una cuenta del repositorio y del caché
    public void remove(Account value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar una cuenta por ID
    public Optional<Account> findById(String id) {
        return cache.stream().filter(account -> id.equals(account.getId().toString())).findFirst();
    }

    // Método para encontrar una cuenta por email
    public Optional<Account> findByEmail(String email) {
        return cache.stream().filter(account -> email.equals(account.getEmail())).findFirst();
    }

    // Método para encontrar una cuenta por nombre de usuario
    public Optional<Account> findByUsername(String username) {
        return cache.stream().filter(account -> username.equals(account.getUsername())).findFirst();
    }

    // Método para encontrar una cuenta por ID de Discord
    public Optional<Account> findByDiscordId(String discordId) {
        return cache.stream()
                .filter(account -> account.getDiscordHook() != null && account.getDiscordHook().getDiscordId() != null && discordId.equals(account.getDiscordHook().getDiscordId()))
                .findFirst();
    }

    // Método para encontrar una cuenta por código de Discord
    public Optional<Account> findByDiscordCode(String discordCode) {
        return cache.stream()
                .filter(account -> account.getDiscordHook() != null && account.getDiscordHook().getDiscordCode() != null && discordCode.equals(account.getDiscordHook().getDiscordCode()))
                .findFirst();
    }

    // Método para contar el número de cuentas en el caché
    public long count() {
        return cache.size();
    }

}
