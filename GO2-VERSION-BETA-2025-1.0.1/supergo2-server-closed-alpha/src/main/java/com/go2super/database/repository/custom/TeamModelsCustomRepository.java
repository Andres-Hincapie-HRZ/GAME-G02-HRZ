// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad TeamModelSlot
import com.go2super.database.entity.TeamModelSlot; // Entidad de slot de modelo de equipo

// Interfaz personalizada para consultas específicas de TeamModelsRepository
public interface TeamModelsCustomRepository {

    // Método para buscar slot por GUID e ID de índice
    TeamModelSlot findByGuidAndIndexId(int guid, int indexId); // Retorna slot por guid e indexId

}
