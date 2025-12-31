// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de objeto de juego ShipTeamNum
import com.go2super.obj.game.ShipTeamNum; // Representa número de naves en un equipo

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa la fábrica de naves de un usuario
public class UserFactory {

    public List<ShipTeamNum> ships = new ArrayList<>(); // Lista de equipos de naves en producción

}
