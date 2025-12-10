// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

import java.util.Map;

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa metadatos de batalla con mapas de diferentes tipos de datos
public class BattleMetadata {

    private Map<String, Integer> integers; // Mapa de valores enteros
    private Map<String, String> strings; // Mapa de valores string
    private Map<String, Boolean> booleans; // Mapa de valores booleanos
    private Map<String, Double> doubles; // Mapa de valores double
    private Map<String, Float> floats; // Mapa de valores float
    private Map<String, Long> longs; // Mapa de valores long
    private Map<String, Short> shorts; // Mapa de valores short
    private Map<String, Object> objects; // Mapa de objetos genéricos

    // Constructor vacío que inicializa todos los mapas
    public BattleMetadata() {
        integers = new java.util.HashMap<>(); // Inicializa mapa de enteros
        strings = new java.util.HashMap<>(); // Inicializa mapa de strings
        booleans = new java.util.HashMap<>(); // Inicializa mapa de booleanos
        doubles = new java.util.HashMap<>(); // Inicializa mapa de doubles
        floats = new java.util.HashMap<>(); // Inicializa mapa de floats
        longs = new java.util.HashMap<>(); // Inicializa mapa de longs
        shorts = new java.util.HashMap<>(); // Inicializa mapa de shorts
        objects = new java.util.HashMap<>(); // Inicializa mapa de objetos
    }

}
