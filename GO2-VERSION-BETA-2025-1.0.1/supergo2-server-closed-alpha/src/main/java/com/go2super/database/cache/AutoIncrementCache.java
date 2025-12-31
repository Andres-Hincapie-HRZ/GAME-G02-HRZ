// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.AutoIncrement; // Entidad AutoIncrement
import com.go2super.database.entity.User; // Entidad User (no usada en este archivo)
import com.go2super.database.repository.AutoIncrementRepository; // Repositorio para AutoIncrement
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.List; // Interfaz List
import java.util.Optional; // Clase Optional
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class AutoIncrementCache {

    // Campo estático final para el caché de auto-incrementos, usando una lista thread-safe
    private static final CopyOnWriteArrayList<AutoIncrement> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de auto-incrementos
    private AutoIncrementRepository repository;

    // Constructor con inyección de dependencias para el repositorio (nombre incorrecto del método)
    @Autowired
    public void CommanderCache(AutoIncrementRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todos los auto-incrementos del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todos los auto-incrementos del caché
    public List<AutoIncrement> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una lista de auto-incrementos en el repositorio y añadirlos al caché
    public void saveAll(List<AutoIncrement> values) {
        values = repository.saveAll(values);
        for(AutoIncrement value : values) {
            value.setToSave(false);
            if(!cache.contains(value)) cache.add(value);
        }
    }

    // Método para guardar un auto-incremento en el repositorio y añadirlo al caché si no existe
    public void save(AutoIncrement value) {
        value = repository.save(value);
        value.setToSave(false);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar un auto-incremento (alias para remove)
    public void delete(AutoIncrement value) {
        remove(value);
    }

    // Método para eliminar un auto-incremento del repositorio y del caché
    public void remove(AutoIncrement value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar un auto-incremento por ID
    public Optional<AutoIncrement> findById(String id) {
        return cache.stream().filter(autoIncrement -> autoIncrement.getId().toString().equals(id)).findFirst();
    }

    // Método para encontrar un auto-incremento por nombre
    public AutoIncrement findByName(String name) {
        return cache.stream().filter(autoIncrement -> name.equals(autoIncrement.getName())).findFirst().orElse(null);
    }

    // Método para encontrar auto-incrementos marcados para guardar
    public List<AutoIncrement> findToSave() {
        return cache.stream().filter(autoIncrement -> autoIncrement.isToSave()).collect(Collectors.toList());
    }

    // Método para contar el número de auto-incrementos en el caché
    public long count() {
        return cache.size();
    }

}
