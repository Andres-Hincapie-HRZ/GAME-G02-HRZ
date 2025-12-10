// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Fleet
import com.go2super.database.entity.Fleet; // Entidad de flota

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Interfaz personalizada para consultas específicas de FleetRepository
public interface FleetRepositoryCustom {

    // Método para obtener flotas en guerra
    List<Fleet> getInWarFleets(); // Retorna lista de flotas en guerra

    // Método para obtener flotas en transmisión
    List<Fleet> getInTransmissionFleets(); // Retorna lista de flotas en transmisión

    // Método para obtener flotas en transmisión por GUID
    List<Fleet> getInTransmissionFleets(int guid); // Retorna lista de flotas en transmisión por guid

    // Método para obtener flotas en radar (propias o en transmisión a galaxia)
    List<Fleet> getRadarFleets(int guid, int toGalaxyId); // Retorna lista de flotas en radar por guid y toGalaxyId

}
