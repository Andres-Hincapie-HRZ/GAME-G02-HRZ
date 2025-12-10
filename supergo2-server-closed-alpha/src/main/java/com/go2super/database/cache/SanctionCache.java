// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Sanction; // Entidad Sanction
import com.go2super.database.repository.SanctionRepository; // Repositorio para Sanction
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.List; // Interfaz List
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe

// Anotación que marca esta clase como un componente de Spring
@Component
public class SanctionCache {

    // Campo estático final para el caché de sanciones, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Sanction> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de sanciones
    private SanctionRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void SanctionCache(SanctionRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todas las sanciones del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todas las sanciones del caché
    public List<Sanction> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una sanción en el repositorio y añadirla al caché si no existe
    public void save(Sanction value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar una sanción (alias para remove)
    public void delete(Sanction value) {
        remove(value);
    }

    // Método para eliminar una sanción del repositorio y del caché
    public void remove(Sanction value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para contar el número de sanciones en el caché
    public long count() {
        return cache.size();
    }

}
