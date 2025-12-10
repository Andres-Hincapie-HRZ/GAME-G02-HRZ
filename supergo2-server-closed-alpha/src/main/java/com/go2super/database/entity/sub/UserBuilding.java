// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de objeto de juego BuildInfo
import com.go2super.obj.game.BuildInfo; // Información de construcción

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importaciones de datos de construcción
import com.go2super.resources.data.BuildData; // Datos de construcción
import com.go2super.resources.data.meta.BuildLevelMeta; // Metadatos de nivel de construcción

// Importación de utilidad DateUtil
import com.go2super.socket.util.DateUtil; // Utilidades para manejo de fechas

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa un edificio de usuario en el planeta
public class UserBuilding {

    private Boolean repairing; // Si el edificio está siendo reparado
    private Date untilRepair; // Fecha hasta la que dura la reparación

    private Boolean updating; // Si el edificio está siendo actualizado
    private Date untilUpdate; // Fecha hasta la que dura la actualización

    private int index = -1; // Índice del edificio (-1 significa no asignado)
    private int levelId; // ID del nivel actual
    private int buildingId; // ID del edificio

    private int x; // Coordenada X en el planeta
    private int y; // Coordenada Y en el planeta

    // Método para obtener tiempo restante de actualización
    public Long updatingTime() {
        if(updating == null || !updating || untilUpdate == null) // Si no está actualizando
            return Long.valueOf(0); // Retorna 0

        return DateUtil.remains(untilUpdate); // Retorna tiempo restante
    }

    // Método para obtener tiempo restante de reparación
    public Long repairingTime() {
        if(repairing == null || !repairing || untilRepair == null) // Si no está reparando
            return Long.valueOf(0); // Retorna 0

        return DateUtil.remains(untilRepair); // Retorna tiempo restante
    }

    // Método para obtener tiempo de espera total (reparación + actualización)
    public Long spareTime() {
        Long repairingTime = repairingTime(); // Obtiene tiempo de reparación

        if(repairingTime != 0) // Si hay tiempo de reparación
            return repairingTime; // Retorna tiempo de reparación

        return updatingTime(); // Sino, retorna tiempo de actualización
    }

    // Método para obtener metadatos del nivel actual
    public BuildLevelMeta getLevelData() {
        return getData().getLevel(levelId); // Obtiene datos del nivel desde los datos del edificio
    }

    // Método para obtener datos del edificio
    public BuildData getData() {
        BuildData data = ResourceManager.getBuilds().getBuild(buildingId); // Obtiene datos por ID
        return data; // Retorna datos del edificio
    }

    // Método para obtener información de construcción
    public BuildInfo getInfo(int spareTime) {
        return new BuildInfo(spareTime, x, y, index, buildingId, levelId); // Crea info con parámetros
    }

}
