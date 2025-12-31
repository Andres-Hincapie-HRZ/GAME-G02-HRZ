// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de objeto de juego CreateShipInfo
import com.go2super.obj.game.CreateShipInfo; // Información para crear naves

// Importación de utilidad DateUtil
import com.go2super.socket.util.DateUtil; // Utilidades para manejo de fechas

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa información de construcción de naves en un cuerpo/casco
public class ShipBodyInfo {

    private int shipModelId; // ID del modelo de nave a construir
    private Date until; // Fecha hasta la que estará en construcción

    private int num; // Número de naves a construir
    private int buildTime; // Tiempo total de construcción
    private int incSpeed; // Incremento de velocidad de construcción

    // Constructor con parámetros principales
    public ShipBodyInfo(int shipModelId, int num, int buildTime) {
        this.shipModelId = shipModelId; // Asigna ID del modelo
        this.num = num; // Asigna número de naves

        this.buildTime = buildTime; // Asigna tiempo de construcción
        this.until = DateUtil.now(buildTime); // Calcula fecha de finalización
    }

    // Método para obtener información de paquete para el cliente
    public CreateShipInfo packet() {
        int remains = until != null ? DateUtil.remains(until).intValue() : 0; // Tiempo restante
        return new CreateShipInfo(shipModelId, remains + ((num - 1)  * buildTime), num, incSpeed); // Crea info con parámetros calculados
    }

    // Método estático para crear instancia de ShipBodyInfo
    public static ShipBodyInfo of(int shipModelId, int num, int buildTime) {
        return new ShipBodyInfo(shipModelId, num, buildTime); // Retorna nueva instancia
    }

}
