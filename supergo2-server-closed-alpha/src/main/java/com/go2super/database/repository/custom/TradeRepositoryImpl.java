// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Trade
import com.go2super.database.entity.Trade; // Entidad de comercio

// Importación de enum TradeType
import com.go2super.database.entity.type.TradeType; // Tipo de comercio

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.domain.Sort; // Clase para ordenamiento
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.Arrays; // Utilidades de arrays
import java.util.List; // Interfaz de lista

// Implementación de la interfaz TradeRepositoryCustom
public class TradeRepositoryImpl implements TradeRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para buscar comercios por página
    @Override
    public List<Trade> findByPage(int page, int max) {
        // Crea consulta con ordenamiento: priceType DESC, price ASC, tradeType DESC
        Query query = new Query();
        query.with(Sort.by(Arrays.asList(
                new Sort.Order(Sort.Direction.DESC, "priceType"),
                new Sort.Order(Sort.Direction.ASC, "price"),
                new Sort.Order(Sort.Direction.DESC, "tradeType"))));
        query.skip(page <= 0 ? 0 : page * max); // Salta páginas anteriores
        query.limit(max); // Limita resultados por página

        List<Trade> results = mongoTemplate.find(query, Trade.class); // Ejecuta consulta
        return results; // Retorna resultados
    }

    // Implementación del método para buscar comercios por página y tipo
    @Override
    public List<Trade> findByPageAndType(TradeType tradeType, int page, int max) {
        // Crea criterio para filtrar por tradeType
        Criteria criteria = Criteria.where("tradeType").is(tradeType);
        Query query = new Query();
        query.addCriteria(criteria);
        // Ordenamiento: priceType DESC, price ASC
        query.with(Sort.by(Arrays.asList(
                new Sort.Order(Sort.Direction.DESC, "priceType"),
                new Sort.Order(Sort.Direction.ASC, "price"))));
        query.skip(page <= 0 ? 0 : page * max); // Salta páginas anteriores
        query.limit(max); // Limita resultados por página

        List<Trade> results = mongoTemplate.find(query, Trade.class); // Ejecuta consulta
        return results; // Retorna resultados
    }

    // Implementación del método para buscar comercios por página, tipo y ID de venta
    @Override
    public List<Trade> findByPageAndTypeAndSellId(TradeType tradeType, int sellId, int page, int max) {
        // Crea criterio compuesto: tradeType igual Y sellId igual
        Criteria criteria = Criteria.where("tradeType").is(tradeType).andOperator(Criteria.where("sellId").is(sellId));
        Query query = new Query();
        query.addCriteria(criteria);
        // Ordenamiento: priceType DESC, price ASC
        query.with(Sort.by(Arrays.asList(
                new Sort.Order(Sort.Direction.DESC, "priceType"),
                new Sort.Order(Sort.Direction.ASC, "price"))));
        query.skip(page <= 0 ? 0 : page * max); // Salta páginas anteriores
        query.limit(max); // Limita resultados por página

        List<Trade> results = mongoTemplate.find(query, Trade.class); // Ejecuta consulta
        return results; // Retorna resultados
    }

    // Implementación del método para contar comercios por tipo
    @Override
    public long countByType(TradeType tradeType) {
        // Crea criterio para filtrar por tradeType
        Criteria criteria = Criteria.where("tradeType").is(tradeType);
        Query query = new Query();
        query.addCriteria(criteria);

        long result = mongoTemplate.count(query, Trade.class); // Cuenta documentos
        return result; // Retorna conteo
    }

}
