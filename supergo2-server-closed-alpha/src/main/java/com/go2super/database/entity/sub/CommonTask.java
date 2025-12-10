// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa una tarea común en el sistema de misiones
public class CommonTask {

    private int taskId; // ID único de la tarea
    private boolean completed; // Si la tarea ha sido completada

}
