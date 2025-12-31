// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad ShipModel
import com.go2super.database.entity.ShipModel; // Entidad de modelo de nave

// Importación de entidad padre Trade
import com.go2super.database.entity.Trade; // Entidad base de comercio

// Importación de servicio PacketService
import com.go2super.service.PacketService; // Servicio de paquetes

// Importaciones de Lombok para generar código automáticamente
import lombok.Getter; // Genera getters
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.ToString; // Genera toString
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Anotaciones Lombok aplicadas a la clase
@Getter // Genera getters
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString incluyendo campos de superclase
// Clase que representa una nave en el comercio
public class TradeShip extends Trade { // Extiende Trade

    private int shipModelId; // ID del modelo de nave en comercio

    // Método para obtener el modelo de nave
    public ShipModel getShipModel() {
        return PacketService.getInstance().getShipModelCache().findByShipModelId(shipModelId); // Busca modelo por ID
    }

}
