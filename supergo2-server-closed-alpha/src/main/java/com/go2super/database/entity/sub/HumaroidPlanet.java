// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad padre Planet
import com.go2super.database.entity.Planet; // Entidad base de planeta

// Importación de enum PlanetType
import com.go2super.database.entity.type.PlanetType; // Tipo de planeta

// Importación de utilidad GalaxyTile
import com.go2super.obj.utility.GalaxyTile; // Coordenadas galácticas

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importación de datos de instancia
import com.go2super.resources.data.InstanceData; // Datos de instancia

// Importación de servicio de batalla
import com.go2super.service.BattleService; // Servicio de batallas

// Importación de utilidad MathUtil
import com.go2super.socket.util.MathUtil; // Utilidades matemáticas

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un planeta humanoides (enemigo) en el juego
public class HumaroidPlanet extends Planet { // Extiende Planet

    private int currentCorp; // ID de la corporación que controla actualmente
    private int currentLevel; // Nivel actual del planeta humanoides

    private boolean destroyed; // Si el planeta está destruido

    private boolean peace; // Si está en paz/tregua
    private Date statusTime; // Tiempo hasta el que dura el estado actual

    // Constructor vacío
    public HumaroidPlanet() {
    }

    // Constructor con coordenadas y usuario
    public HumaroidPlanet(GalaxyTile galaxyTile, long userId) {
        this.currentLevel = MathUtil.random(0, 15); // Nivel aleatorio entre 0-14
        this.statusTime = new Date(); // Estado actual desde ahora

        this.setUserId(userId); // Establece usuario propietario
        this.setType(PlanetType.HUMAROID_PLANET); // Tipo de planeta humanoides
        this.setPosition(galaxyTile); // Posición en galaxia
    }

    // Método para obtener datos de instancia del humanoides
    public InstanceData getData() {
        return ResourceManager.getHumaroids().getHumaroid(currentLevel); // Obtiene datos por nivel
    }

    // Método para verificar si hay pelea activa
    public boolean hasFight() {
        return BattleService.getInstance().isInWar(this); // Delega al servicio de batalla
    }

    // Método para verificar si hay tregua
    public boolean hasTruce() {
        if(statusTime == null || destroyed) return true; // Si no hay tiempo o está destruido, hay tregua
        return peace && statusTime.getTime() > new Date().getTime(); // Si está en paz y no expiró
    }

}
