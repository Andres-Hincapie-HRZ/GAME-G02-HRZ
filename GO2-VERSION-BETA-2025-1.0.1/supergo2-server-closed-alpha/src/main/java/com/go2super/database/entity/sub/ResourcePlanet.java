// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad Corp
import com.go2super.database.entity.Corp; // Entidad de corporación

// Importación de entidad padre Planet
import com.go2super.database.entity.Planet; // Entidad base de planeta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de enum PlanetType
import com.go2super.database.entity.type.PlanetType; // Tipo de planeta

// Importación de enum SpaceFortType
import com.go2super.database.entity.type.SpaceFortType; // Tipo de fortificación espacial

// Importación de utilidad GalaxyTile
import com.go2super.obj.utility.GalaxyTile; // Coordenadas galácticas

// Importaciones de metadatos de fortificación
import com.go2super.resources.data.meta.FortificationEffectMeta; // Metadatos de efecto de fortificación
import com.go2super.resources.data.meta.FortificationLevelMeta; // Metadatos de nivel de fortificación

// Importaciones de servicios
import com.go2super.service.CorpService; // Servicio de corporaciones
import com.go2super.service.GalaxyService; // Servicio de galaxia
import com.go2super.service.UserService; // Servicio de usuarios

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas
import java.util.LinkedList; // Lista enlazada
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un planeta de recursos (RBP - Resource Based Planet)
public class ResourcePlanet extends Planet { // Extiende Planet

    private int currentCorp; // ID de la corporación que controla actualmente (-1 si ninguna)
    private int currentLevel; // Nivel actual del planeta

    private boolean fight; // Si hay pelea activa en el planeta

    private boolean peace; // Si está en estado de paz
    private Date statusTime; // Tiempo hasta el que dura el estado actual

    private RBPBuildings rbpBuildings = RBPBuildings.builder() // Edificios del planeta
            .buildings(new LinkedList<>())
            .build();

    // Constructor vacío
    public ResourcePlanet() {
    }

    // Constructor con coordenadas y usuario
    public ResourcePlanet(GalaxyTile galaxyTile, long userId) {
        this.currentCorp = -1; // Sin corporación inicialmente
        this.currentLevel = 0; // Nivel inicial
        this.fight = false; // Sin pelea inicialmente
        this.statusTime = new Date(); // Estado actual desde ahora

        this.setUserId(userId); // Establece usuario propietario
        this.setType(PlanetType.RESOURCES_PLANET); // Tipo de planeta de recursos
        this.setPosition(galaxyTile); // Posición en galaxia
    }

    // Método para obtener máximo número de flotas permitidas
    public int getMaxFleets() {
        RBPBuilding spaceStation = getSpaceStation(); // Obtiene estación espacial

        FortificationLevelMeta levelMeta = spaceStation.getLevelData(); // Obtiene metadatos del nivel
        if(levelMeta == null) return 0; // Si no hay datos, retorna 0

        Optional<FortificationEffectMeta> optionalEffectMeta = levelMeta.getEffect("shipNum"); // Busca efecto de número de naves
        if(optionalEffectMeta.isEmpty()) return 0; // Si no hay efecto, retorna 0

        return (int) optionalEffectMeta.get().getValue(); // Retorna valor del efecto
    }

    // Método para obtener nivel de la estación espacial
    public int getSSLevel() {
        RBPBuilding spaceStation = getSpaceStation(); // Obtiene estación espacial
        return spaceStation.getLevelId(); // Retorna nivel
    }

    // Método para obtener la estación espacial
    public RBPBuilding getSpaceStation() {
        return getBuilding(SpaceFortType.RBP_SPACE_STATION.getDataId()).get(); // Obtiene edificio de estación espacial
    }

    // Método para obtener edificio por ID
    public Optional<RBPBuilding> getBuilding(int buildingId) {
        return getBuildings().getBuildings().stream().filter(rbpBuilding -> rbpBuilding.getBuildingId() == buildingId).findFirst(); // Filtra y retorna primer match
    }

    // Método para obtener colección de edificios
    public RBPBuildings getBuildings() {
        if(rbpBuildings == null) // Si es null
            rbpBuildings = RBPBuildings.builder().buildings(new LinkedList<>()).build(); // Inicializa

        if(rbpBuildings.getBuildings().isEmpty()) // Si está vacío
            rbpBuildings.setBuildings(GalaxyService.getInstance().createRBPBuildings()); // Crea edificios por defecto

        return rbpBuildings; // Retorna colección
    }

    // Método para obtener nivel de vista para un solicitante
    public int getViewFlag(int requester) {
        User user = UserService.getInstance().getUserCache().findByGuid(requester); // Busca usuario solicitante
        if(user == null) return 0; // Si no existe, retorna 0

        Corp corp = user.getCorp(); // Obtiene corporación del solicitante
        Optional<Corp> hereCorp = getCorp(); // Obtiene corporación del planeta

        if(corp == null || hereCorp.isEmpty()) return 0; // Si alguna es null, retorna 0
        return corp.getCorpId() == hereCorp.get().getCorpId() ? 1 : 0; // Retorna 1 si misma corporación, 0 si no
    }

    // Método para obtener corporación controladora
    public Optional<Corp> getCorp() {
        return Optional.ofNullable(CorpService.getInstance().getCorpCache().findByCorpId(currentCorp)); // Busca corporación por ID
    }

    // Método para verificar si hay tregua activa
    public boolean hasTruce() {
        return peace && statusTime.getTime() > new Date().getTime(); // Retorna true si está en paz y no expiró
    }

}
