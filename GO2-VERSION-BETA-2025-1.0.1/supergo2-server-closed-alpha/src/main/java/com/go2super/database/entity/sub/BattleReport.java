// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de objetos de juego y servicios de batalla
import com.go2super.obj.game.FightRobResource; // Recurso robado en pelea
import com.go2super.service.battle.BattleFleetCell; // Celda de flota de batalla
import com.go2super.service.battle.Match; // Clase de coincidencia de batalla
import com.go2super.service.battle.calculator.FortShootdowns; // Derribos de fortificaciones
import com.go2super.service.battle.calculator.ShipHighestAttack; // Ataque más alto de nave
import com.go2super.service.battle.calculator.ShipShootdowns; // Derribos de naves

// Importaciones de Lombok
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un reporte de batalla
public class BattleReport {

    private int lastShoot = -1; // Último disparo (-1 por defecto)
    private List<FightRobResource> fightRobResources = new ArrayList<>(); // Recursos robados en la pelea

    private int totalAttackerSent = 0; // Total de unidades enviadas por atacante
    private int totalDefenderSent = 0; // Total de unidades enviadas por defensor

    private int totalAttackerLost = 0; // Total de unidades perdidas por atacante
    private int totalDefenderLost = 0; // Total de unidades perdidas por defensor

    private List<BattleExpCache> expHistoric = new ArrayList<>(); // Histórico de experiencia
    private List<BattleShipCache> shipHistoric = new ArrayList<>(); // Histórico de naves

    // Método para iniciar el reporte con una batalla
    public void start(Match match) {
        for(BattleFort fort : match.getForts()) { // Itera sobre fortificaciones
            if(fort.isAttacker()) addAttackerSent(1); // Si es atacante, agrega 1 enviado
            else addDefenderSent(1); // Sino, agrega 1 enviado por defensor
        }

        for(BattleFleet fleet : match.getFleets()) { // Itera sobre flotas
            if(fleet.isAttacker()) addAttackerSent(fleet.getAmount()); // Agrega cantidad enviada por atacante
            else addDefenderSent(fleet.getAmount()); // Agrega cantidad enviada por defensor
        }
    }

    // Método para agregar unidades enviadas por atacante
    public void addAttackerSent(int amount) {
        totalAttackerSent += amount; // Suma a total enviado por atacante
    }

    // Método para agregar unidades enviadas por defensor
    public void addDefenderSent(int amount) {
        totalDefenderSent += amount; // Suma a total enviado por defensor
    }

    // Método para procesar el ataque más alto de una nave
    public void processHighestAttack(ShipHighestAttack shipHighestAttack) {
        processHighestAttack(shipHighestAttack.getHighestAttack(), shipHighestAttack.getAttacker(), shipHighestAttack.getAttackerCell()); // Delega
    }

    // Método sobrecargado para procesar ataque más alto
    public void processHighestAttack(double totalAttack, BattleFleet battleFleet, BattleFleetCell cell) {
        processHighestAttack(totalAttack, battleFleet.getGuid(), cell.getShipModelId()); // Delega con GUID y modelo
    }

    // Método para procesar ataque más alto con parámetros básicos
    public void processHighestAttack(double highestAttack, int guid, int shipModelId) {
        BattleShipCache battleShipCache = new BattleShipCache(); // Crea cache de nave
        battleShipCache.setGuid(guid); // Establece GUID
        battleShipCache.setShipModelId(shipModelId); // Establece ID de modelo
        battleShipCache.setHighestAttack(highestAttack); // Establece ataque más alto

        processHighestAttack(battleShipCache, shipHistoric); // Procesa en histórico
    }

    // Método para procesar cache de nave en lista
    public void processHighestAttack(BattleShipCache shipCache, List<BattleShipCache> shipCacheList) {
        Optional<BattleShipCache> optional = shipCacheList.stream() // Busca cache existente
                .filter(cache -> cache.getGuid() == shipCache.getGuid() && cache.getShipModelId() == shipCache.getShipModelId())
                .findFirst();

        if(optional.isPresent()) { // Si existe
            BattleShipCache current = optional.get(); // Obtiene actual

            if(current.getHighestAttack() < shipCache.getHighestAttack()) // Si nuevo es mayor
                current.setHighestAttack(shipCache.getHighestAttack()); // Actualiza

        } else shipCacheList.add(shipCache); // Sino, agrega nuevo
    }

    // Método para procesar derribos de fortificación
    public void processShootdowns(FortShootdowns fortShootdowns) {
        processShootdowns(fortShootdowns.getAmount(), fortShootdowns.isAttacker()); // Delega con cantidad y si es atacante
    }

    // Método para procesar derribos de nave
    public void processShootdowns(ShipShootdowns shipShootdowns) {
        processShootdowns(shipShootdowns.getAmount(), shipShootdowns.getAttacker(), shipShootdowns.getAttackerCell()); // Delega
    }

    // Método para procesar derribos con cantidad y si es atacante
    public void processShootdowns(double amount, boolean attacker) {
        if(!attacker) totalDefenderLost += amount; // Si no es atacante, suma a pérdidas de defensor
        else totalAttackerLost += amount; // Sino, suma a pérdidas de atacante
    }

    // Método para procesar derribos con flota y celda
    public void processShootdowns(double amount, BattleFleet battleFleet, BattleFleetCell cell) {
        if(battleFleet.isAttacker()) totalDefenderLost += amount; // Si atacante, defensor pierde
        else totalAttackerLost += amount; // Sino, atacante pierde

        BattleShipCache battleShipCache = new BattleShipCache(); // Crea cache de nave
        battleShipCache.setGuid(battleFleet.getGuid()); // Establece GUID
        battleShipCache.setShipModelId(cell.getShipModelId()); // Establece modelo
        battleShipCache.setShootdowns(amount); // Establece derribos

        processShootdowns(battleShipCache, shipHistoric); // Procesa en histórico
    }

    // Método para procesar cache de derribos en lista
    public void processShootdowns(BattleShipCache shipCache, List<BattleShipCache> shipCacheList) {
        Optional<BattleShipCache> optional = shipCacheList.stream() // Busca cache existente
                .filter(cache -> cache.getGuid() == shipCache.getGuid() && cache.getShipModelId() == shipCache.getShipModelId())
                .findFirst();

        if(optional.isPresent()) { // Si existe
            BattleShipCache current = optional.get(); // Obtiene actual
            current.setShootdowns(current.getShootdowns() + shipCache.getShootdowns()); // Suma derribos
        } else shipCacheList.add(shipCache); // Sino, agrega nuevo
    }

}
