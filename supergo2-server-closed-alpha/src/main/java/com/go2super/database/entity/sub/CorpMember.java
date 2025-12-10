// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de servicio UserService
import com.go2super.service.UserService; // Servicio para operaciones con usuarios

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase que representa un miembro de una corporación
public class CorpMember {

    private int guid; // GUID único del usuario miembro

    /*
        Rangos de miembros en la corporación:
        0 -> recruit (recluta)
        1 -> colonel (coronel)
        2 -> commandant (comandante)
        3 -> captain (capitán)
        4 -> soldier (soldado)
    */
    private int rank; // Rango del miembro en la corporación

    private int contribution; // Contribución total del miembro
    private int donateResources; // Recursos donados por el miembro
    private int donateMallPoints; // Puntos de tienda donados por el miembro

    // Método para obtener el usuario asociado al miembro
    public Optional<User> getUser() {
        User user = UserService.getInstance().getUserCache().findByGuid(guid); // Busca usuario por GUID
        return Optional.ofNullable(user); // Retorna opcional (puede ser null)
    }

}
