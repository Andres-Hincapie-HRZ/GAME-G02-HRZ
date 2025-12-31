// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que maneja las métricas de un usuario
public class UserMetrics {

    private List<Metric> metrics; // Lista de métricas del usuario

    // Método para agregar valor a una métrica por identificador
    public void add(String metricIdentifier, int value) {
        getMetric(metricIdentifier).add(value); // Obtiene métrica y agrega valor
    }

    // Método para restar valor a una métrica por identificador
    public void sub(String metricIdentifier, int value) {
        getMetric(metricIdentifier).sub(value); // Obtiene métrica y resta valor
    }

    // Método para resetear una métrica por identificador
    public void reset(String metricIdentifier) {
        getMetric(metricIdentifier).reset(); // Obtiene métrica y resetea valor
    }

    // Método para obtener una métrica por identificador (crea si no existe)
    public Metric getMetric(String metricIdentifier) {
        if(metrics == null) // Si la lista es null
            metrics = new ArrayList<>(); // Inicializa nueva lista

        Optional<Metric> optionalMetric = metrics.stream().filter(m -> m.getIdentifier().equals(metricIdentifier)).findFirst(); // Busca métrica existente
        if(optionalMetric.isPresent()) // Si existe
            return optionalMetric.get(); // Retorna la métrica encontrada

        Metric metric = Metric.builder() // Crea nueva métrica
                .identifier(metricIdentifier) // Establece identificador
                .value(0) // Valor inicial 0
                .build();
        metrics.add(metric); // Agrega a la lista
        return metric; // Retorna la nueva métrica
    }

}
