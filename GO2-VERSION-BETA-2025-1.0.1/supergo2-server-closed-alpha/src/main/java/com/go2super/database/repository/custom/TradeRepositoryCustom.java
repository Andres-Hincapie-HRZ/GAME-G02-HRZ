// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Trade
import com.go2super.database.entity.Trade; // Entidad de comercio

// Importación de enum TradeType
import com.go2super.database.entity.type.TradeType; // Tipo de comercio

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Interfaz personalizada para consultas específicas de TradeRepository
public interface TradeRepositoryCustom {

    // Método para buscar comercios por página
    List<Trade> findByPage(int page, int max); // Retorna lista de comercios paginados

    // Método para buscar comercios por página y tipo
    List<Trade> findByPageAndType(TradeType tradeType, int page, int max); // Retorna lista de comercios paginados por tipo

    // Método para buscar comercios por página, tipo y ID de venta
    List<Trade> findByPageAndTypeAndSellId(TradeType tradeType, int sellId, int page, int max); // Retorna lista de comercios paginados por tipo y sellId

    // Método para contar comercios por tipo
    long countByType(TradeType tradeType); // Retorna conteo de comercios por tipo

}
