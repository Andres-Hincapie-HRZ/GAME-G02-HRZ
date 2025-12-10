// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa los territorios controlados por una corporación
public class CorpTerritories {

    List<Integer> territories; // Lista de IDs de planetas que son territorios

    // Método para obtener la lista de territorios
    public List<Integer> getTerritories(){return territories;} // Retorna la lista

    // Método para agregar un territorio (planeta)
    public void addTerritory(int planetId){
        if(territories == null) // Si la lista es null
            territories = new ArrayList<>(); // Inicializa nueva lista

        territories.add(planetId); // Agrega el ID del planeta
    }

    // Método para remover un territorio (nota: nombre incorrecto, debería ser removeTerritory)
    public void removeRecruit(int planetId){ // Error en nombre del método
        int planetToDelete = getTerritory(planetId); // Obtiene el territorio
       getTerritories().remove(planetToDelete); // Remueve de la lista (nota: debería ser Integer.valueOf(planetId))
    }

    // Método para obtener un territorio por ID de planeta
    public Integer getTerritory(int planetId){
        for(Integer territory : territories) // Itera sobre territorios
            if(territory == planetId) // Si coincide el ID
                return territory; // Retorna el territorio

        return null; // Retorna null si no se encuentra
    }

}
