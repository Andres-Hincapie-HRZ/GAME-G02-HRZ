// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Commander; // Entidad Commander
import com.go2super.database.repository.CommanderRepository; // Repositorio para Commander
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.List; // Interfaz List
import java.util.Optional; // Clase Optional
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class CommanderCache {

    // Campo estático final para el caché de comandantes, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Commander> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de comandantes
    private CommanderRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void CommanderCache(CommanderRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todos los comandantes del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todos los comandantes del caché
    public List<Commander> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar un comandante en el repositorio y añadirlo al caché si no existe
    public void save(Commander value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar un comandante (alias para remove)
    public void delete(Commander value) {
        remove(value);
    }

    // Método para eliminar un comandante del repositorio y del caché
    public void remove(Commander value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar un comandante por ID
    public Optional<Commander> findById(String id) {
        return cache.stream().filter(commander -> commander.getId().toString().equals(id)).findFirst();
    }

    // Método para encontrar un comandante por habilidad y ID de usuario
    public Commander findBySkillAndUserId(int skill, long userId) {
        return cache.stream().filter(commander -> commander.getSkill() == skill && commander.getUserId() == userId).findFirst().orElse(null);
    }

    // Método para encontrar un comandante por ID de comandante y ID de usuario
    public Commander findByCommanderIdAndUserId(int commanderId, long userId) {
        return cache.stream().filter(commander -> commander.getCommanderId() == commanderId && commander.getUserId() == userId).findFirst().orElse(null);
    }

    // Método para encontrar un comandante por ID de comandante
    public Commander findByCommanderId(int commanderId) {
        return cache.stream().filter(commander -> commander.getCommanderId() == commanderId).findFirst().orElse(null);
    }

    // Método para encontrar un comandante por ID de equipo de nave
    public Commander findByShipTeamId(int shipTeamId) {
        return cache.stream().filter(commander -> commander.getShipTeamId() == shipTeamId).findFirst().orElse(null);
    }

    // Método para encontrar comandantes por ID de usuario
    public List<Commander> findByUserId(long userId) {
        return cache.stream().filter(commander -> commander.getUserId() == userId).collect(Collectors.toList());
    }

    // Método para contar el número de comandantes en el caché
    public long count() {
        return cache.size();
    }

}
