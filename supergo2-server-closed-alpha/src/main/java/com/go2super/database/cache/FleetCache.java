// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Fleet; // Entidad Fleet
import com.go2super.database.repository.FleetRepository; // Repositorio para Fleet
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.Collection; // Interfaz Collection
import java.util.List; // Interfaz List
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class FleetCache {

    // Campo estático final para el caché de flotas, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Fleet> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de flotas
    private FleetRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void FleetCache(FleetRepository fleetRepository) {

        this.repository = fleetRepository;

        init();

    }

    // Método para inicializar el caché cargando todas las flotas del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todas las flotas del caché
    public List<Fleet> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una flota en el repositorio y añadirla al caché si no existe
    public void save(Fleet value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar una flota (alias para remove)
    public void delete(Fleet fleet) {
        remove(fleet);
    }

    // Método para eliminar una flota del repositorio y del caché
    public void remove(Fleet fleet) {
        repository.delete(fleet);
        cache.remove(fleet);
    }

    // Método para obtener flotas en guerra (con iniciador de flota)
    public List<Fleet> getInWarFleets() {
        return cache.stream().filter(fleet -> fleet.getFleetInitiator() != null).collect(Collectors.toList());
    }

    // Método para obtener flotas en transmisión
    public List<Fleet> getInTransmissionFleets() {
        return cache.stream().filter(fleet -> fleet.getFleetTransmission() != null).collect(Collectors.toList());
    }

    // Método para obtener flotas en radar por GUID y ID de galaxia destino
    public List<Fleet> getRadarFleets(int guid, int toGalaxyId) {
        return cache.stream().filter(fleet -> fleet.getGuid() == guid || (fleet.getFleetTransmission() != null && fleet.getFleetTransmission().getGalaxyId() == toGalaxyId)).collect(Collectors.toList());
    }

    // Método para obtener flotas en transmisión por GUID
    public List<Fleet> getInTransmissionFleets(int guid) {
        return cache.stream().filter(fleet -> fleet.getGuid() == guid && fleet.getFleetTransmission() != null).collect(Collectors.toList());
    }

    // Método para encontrar una flota por ID de comandante
    public Fleet findByCommanderId(int commanderId) {
        return cache.stream().filter(fleet -> fleet.getCommanderId() == commanderId).findFirst().orElse(null);
    }

    // Método para encontrar una flota por ID de equipo de nave
    public Fleet findByShipTeamId(int shipTeamId) {
        return cache.stream().filter(fleet -> fleet.getShipTeamId() == shipTeamId).findFirst().orElse(null);
    }

    // Método para encontrar flotas por colección de IDs de equipo de nave
    public List<Fleet> findByShipTeamId(Collection<Integer> shipTeamIds) {
        return cache.stream().filter(fleet -> shipTeamIds.contains(fleet.getShipTeamId())).collect(Collectors.toList());
    }

    // Método para encontrar todas las flotas por ID de galaxia
    public List<Fleet> findAllByGalaxyId(int galaxyId) {
        return cache.stream().filter(fleet -> fleet.getGalaxyId() == galaxyId).collect(Collectors.toList());
    }

    // Método para encontrar todas las flotas por ID de galaxia y estado de match
    public List<Fleet> findAllByGalaxyIdAndMatch(int galaxyId, boolean match) {
        return cache.stream().filter(fleet -> fleet.getGalaxyId() == galaxyId && fleet.isMatch() == match).collect(Collectors.toList());
    }

    // Método para encontrar todas las flotas por GUID
    public List<Fleet> findAllByGuid(int guid) {
        return cache.stream().filter(fleet -> fleet.getGuid() == guid).collect(Collectors.toList());
    }

    // Método para contar el número de flotas en el caché
    public long count() {
        return cache.size();
    }

}
