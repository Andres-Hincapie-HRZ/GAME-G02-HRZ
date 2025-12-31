// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Trade; // Entidad Trade
import com.go2super.database.entity.type.TradeType; // Tipo enumerado TradeType
import com.go2super.database.repository.TradeRepository; // Repositorio para Trade
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.Collection; // Interfaz Collection
import java.util.Comparator; // Interfaz Comparator
import java.util.List; // Interfaz List
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class TradeCache {

    // Campo estático final para el caché de intercambios, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Trade> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de intercambios
    private TradeRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void TradeCache(TradeRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todos los intercambios del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todos los intercambios del caché
    public List<Trade> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar un intercambio en el repositorio y añadirlo al caché si no existe
    public void save(Trade value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar un intercambio (alias para remove)
    public void delete(Trade value) {
        remove(value);
    }

    // Método para eliminar un intercambio del repositorio y del caché
    public void remove(Trade value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar intercambios por colección de IDs de intercambio
    public List<Trade> findByTradeId(Collection<Integer> tradeIds) {
        return cache.stream().filter(value -> tradeIds.contains(value.getTradeId())).collect(Collectors.toList());
    }

    // Método para encontrar un intercambio por ID de intercambio
    public Trade findByTradeId(int tradeId) {
        return cache.stream().filter(value -> value.getTradeId() == tradeId).findFirst().orElse(null);
    }

    // Método para encontrar todos los intercambios por GUID del vendedor
    public List<Trade> findAllBySellerGuid(int sellerGuid) {
        return cache.stream().filter(value -> value.getSellerGuid() == sellerGuid).collect(Collectors.toList());
    }

    // Método para encontrar intercambios por página con paginación
    public List<Trade> findByPage(int page, int max) {
        return cache.stream()
                .sorted(Comparator.comparing(Trade::getPriceType).reversed()
                        .thenComparing(Trade::getPrice)
                        .thenComparing(Trade::getTradeType))
                .skip(page <= 0 ? 0 : page * max).limit(max).collect(Collectors.toList());
    }

    // Método para encontrar intercambios por página y tipo con paginación
    public List<Trade> findByPageAndType(TradeType tradeType, int page, int max) {
        return cache.stream()
                .filter(value -> value.getTradeType().equals(tradeType))
                .sorted(Comparator.comparing(Trade::getPriceType).reversed()
                        .thenComparing(Trade::getPrice))
                .skip(page <= 0 ? 0 : page * max).limit(max).collect(Collectors.toList());
    }

    // Método para encontrar intercambios por página, tipo y ID de venta con paginación
    public List<Trade> findByPageAndTypeAndSellId(TradeType tradeType, int sellId, int page, int max) {
        return cache.stream()
                .filter(value -> value.getTradeType().equals(tradeType) && value.getSellId() == sellId)
                .sorted(Comparator.comparing(Trade::getPriceType).reversed()
                        .thenComparing(Trade::getPrice))
                .skip(page <= 0 ? 0 : page * max).limit(max).collect(Collectors.toList());
    }

    // Método para contar intercambios por tipo
    public long countByType(TradeType type) {
        return cache.stream().filter(value -> value.getTradeType().equals(type)).count();
    }

    // Método para contar el número de intercambios en el caché
    public long count() {
        return cache.size();
    }

}
