// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Corp
import com.go2super.database.entity.Corp; // Entidad de corporación

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Interfaz personalizada para consultas específicas de CorpRepository
public interface CorpRepositoryCustom {

    // Método para buscar corporación por GUID
    Corp findByGuid(int guid); // Retorna corporación por guid

    // Método para buscar corporaciones con mejoras
    List<Corp> findByCorpUpgrade(); // Retorna lista de corporaciones con mejoras

    // Método para buscar corporación por nombre
    Corp findByName(String name); // Retorna corporación por name

    // Método para buscar corporaciones reclutadoras por GUID
    List<Corp> findRecruitsByGuid(int guid); // Retorna lista de corporaciones reclutadoras por guid

    // Método para buscar corporaciones que empiecen con un nombre
    List<Corp> findByStartWithName(String name); // Retorna lista de corporaciones que empiecen con name

}