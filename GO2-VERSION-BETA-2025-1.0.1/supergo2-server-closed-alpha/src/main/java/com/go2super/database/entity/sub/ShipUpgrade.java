// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de utilidad DateUtil
import com.go2super.socket.util.DateUtil; // Utilidades para manejo de fechas

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@AllArgsConstructor // Genera constructor con todos los argumentos
@NoArgsConstructor // Genera constructor vacío
// Clase que representa una mejora de nave en progreso
public class ShipUpgrade {

    private int upgradeId; // ID de la mejora
    private Date until; // Fecha hasta la que dura la mejora

    // Método para obtener tiempo restante de la mejora
    public Long upgradeTime() {
        return DateUtil.remains(until); // Calcula tiempo restante usando utilidad
    }

}
