// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias
import com.go2super.database.entity.ShipModel;
import com.go2super.database.repository.ShipModelRepository;
import com.go2super.utility.GlueList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;                                    // ← AÑADIDO
import java.util.concurrent.ConcurrentHashMap;           // ← AÑADIDO
import java.util.stream.Collectors;

@Component
public class ShipModelCache {

    // ← CAMBIADO: Usar ConcurrentHashMap en lugar de CopyOnWriteArrayList
    // La key es shipModelId para búsqueda eficiente y evitar duplicados
    private static final Map<Integer, ShipModel> cache = new ConcurrentHashMap<>();

    private ShipModelRepository repository;

    @Autowired
    public void ShipModelCache(ShipModelRepository repository) {
        this.repository = repository;
        init();
    }

    // Método para inicializar el caché
    public void init() {
        // ← CAMBIADO: Cargar todos los modelos indexados por shipModelId
        List<ShipModel> allModels = repository.findAll();
        for (ShipModel model : allModels) {
            cache.put(model.getShipModelId(), model);
        }
        System.out.println("[ShipModelCache] Inicializado con " + cache.size() + " modelos");
    }

    // Método para obtener todos los modelos de nave del caché
    public List<ShipModel> findAll() {
        return new GlueList<>(cache.values());  // ← CAMBIADO
    }

    // ← CORREGIDO: Método save que actualiza correctamente el caché
    public void save(ShipModel value) {
        // Guardar en la base de datos
        ShipModel savedModel = repository.save(value);

        // ← AÑADIDO: Log para debugging
        System.out.println("[ShipModelCache.save] Guardando modelo:");
        System.out.println("  - shipModelId: " + savedModel.getShipModelId());
        System.out.println("  - bodyId: " + savedModel.getBodyId());
        System.out.println("  - name: " + savedModel.getName());
        System.out.println("  - guid: " + savedModel.getGuid());

        // ← CORREGIDO: Siempre actualizar/insertar en el caché usando shipModelId como key
        cache.put(savedModel.getShipModelId(), savedModel);

        System.out.println("[ShipModelCache.save] Modelo guardado en caché. Total en caché: " + cache.size());
    }

    // Método para eliminar un modelo de nave
    public void delete(ShipModel value) {
        remove(value);
    }

    // Método para eliminar un modelo de nave del repositorio y del caché
    public void remove(ShipModel value) {
        repository.delete(value);
        cache.remove(value.getShipModelId());  // ← CAMBIADO
    }

    // Método para encontrar modelos de nave por GUID y estado de eliminación
    public List<ShipModel> findAllByGuidAndDeleted(int guid, boolean deleted) {
        return cache.values().stream()  // ← CAMBIADO
                .filter(shipModel -> shipModel.getGuid() == guid && shipModel.isDeleted() == deleted)
                .collect(Collectors.toList());
    }

    // ← CORREGIDO: Búsqueda directa por key, más eficiente y sin duplicados
    public ShipModel findByShipModelId(int shipModelId) {
        ShipModel model = cache.get(shipModelId);

        // ← AÑADIDO: Log para debugging
        if (model != null) {
            System.out.println("[ShipModelCache.findByShipModelId] Encontrado modelo " + shipModelId + ":");
            System.out.println("  - bodyId: " + model.getBodyId());
            System.out.println("  - name: " + model.getName());
        } else {
            System.out.println("[ShipModelCache.findByShipModelId] NO encontrado modelo " + shipModelId);
        }

        return model;
    }

    // Método para encontrar un modelo de nave por GUID
    public ShipModel findByGuid(int guid) {
        return cache.values().stream()  // ← CAMBIADO
                .filter(shipModel -> shipModel.getGuid() == guid)
                .findFirst()
                .orElse(null);
    }

    // Método para encontrar modelos de nave por nombre y GUID
    public List<ShipModel> findAllByNameAndGuid(String name, int guid) {
        return cache.values().stream()  // ← CAMBIADO
                .filter(shipModel -> shipModel.getName().equals(name) && shipModel.getGuid() == guid)
                .collect(Collectors.toList());
    }

    // Método para contar el número de modelos de nave en el caché
    public long count() {
        return cache.size();
    }

    // ← AÑADIDO: Método para recargar el caché desde la base de datos
    public void reload() {
        cache.clear();
        init();
    }

    // ← AÑADIDO: Método para verificar si existe un modelo
    public boolean exists(int shipModelId) {
        return cache.containsKey(shipModelId);
    }

}
