// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importación de tipos de precio y comercio
import com.go2super.database.entity.type.PriceType; // Enum para tipos de precio
import com.go2super.database.entity.type.TradeType; // Enum para tipos de comercio

// Importaciones de servicios
import com.go2super.service.TradeService; // Servicio de comercio
import com.go2super.service.UserService; // Servicio de usuario

// Importaciones de Lombok
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Id; // Anotación para ID de entidad

// Importación estándar de Java
import java.util.Date; // Clase para fechas

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_trades"
@Document(collection = "game_trades")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa un comercio/intercambio en el juego
public class Trade {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del comercio

    private int tradeId; // ID único del comercio

    private long sellerUserId; // ID del usuario vendedor
    private int sellerGuid; // GUID del usuario vendedor

    private int sellId; // ID del item a vender
    private int amount; // Cantidad del item a vender
    private int price; // Precio del comercio

    private Date until; // Fecha hasta la que es válido el comercio
    private TradeType tradeType; // Tipo de comercio
    private PriceType priceType; // Tipo de precio

    // Método para obtener el usuario vendedor
    public User getSeller() { // Retorna el usuario vendedor por GUID
        return UserService.getInstance().getUserCache().findByGuid(getSellerGuid()); // Busca en el cache
    }

    // Método para guardar el comercio en el cache
    public void save() { // Guarda el comercio en el cache del servicio
        TradeService.getInstance().getTradeCache().save(this); // Delega al servicio
    }

}
