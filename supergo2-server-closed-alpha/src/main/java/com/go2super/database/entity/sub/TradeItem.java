// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad padre Trade
import com.go2super.database.entity.Trade; // Entidad base de comercio

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importación de datos de propiedades
import com.go2super.resources.data.PropData; // Datos de propiedades/items

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Getter, SuperBuilder, NoArgsConstructor, ToString
import lombok.experimental.SuperBuilder;

// Anotaciones Lombok aplicadas a la clase
@Getter // Genera getters
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString incluyendo campos de superclase
// Clase que representa un item en el comercio
public class TradeItem extends Trade { // Extiende Trade

    private int propId; // ID de la propiedad/item en comercio

    // Método para obtener datos de la propiedad
    public PropData getData() {
        return ResourceManager.getProps().getData(propId); // Obtiene datos del item por ID
    }

}
