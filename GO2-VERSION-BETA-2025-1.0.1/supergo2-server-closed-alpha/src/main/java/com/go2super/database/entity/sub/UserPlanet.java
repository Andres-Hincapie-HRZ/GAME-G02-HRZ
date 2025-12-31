// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad padre Planet
import com.go2super.database.entity.Planet; // Entidad base de planeta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de enum PlanetType
import com.go2super.database.entity.type.PlanetType; // Tipo de planeta

// Importación de utilidad GalaxyTile
import com.go2super.obj.utility.GalaxyTile; // Coordenadas galácticas

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importaciones de datos de granjas
import com.go2super.resources.data.FarmLandData; // Datos de tierras agrícolas
import com.go2super.resources.json.FarmLandsJson; // JSON de tierras agrícolas

// Importación de servicio UserService
import com.go2super.service.UserService; // Servicio de usuarios

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.Date; // Clase para fechas
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa el planeta principal de un usuario
public class UserPlanet extends Planet { // Extiende Planet

    private String userObjectId; // ID del objeto usuario en MongoDB

    private int starFace; // Cara estelar del planeta
    private Date untilFlag; // Fecha hasta la que dura la bandera

    // Constructor vacío
    public UserPlanet() {
    }

    // Constructor con parámetros
    public UserPlanet(String userObjectId, long userId, GalaxyTile galaxyTile, int starFace) {
        this.userObjectId = userObjectId; // Asigna ID del usuario
        this.starFace = starFace; // Asigna cara estelar
        this.untilFlag = new Date(); // Fecha actual para la bandera

        this.setUserId(userId); // Establece ID del usuario
        this.setType(PlanetType.USER_PLANET); // Tipo de planeta de usuario
        this.setPosition(galaxyTile); // Posición en galaxia
    }

    // Método para obtener tierra agrícola adyacente por ID de galaxia
    public FarmLandData getAdjacentByGalaxyId(int galaxyId) {
        List<FarmLandData> farmLands = getAdjacentFarmLands(); // Obtiene tierras agrícolas adyacentes

        for(int i = 0; i < 12; i++) { // Itera sobre posibles IDs (0-11)
            if(farmLands.size() < i) // Si no hay suficientes tierras
                break; // Sale del loop

            for(FarmLandData farmLand : farmLands) // Itera sobre tierras agrícolas
                if(farmLand.getId() == i) { // Si coincide ID
                    GalaxyTile farmLandTile = farmLand.calculateTile(this); // Calcula posición de la tierra
                    if(farmLandTile.galaxyId() == galaxyId) // Si coincide galaxia
                        return farmLand; // Retorna la tierra encontrada
                }
        }

        return null; // Retorna null si no encuentra
    }

    // Método para obtener lista de tierras agrícolas adyacentes
    public List<FarmLandData> getAdjacentFarmLands() {
        List<FarmLandData> result = new ArrayList<>(); // Lista resultado
        Optional<User> optionalUser = getUser(); // Obtiene usuario
        if(!optionalUser.isPresent()) return result; // Si no hay usuario, retorna lista vacía

        FarmLandsJson farmLandsJson = ResourceManager.getFarmLands(); // Obtiene configuración de tierras
        int spaceStationLevel = optionalUser.get().getSpaceStationLevel(); // Obtiene nivel de estación espacial

        for(FarmLandData farmLandData : farmLandsJson.getFarmLands()) // Itera sobre todas las tierras
            if(spaceStationLevel >= farmLandData.getStation()) // Si el nivel de estación permite la tierra
                result.add(farmLandData); // Agrega a resultado

        return result; // Retorna lista de tierras disponibles
    }

    // Método para obtener el usuario propietario del planeta
    public Optional<User> getUser() {
        Optional<User> optionalUser = UserService.getInstance().getUserCache().findById(userObjectId); // Busca usuario por ID
        return optionalUser; // Retorna opcional del usuario
    }

}
