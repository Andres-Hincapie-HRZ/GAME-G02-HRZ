// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de objeto de juego ShortArray
import com.go2super.obj.game.ShortArray; // Array de shorts para datos de naves

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importaciones de datos de naves
import com.go2super.resources.data.ShipBodyData; // Datos de cuerpo de nave
import com.go2super.resources.data.ShipPartData; // Datos de partes de nave

// Importaciones de metadatos de naves
import com.go2super.resources.data.meta.BodyLevelMeta; // Metadatos de nivel de cuerpo
import com.go2super.resources.data.meta.PartLevelMeta; // Metadatos de nivel de parte

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que maneja las mejoras de naves de un usuario
public class UserShipUpgrades {

    public List<Integer> currentBodies = new ArrayList<>(); // Lista de cuerpos de nave actuales
    public List<Integer> currentParts = new ArrayList<>(); // Lista de partes de nave actuales

    public ShipUpgrade shipUpgrade; // Mejora de nave en progreso
    public ShipUpgrade partUpgrade; // Mejora de parte en progreso

    // Método para verificar si tiene mejora de parte específica
    public boolean hasPartUpgrade(int id) {
        ShipPartData data = ResourceManager.getShipParts().findByPartId(id); // Obtiene datos de parte
        PartLevelMeta level = data.getLevel(id); // Obtiene metadatos de nivel
        if(data == null) return true; // Si no existen datos, retorna true (por defecto)
        boolean has = false; // Bandera de si tiene
        for(int some : currentParts) { // Itera sobre partes actuales
            PartLevelMeta userLevel = data.getLevel(some); // Obtiene nivel del usuario
            if(userLevel == null) continue; // Si no existe, salta
            if(userLevel.getLv() >= level.getLv()) { // Si nivel del usuario >= nivel requerido
                has = true; // Marca como tiene
                break; // Sale del loop
            }
        }
        return has; // Retorna si tiene la mejora
    }

    // Método para verificar si tiene mejora de cuerpo específica
    public boolean hasBodyUpgrade(int id) {
        ShipBodyData data = ResourceManager.getShipBodies().findByBodyId(id); // Obtiene datos de cuerpo
        BodyLevelMeta level = data.getLevel(id); // Obtiene metadatos de nivel
        if(data == null) return true; // Si no existen datos, retorna true (por defecto)
        boolean has = false; // Bandera de si tiene
        for(int some : currentBodies) { // Itera sobre cuerpos actuales
            BodyLevelMeta userLevel = data.getLevel(some); // Obtiene nivel del usuario
            if(userLevel == null) continue; // Si no existe, salta
            if(userLevel.getLv() >= level.getLv()) { // Si nivel del usuario >= nivel requerido
                has = true; // Marca como tiene
                break; // Sale del loop
            }
        }
        return has; // Retorna si tiene la mejora
    }

    // Método para obtener array de cuerpos
    public ShortArray getBodiesArray() {
        int[] array = new int[200]; // Array de tamaño fijo 200

        for(int i = 0; i < array.length; i++) // Itera sobre el array
            if(i < currentBodies.size()) // Si hay cuerpo en esa posición
                array[i] = currentBodies.get(i); // Asigna el ID del cuerpo
            else
                array[i] = 0; // Sino, asigna 0

        return new ShortArray(array); // Retorna ShortArray con los datos
    }

    // Método para obtener array de partes
    public ShortArray getPartsArray() {
        int[] array = new int[280]; // Array de tamaño fijo 280

        for(int i = 0; i < array.length; i++) // Itera sobre el array
            if(i < currentParts.size()) // Si hay parte en esa posición
                array[i] = currentParts.get(i); // Asigna el ID de la parte
            else
                array[i] = 0; // Sino, asigna 0

        return new ShortArray(array); // Retorna ShortArray con los datos
    }

}
