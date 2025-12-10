// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad GameBoost
import com.go2super.database.entity.GameBoost; // Entidad de boost/mejora temporal

// Importación de servicio ResourcesService
import com.go2super.service.ResourcesService; // Servicio de recursos

// Importación de utilidad DateUtil
import com.go2super.socket.util.DateUtil; // Utilidades para manejo de fechas

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok aplicadas a la clase
@Builder // Genera patrón builder
@AllArgsConstructor // Genera constructor con todos los argumentos
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un boost temporal aplicado a un usuario
public class UserBoost {

    private String gameBoostId; // ID del boost aplicado
    private Date until; // Fecha hasta la que dura el boost

    // Método para obtener el boost (versión directa)
    public GameBoost boost() {
        return getGameBoost().get(); // Obtiene el boost y lo retorna directamente
    }

    // Método para obtener el boost de forma opcional
    public Optional<GameBoost> getGameBoost() {
        return ResourcesService.getInstance().getBoostRepository().findById(gameBoostId); // Busca boost por ID
    }

    // Método para obtener segundos restantes del boost
    public int getSeconds() {
        return DateUtil.remains(until).intValue(); // Calcula tiempo restante en segundos
    }

    // Método para agregar segundos al boost
    public void addSeconds(int seconds) {
        setUntil(DateUtil.offset(until, seconds)); // Extiende la fecha de expiración
    }

}
