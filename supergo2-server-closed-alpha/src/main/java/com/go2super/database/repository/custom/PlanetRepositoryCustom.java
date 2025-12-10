// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Planet
import com.go2super.database.entity.Planet; // Entidad de planeta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importaciones de subentidades
import com.go2super.database.entity.sub.ResourcePlanet; // Entidad de planeta de recursos
import com.go2super.database.entity.sub.UserPlanet; // Entidad de planeta de usuario

// Importación de utilidad GalaxyRegion
import com.go2super.obj.utility.GalaxyRegion; // Utilidad para región galáctica

// Importación de utilidad GalaxyTile
import com.go2super.obj.utility.GalaxyTile; // Utilidad para coordenadas galácticas

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Interfaz personalizada para consultas específicas de PlanetRepository
public interface PlanetRepositoryCustom {

    // Método para obtener planeta de usuario
    UserPlanet getUserPlanet(User user); // Retorna planeta de usuario por objeto User

    // Método para obtener planeta de usuario por ID
    UserPlanet getUserPlanet(long userId); // Retorna planeta de usuario por userId

    // Método para obtener posiciones tomadas
    List<GalaxyTile> getTakenPositions(); // Retorna lista de posiciones ocupadas

    // Método para obtener planetas en una región galáctica
    List<Planet> getPlanets(GalaxyRegion galaxyRegion); // Retorna lista de planetas en región

    // Método para obtener planetas de recursos
    List<ResourcePlanet> findResourcePlanets(); // Retorna lista de planetas de recursos

    // Método para obtener planetas de recursos por ID de corporación
    List<ResourcePlanet> findResourcePlanets(int corpId); // Retorna lista de planetas de recursos por corpId

    // Método para obtener planetas de usuario en región galáctica
    List<UserPlanet> getUserPlanets(GalaxyRegion galaxyRegion); // Retorna lista de planetas de usuario en región

}
