// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@AllArgsConstructor // Genera constructor con todos los argumentos
@NoArgsConstructor // Genera constructor vacío
// Clase que representa una etiqueta/tag en batalla
public class BattleTag {

    private String name; // Nombre de la etiqueta
    private int value; // Valor asociado a la etiqueta

    // Método estático para crear una instancia de BattleTag
    public static BattleTag of(String name, int value) {
        return new BattleTag(name, value); // Retorna nueva instancia
    }

}
