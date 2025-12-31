// Paquete que contiene la interfaz, parte del módulo de repositorios de base de datos
package com.go2super.database.repository;

// Importación de entidad Trade
import com.go2super.database.entity.Trade; // Entidad de comercio

// Importación de interfaz personalizada para consultas específicas
import com.go2super.database.repository.custom.TradeRepositoryCustom; // Interfaz personalizada para Trade

// Importaciones de Spring Data MongoDB
import org.springframework.data.mongodb.repository.MongoRepository; // Interfaz base para repositorios MongoDB
import org.springframework.data.mongodb.repository.Query; // Anotación para consultas personalizadas

// Importaciones estándar de Java
import java.io.Serializable; // Interfaz para serialización
import java.util.Collection; // Interfaz de colección
import java.util.List; // Interfaz de lista

// Interfaz de repositorio para la entidad Trade, extiende MongoRepository y la interfaz personalizada
public interface TradeRepository extends MongoRepository<Trade, String>, TradeRepositoryCustom, Serializable {

    // Método para encontrar el registro más reciente (último ID)
    Trade findTopByOrderByIdDesc(); // Retorna el comercio con ID más alto

    // Método para obtener todos los comercios
    List<Trade> findAll(); // Retorna lista de todos los comercios

    // Consulta personalizada para buscar comercios por lista de IDs de trade
    @Query(value = "{ 'tradeId' : {'$in' : ?0 } }") // Consulta MongoDB para IDs en lista
    List<Trade> findByTradeId(Collection<Integer> tradeIds); // Retorna lista de comercios por tradeIds

    // Método para buscar comercio por ID de trade
    Trade findByTradeId(int tradeId); // Retorna comercio por tradeId

    // Método para obtener comercios por GUID del vendedor
    List<Trade> findAllBySellerGuid(int sellerGuid); // Retorna lista de comercios por sellerGuid

    // Método para contar el total de comercios
    long count(); // Retorna el número total de comercios

}