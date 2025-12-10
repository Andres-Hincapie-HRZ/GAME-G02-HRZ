// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Clase que representa el historial de una corporación
public class CorpHistory {

    private List<CorpIncident> incidents = new ArrayList<>(); // Lista de incidentes de la corporación

    // Método para obtener la lista de incidentes
    public List<CorpIncident> getIncidents() {
        return incidents; // Retorna la lista de incidentes
    }

    // Método para agregar un incidente al historial
    public void addIncident(CorpIncident incident) {
        if(incidents == null) // Si la lista es null
            incidents = new ArrayList<>(); // Inicializa nueva lista

        incidents.add(incident); // Agrega el incidente a la lista
    }

}
