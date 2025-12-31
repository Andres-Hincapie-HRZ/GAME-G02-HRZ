// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de logger del bot
import com.go2super.logger.BotLogger; // Logger para errores

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importación de datos de construcción
import com.go2super.resources.data.BuildData; // Datos de construcción

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.LinkedList; // Lista enlazada
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que maneja una colección de edificios RBP (Resource Based Planet)
public class RBPBuildings {

    private LinkedList<RBPBuilding> buildings; // Lista enlazada de edificios

    // Método para seleccionar un edificio por nombre
    public RBPBuilding pickOne(String name) {
        for(RBPBuilding userBuilding : buildings) // Itera sobre edificios
            if(ResourceManager.getBuilds().getBuild(userBuilding.getBuildingId()).getName().equals(name)) // Si coincide nombre
                return userBuilding; // Retorna el edificio
        return null; // Retorna null si no encuentra
    }

    // Método para contar edificios de un tipo específico
    public int count(int building) {
        int result = 0; // Contador
        for(RBPBuilding cache : buildings) // Itera sobre edificios
            if(cache.getBuildingId() == building) // Si coincide ID
                result++; // Incrementa contador
        return result; // Retorna conteo
    }

    // Método para obtener edificio por índice
    public RBPBuilding getBuilding(int index) {
        if(buildings.size() > index && index > -1) // Si índice válido
            return buildings.get(index); // Retorna edificio
        return null; // Retorna null si inválido
    }

    // Método para obtener lista de edificios por nombre
    public List<RBPBuilding> getBuildings(String name) {
        BuildData buildData = ResourceManager.getBuilds().getBuild(name); // Obtiene datos de construcción
        List<RBPBuilding> filter = new ArrayList<>(); // Lista resultado

        if(buildData == null) { // Si no existen datos
            BotLogger.error("Not found building with name: " + name); // Log error
            return filter; // Retorna lista vacía
        }

        for(RBPBuilding building : buildings) // Itera sobre edificios
            if(building.getBuildingId() == buildData.getId()) // Si coincide ID
                filter.add(building); // Agrega a filtro

        return filter; // Retorna lista filtrada
    }

    // Método para obtener primer edificio por nombre
    public RBPBuilding getBuilding(String name) {
        List<RBPBuilding> buildings = getBuildings(name); // Obtiene lista

        if(buildings.isEmpty()) // Si está vacía
            return null; // Retorna null

        return buildings.get(0); // Retorna primer edificio
    }

    // Método para obtener lista de edificios por ID
    public List<RBPBuilding> getBuildings(int id) {
        List<RBPBuilding> filter = new ArrayList<>(); // Lista resultado
        for(RBPBuilding building : buildings) // Itera sobre edificios
            if(building.getBuildingId() == id) // Si coincide ID
                filter.add(building); // Agrega a filtro
        return filter; // Retorna lista filtrada
    }

    // Método para obtener edificios que están siendo actualizados
    public List<RBPBuilding> getUpdatingBuildings() {
        List<RBPBuilding> filter = new ArrayList<>(); // Lista resultado
        for(RBPBuilding building : buildings) // Itera sobre edificios
            if(building.getUpdating() != null && building.getUpdating()) // Si está actualizando
                filter.add(building); // Agrega a filtro
        return filter; // Retorna lista filtrada
    }

    // Método para verificar si tiene edificio de cierto ID y nivel
    public boolean has(int id, int level) {
        for(RBPBuilding building : getBuildings(id)) // Itera sobre edificios del tipo
            if(building.getLevelId() == level) // Si coincide nivel
                return true; // Retorna true
        return false; // Retorna false
    }

    // Método para agregar edificio con parámetros básicos
    public RBPBuildings addBuilding(int building, int level, int x, int y) {
        return addBuilding(RBPBuilding.builder().buildingId(building).levelId(level).x(x).y(y).index(nextIndexId()).build()); // Crea y agrega
    }

    // Método para agregar edificio existente
    public RBPBuildings addBuilding(RBPBuilding building) {
        if(buildings == null) // Si lista es null
            buildings = new LinkedList<>(); // Inicializa

        buildings.add(building); // Agrega edificio
        return this; // Retorna this para encadenamiento
    }

    // Método para refrescar índices de edificios
    public boolean refresh() {
        boolean needRefresh = false; // Bandera de necesidad de refresh

        for(RBPBuilding building : buildings) // Itera sobre edificios
            if(building.getIndex() == -1) { // Si índice no asignado
                needRefresh = true; // Marca necesidad
                break; // Sale del loop
            }

        if(!needRefresh) return false; // Si no necesita, retorna false
        int index = 0; // Contador de índice

        for(RBPBuilding building : buildings) // Itera sobre edificios
            building.setIndex(index++); // Asigna índice secuencial

        return true; // Retorna true si refrescó
    }

    // Método para obtener siguiente ID de índice disponible
    public int nextIndexId() {
        int index = 0; // Índice inicial
        if(buildings == null) return 0; // Si no hay edificios, retorna 0

        for(RBPBuilding building : buildings) // Itera sobre edificios
            if(building.getIndex() > index) // Si índice mayor que actual
                index = building.getIndex(); // Actualiza máximo

        return index + 1; // Retorna siguiente índice
    }

}
