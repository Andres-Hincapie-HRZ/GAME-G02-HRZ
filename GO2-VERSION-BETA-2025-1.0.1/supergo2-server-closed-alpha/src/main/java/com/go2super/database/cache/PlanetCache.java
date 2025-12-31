// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Planet; // Entidad Planet
import com.go2super.database.entity.User; // Entidad User (no usada en este archivo)
import com.go2super.database.entity.sub.HumaroidPlanet; // Subentidad HumaroidPlanet
import com.go2super.database.entity.sub.ResourcePlanet; // Subentidad ResourcePlanet
import com.go2super.database.entity.sub.UserPlanet; // Subentidad UserPlanet
import com.go2super.database.repository.PlanetRepository; // Repositorio para Planet
import com.go2super.obj.utility.GalaxyRegion; // Utilidad para región de galaxia
import com.go2super.obj.utility.GalaxyTile; // Utilidad para tile de galaxia
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.Collection; // Interfaz Collection
import java.util.List; // Interfaz List
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class PlanetCache {

    // Campo estático final para el caché de planetas, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Planet> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de planetas
    private PlanetRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void PlanetCache(PlanetRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todos los planetas del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todos los planetas del caché
    public List<Planet> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una colección de planetas en el repositorio y añadirlos al caché
    public void saveAll(Collection<Planet> values) {
        repository.saveAll(values);
        cache.addAll(values);
    }

    // Método para guardar un planeta en el repositorio y añadirlo al caché si no existe
    public void save(Planet value) {
        repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar un planeta (alias para remove)
    public void delete(Planet value) {
        remove(value);
    }

    // Método para eliminar un planeta del repositorio y del caché
    public void remove(Planet value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar un planeta por posición en la galaxia
    public Planet findByPosition(GalaxyTile position) {
        return cache.stream().filter(planet -> planet.getPosition().equals(position)).findFirst().orElse(null);
    }

    // Método para encontrar el planeta de usuario por objeto User
    public UserPlanet findUserPlanet(User user) {
        return findUserPlanet(user.getUserId());
    }

    // Método para encontrar el planeta de usuario por ID de usuario
    public UserPlanet findUserPlanet(long userId) {
        return cache.stream()
                .filter(UserPlanet.class::isInstance)
                .filter(planet -> planet.getUserId() == userId)
                .map(UserPlanet.class::cast)
                .findFirst().orElse(null);
    }

    // Método para encontrar un planeta por ID de usuario
    public Planet findByUserId(long userId) {
        return cache.stream().filter(planet -> planet.getUserId() == userId).findFirst().orElse(null);
    }

    // Método para encontrar planetas por colección de IDs
    public List<Planet> findById(Collection<String> ids) {
        return cache.stream().filter(planet -> ids.contains(planet.getId().toString())).collect(Collectors.toList());
    }

    // Método para encontrar posiciones tomadas por planetas
    public List<GalaxyTile> findTakenPositions() {
        return cache.stream().map(planet -> planet.getPosition()).collect(Collectors.toList());
    }

    // Método para encontrar planetas en una región de galaxia
    public List<Planet> findPlanets(GalaxyRegion region) {
        return cache.stream().filter(planet -> region.contains(planet.getPosition())).collect(Collectors.toList());
    }

    // Método para encontrar planetas humanoides
    public List<HumaroidPlanet> findHumaroidPlanets() {
        return cache.stream()
                .filter(HumaroidPlanet.class::isInstance)
                .map(HumaroidPlanet.class::cast).collect(Collectors.toList());
    }

    // Método para encontrar planetas de recursos
    public List<ResourcePlanet> findResourcePlanets() {
        return cache.stream()
                .filter(ResourcePlanet.class::isInstance)
                .map(ResourcePlanet.class::cast).collect(Collectors.toList());
    }

    // Método para encontrar planetas de usuario en una región de galaxia
    public List<UserPlanet> findUserPlanets(GalaxyRegion region) {
        return cache.stream()
                .filter(UserPlanet.class::isInstance)
                .filter(planet -> region.contains(planet.getPosition()))
                .map(UserPlanet.class::cast).collect(Collectors.toList());
    }

    // Método para encontrar planetas de recursos por ID de corporación
    public List<ResourcePlanet> findResourcePlanets(int corpId) {
        return cache.stream()
                .filter(ResourcePlanet.class::isInstance)
                .map(ResourcePlanet.class::cast)
                .filter(resourcePlanet -> resourcePlanet.getCurrentCorp() == corpId).collect(Collectors.toList());
    }

    // Método para encontrar el planeta superior por orden de ID descendente
    public Planet findTopByOrderByIdDesc() {
        return cache.get(cache.size() - 1);
    }

    // Método para contar el número de planetas en el caché
    public long count() {
        return cache.size();
    }

}
