// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.ShipModel; // Entidad ShipModel
import com.go2super.database.repository.ShipModelRepository; // Repositorio para ShipModel
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.List; // Interfaz List
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class ShipModelCache {

    // Campo estático final para el caché de modelos de nave, usando una lista thread-safe
    private static final CopyOnWriteArrayList<ShipModel> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de modelos de nave
    private ShipModelRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void ShipModelCache(ShipModelRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todos los modelos de nave del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todos los modelos de nave del caché
    public List<ShipModel> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar un modelo de nave en el repositorio y añadirlo al caché si no existe
    public void save(ShipModel value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar un modelo de nave (alias para remove)
    public void delete(ShipModel value) {
        remove(value);
    }

    // Método para eliminar un modelo de nave del repositorio y del caché
    public void remove(ShipModel value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar modelos de nave por GUID y estado de eliminación
    public List<ShipModel> findAllByGuidAndDeleted(int guid, boolean deleted) {
        return cache.stream().filter(shipModel -> shipModel.getGuid() == guid && shipModel.isDeleted() == deleted).collect(Collectors.toList());
    }

    // Método para encontrar un modelo de nave por ID de modelo de nave
    public ShipModel findByShipModelId(int shipModelId) {
        return cache.stream().filter(shipModel -> shipModel.getShipModelId() == shipModelId).findFirst().orElse(null);
    }

    // Método para encontrar un modelo de nave por GUID
    public ShipModel findByGuid(int guid) {
        return cache.stream().filter(shipModel -> shipModel.getGuid() == guid).findFirst().orElse(null);
    }

    // Método para encontrar modelos de nave por nombre y GUID
    public List<ShipModel> findAllByNameAndGuid(String name, int guid) {
        return cache.stream().filter(shipModel -> shipModel.getName().equals(name) && shipModel.getGuid() == guid).collect(Collectors.toList());
    }

    // Método para contar el número de modelos de nave en el caché
    public long count() {
        return cache.size();
    }

}
