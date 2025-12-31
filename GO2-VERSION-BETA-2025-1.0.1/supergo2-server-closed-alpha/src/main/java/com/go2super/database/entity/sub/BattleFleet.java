// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de entidades relacionadas con flotas y batalla
import com.go2super.database.entity.Commander; // Entidad comandante
import com.go2super.database.entity.Fleet; // Entidad flota
import com.go2super.database.entity.ShipModel; // Entidad modelo de nave
import com.go2super.database.entity.User; // Entidad usuario
import com.go2super.database.entity.type.BattleElementType; // Enum tipo de elemento de batalla

// Importaciones de objetos de juego
import com.go2super.obj.game.ShipTeamBody; // Cuerpo del equipo de naves
import com.go2super.obj.game.ShipTeamNum; // Número de naves en equipo

// Importaciones de metadatos de recursos
import com.go2super.resources.data.meta.BuildEffectMeta; // Metadatos de efecto de construcción

// Importaciones de servicios
import com.go2super.service.PacketService; // Servicio de paquetes
import com.go2super.service.battle.BattleFleetCell; // Celda de flota de batalla
import com.go2super.service.battle.BattleFleetTeam; // Equipo de flota de batalla
import com.go2super.service.battle.Match; // Clase de coincidencia de batalla

// Importaciones de servicios de batalla
import com.go2super.service.battle.astar.Node; // Nodo para pathfinding A*
import com.go2super.service.battle.calculator.FleetEffect; // Efecto individual en flota
import com.go2super.service.battle.calculator.FleetEffects; // Conjunto de efectos en flota
import com.go2super.service.battle.calculator.ShipProc; // Procedimiento de nave
import com.go2super.service.battle.calculator.ShipTechs; // Tecnologías de nave
import com.go2super.service.battle.module.BattleFleetAttackModule; // Módulo de ataque de flota
import com.go2super.service.battle.type.EffectType; // Enum para tipos de efectos
import com.go2super.service.battle.type.Target; // Enum para objetivos
import com.go2super.service.battle.type.TargetInterval; // Enum para intervalos de objetivo

// Importaciones de utilidades
import com.go2super.socket.util.DateUtil; // Utilidades de fecha
import com.go2super.socket.util.MathUtil; // Utilidades matemáticas

// Importaciones de Lombok
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones de Spring
import org.springframework.data.annotation.Transient; // Campo no persistente en DB

// Importaciones estándar de Java
import java.io.Serializable; // Para serialización
import java.util.ArrayList; // Lista dinámica
import java.util.Arrays; // Operaciones con arreglos
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa una flota en batalla, extiende BattleElement e implementa Comparable y Serializable
public class BattleFleet extends BattleElement implements Comparable<BattleFleet>, Serializable {

    // Matriz de ataque estática y transitoria (no se guarda en DB)
    @Transient
    public static final int[][] attackMatrix = {
            {6, 7, 8, 3, 4, 5, 0, 1, 2}, // Matriz de ataque para dirección 0
            {0, 3, 6, 1, 4, 7, 2, 5, 8}, // Matriz de ataque para dirección 1
            {0, 1, 2, 3, 4, 5, 6, 7, 8}, // Matriz de ataque para dirección 2
            {8, 5, 2, 7, 4, 1, 6, 3, 0}  // Matriz de ataque para dirección 3
    };

    private BattleCommander battleCommander; // Comandante de batalla
    private String name; // Nombre de la flota

    private int guid; // GUID del usuario propietario
    private int shipTeamId; // ID del equipo de naves

    private double he3; // Cantidad de He3 (combustible)
    private double maxHe3; // Máximo He3

    private int bodyId; // ID del cuerpo/casco

    // Campos comentados para objetivos (posiblemente obsoletos)
    // private BattleElementType targetType = BattleElementType.FLEET;
    // private int targetId = -1;

    private int target; // Objetivo de la flota
    private int targetInterval; // Intervalo de objetivo

    private int posX; // Posición X
    private int posY; // Posición Y

    private int direction; // Dirección de la flota
    private int maxRounds; // Máximo de rondas
    private int joinRound; // Ronda de unión

    private int roundAttack; // Ataque de ronda
    private int roundDurability; // Durabilidad de ronda

    private int movement; // Movimiento disponible

    private BattleFleetTeam team; // Equipo de la flota de batalla
    private boolean defender; // Si es defensor
    private boolean silent; // Si está silenciado

    private ShipProc proc; // Procedimiento de nave
    private ShipTechs techs; // Tecnologías de nave
    private String otherSkill; // Otra habilidad

    private boolean animation = false; // Si tiene animación
    private FleetEffects effects = new FleetEffects(); // Efectos aplicados

    // Constructor que inicializa el tipo de elemento
    public BattleFleet() {
        super(BattleElementType.FLEET); // Llama al constructor padre
    }

    // Método privado para obtener la flota real del servicio
    private Fleet getRealFleet() {
        return PacketService.getInstance().getFleetCache().findByShipTeamId(shipTeamId); // Busca flota por ID de equipo
    }

    // Método para actualizar la flota después de una batalla
    public void update(Match match) {
        // Si la batalla es virtual, no actualiza
        if(match.getMatchType().isVirtual()) return;
        // if(guid == -1) return; // Comentado: condición para piratas

        Fleet fleet = getRealFleet(); // Obtiene la flota real
        if(fleet == null) return; // Si no existe, sale

        // Actualiza posición, dirección y He3 en la flota real
        fleet.setPosX(getPosX());
        fleet.setPosY(getPosY());
        fleet.setDirection(getDirection());
        fleet.setHe3((int) getHe3());

        // Si no quedan naves, remueve la flota
        if(fleet.ships() <= 0) fleet.remove();
        else fleet.save(); // Sino, guarda

        User user = fleet.getUser(); // Obtiene el usuario propietario
        if(user == null) return; // Si no existe usuario, sale

        double shipRepairRate = 0.0d; // Tasa de reparación de naves
        UserBuilding spaceDock = user.getBuildings().getBuilding("build:shipRepair"); // Obtiene astillero

        if(spaceDock != null) { // Si existe astillero
            BuildEffectMeta repairEffect = spaceDock.getLevelData().getEffect("shipRepair"); // Obtiene efecto de reparación
            shipRepairRate = repairEffect.getValue(); // Establece tasa de reparación
        }

        UserShips userShips = user.getShips(); // Obtiene naves del usuario
        Commander commander = fleet.getCommander(); // Obtiene comandante

        if(fleet.ships() <= 0) { // Si la flota está destruida
            // Lógica de reparación comentada
            if(false && shipRepairRate > 0.0d) { // Si hay tasa de reparación
                ShipTeamBody shipTeamBody = fleet.getFleetBody(); // Obtiene cuerpo del equipo

                for(ShipTeamNum teamNum : shipTeamBody.getCells()) { // Itera sobre celdas
                    if(teamNum.getShipModelId() == -1 || teamNum.getNum() <= 0) continue; // Salta celdas vacías

                    int repairNum = (int) (teamNum.getNum() * shipRepairRate); // Calcula reparaciones
                    if(repairNum < 0.0d) continue; // Si no hay reparaciones, salta

                    userShips.addRepair(teamNum.getShipModelId(), repairNum); // Agrega reparaciones
                }
            }

            // Lógica para comandante Angla (descanso de 2 días)
            if(commander.isAngla()) commander.setUntilRest(DateUtil.now(172800)); // 2 days
            else { // Para otros comandantes
                boolean kill = MathUtil.random(1, 100) >= 50; // 50% chance de morir
                commander.setDead(kill); // Establece si está muerto
                commander.setInjuredMatch(match.getId()); // Establece batalla donde resultó herido

                if(!kill) commander.setUntilRest(DateUtil.now(345600)); // 4 days si no muere
            }

            commander.save(); // Guarda comandante
        } else { // Si la flota sobrevive
            commander.save(); // Guarda comandante
        }

        ShipTeamBody shipTeamBody = fleet.getFleetBody(); // Obtiene cuerpo del equipo
        int index = 0; // Índice para iteración

        for(int i = 0; i < 9; i++) { // Itera sobre las 9 celdas
            BattleFleetCell battleFleetCell = getCell(i); // Obtiene celda de batalla

            ShipTeamNum oldNum = shipTeamBody.getCells().get(i); // Obtiene número anterior
            ShipTeamNum teamNum = new ShipTeamNum(); // Crea nuevo número de equipo
            teamNum.setShipModelId(battleFleetCell.getShipModelId()); // Establece ID del modelo
            teamNum.setNum(battleFleetCell.getAmount()); // Establece cantidad

            // Lógica de reparación comentada
            if(false && oldNum.getNum() > teamNum.getNum() && shipRepairRate > 0.0d) {
                int repairNum = (int) ((oldNum.getNum() - teamNum.getNum()) * shipRepairRate);
                if(repairNum > 0) userShips.addRepair(oldNum.getShipModelId(), repairNum);
            }

            shipTeamBody.cells.set(index++, teamNum); // Actualiza celda
        }

        // Si la flota está destruida, maneja comandante y remueve flota
        if(isDestroyed()) {
            if(commander.isAngla()) commander.setUntilRest(DateUtil.now(172800)); // 2 days
            else {
                boolean kill = MathUtil.random(1, 100) >= 50; // 50% chance
                commander.setDead(kill);
                commander.setInjuredMatch(match.getId());

                if(!kill) commander.setUntilRest(DateUtil.now(345600)); // 4 days
            }

            commander.save(); // Guarda comandante
            fleet.remove(); // Remueve flota
        }
    }

    // Método para calcular estadísticas de la flota
    public void calculate() {
        calculateDurability(); // Calcula durabilidad
        calculateAttack(); // Calcula ataque
        calculateMovement(); // Calcula movimiento
    }

    // Método para resetear estadísticas de ronda
    public void reset() {
        roundAttack = 0; // Resetea ataque de ronda
        roundDurability = 0; // Resetea durabilidad de ronda
    }

    // Método para procesar un efecto en la flota
    public void process(FleetEffect fleetEffect) {
        // Busca efecto existente del mismo tipo
        Optional<FleetEffect> optionalEffect = effects.getEffects().stream().filter(effect -> effect.getEffectType() == fleetEffect.getEffectType()).findFirst();

        if(optionalEffect.isPresent()) { // Si existe
            FleetEffect effect = optionalEffect.get();
            effect.setValue(effect.getValue() + fleetEffect.getValue()); // Acumula valor
            effect.setUntil(fleetEffect.getUntil()); // Actualiza duración

            // Si valor es 0, remueve efecto
            if(effect.getValue() == 0 || fleetEffect.getValue() == 0) effects.getEffects().remove(effect);
            return;
        }

        if(fleetEffect.getValue() == 0) return; // Si valor es 0, no agrega
        effects.getEffects().add(fleetEffect); // Agrega efecto
    }

    // Método para verificar si la flota está anulada (silenciada o con efectos específicos)
    public boolean isNullified() {
        return silent || getEffects().contains(EffectType.REGGIE) || getEffects().contains(EffectType.CIRCE); // Verifica condiciones de anulación
    }

    // Método para verificar si la flota está comandada por una habilidad específica
    public boolean isCommanded(String commanderNameId) {
        if(isNullified()) return false; // Si anulada, retorna false
        if(!battleCommander.getNameId().equals(commanderNameId) && !commanderNameId.equals(otherSkill)) return false; // Verifica nombre de habilidad
        return true; // Retorna true si coincide
    }

    // Método para verificar si se activa un trigger de habilidad
    public boolean trigger(String commanderNameId) {
        if(!battleCommander.getNameId().equals(commanderNameId) && !commanderNameId.equals(otherSkill)) return false; // Verifica nombre

        double rate = battleCommander.getTrigger().getRate(); // Obtiene tasa de activación
        double random = MathUtil.random(1, 100); // Número aleatorio
        return random <= rate; // Retorna true si se activa
    }

    // Método sobrecargado para trigger con ronda específica
    public boolean trigger(String commanderNameId, int round) {
        if(!battleCommander.getNameId().equals(commanderNameId)) return false; // Verifica nombre

        if(proc == null || proc.getRound() != round) { // Si no hay proc o ronda diferente
            double rate = battleCommander.getTrigger().getRate(); // Obtiene tasa

            proc = new ShipProc(); // Crea nuevo proc
            proc.setRate(rate * 0.01); // Establece tasa
            proc.setRound(round); // Establece ronda

            proc.setTriggered(MathUtil.random(1, 100) <= rate); // Determina si se activa
            return proc.isTriggered(); // Retorna estado
        }

        return proc.isTriggered(); // Retorna estado existente
    }

    // Método para ordenar celdas de flota por dirección deseada
    public List<BattleFleetCell> sortFleetByDirection(int desiredDirection) {
        List<BattleFleetCell> result = new ArrayList<>(team.getCells()); // Copia celdas

        for(int positionIndex = 0; positionIndex < 9; positionIndex++) { // Itera sobre posiciones
            int currentPosition = attackMatrix[direction][positionIndex]; // Posición actual
            int desiredPosition = attackMatrix[desiredDirection][positionIndex]; // Posición deseada

            result.set(desiredPosition, team.getCells().get(currentPosition)); // Reordena
        }

        return result; // Retorna lista reordenada
    }

    // Método para obtener cantidad total de naves
    public int getAmount() {
        int amount = 0; // Contador

        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.hasShips()) amount += cell.getAmount(); // Suma cantidad si tiene naves

        return amount; // Retorna total
    }

    // Método para calcular durabilidad de ronda
    public int calculateDurability() {
        if(roundDurability != 0) return roundDurability; // Si ya calculado, retorna

        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.hasShips()) // Si tiene naves
                roundDurability += PacketService.getShipModel(cell.getShipModelId()).getDurability() * cell.getAmount(); // Suma durabilidad

        return roundDurability; // Retorna durabilidad total
    }

    // Método para calcular ataque de ronda
    public int calculateAttack() {
        if(roundAttack != 0) return roundAttack; // Si ya calculado, retorna

        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.hasShips()) // Si tiene naves
                roundAttack += PacketService.getShipModel(cell.getShipModelId()).getMinAttack() * cell.getAmount(); // Suma ataque mínimo

        return roundAttack; // Retorna ataque total
    }

    // Método para calcular movimiento
    public int calculateMovement() {
        int result = Integer.MAX_VALUE; // Inicializa con máximo

        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.hasShips()) { // Si tiene naves
                int cache = cell.getMovement(); // Obtiene movimiento de celda

                if (cache < result) result = cache; // Actualiza mínimo
            }

        if(result == Integer.MAX_VALUE) result = 0; // Si no hay celdas, establece 0

        movement = result; // Asigna movimiento
        return movement; // Retorna movimiento
    }

    // Método para verificar si puede atacar a un objetivo
    public boolean canAttack(BattleElement target) {
        Node from = getNode(); // Nodo origen
        Node to = target.getNode(); // Nodo destino

        int distance = from.getHeuristic(to); // Calcula distancia heurística
        return distance >= getMinRange() && distance <= getMaxRange(); // Verifica rango
    }

    // Método para establecer dirección
    public void setDirection(int direction) {
        this.direction = direction; // Asigna dirección
    }

    // Método para verificar si es defensor
    public boolean isDefender() {
        return defender; // Retorna estado de defensor
    }

    // Método para verificar si es atacante
    public boolean isAttacker() {
        return !defender; // Retorna opuesto de defensor
    }

    // Método para verificar si es enemigo de otra flota
    public boolean isEnemy(BattleFleet fleet) {
        if(fleet.isAttacker() && isAttacker()) return false; // Ambos atacantes, no enemigos
        if(fleet.isDefender() && isDefender()) return false; // Ambos defensores, no enemigos
        return true; // Sino, son enemigos
    }

    // Método para obtener ID de equipo (1 para atacante, 0 para defensor)
    public int getTeamId() {
        return isAttacker() ? 1 : 0; // Retorna ID basado en rol
    }

    // Método para contar naves totales
    public int ships() {
        int number = 0; // Contador
        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.getShipModelId() > -1 && cell.getAmount() > 0) // Si tiene modelo válido y cantidad > 0
                number += cell.getAmount(); // Suma cantidad
        return number; // Retorna total
    }

    // Método para obtener rango mínimo de ataque
    public int getMinRange() {
        int result = 0; // Inicializa resultado

        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.getShipModelId() >= -1 && cell.getAmount() > 0) { // Si tiene modelo y cantidad
                List<BattleFleetAttackModule> weapons = cell.getWeaponModules(true); // Obtiene módulos de arma

                for(BattleFleetAttackModule fleetAttackModule : weapons) // Itera sobre armas
                    if(result == 0) // Si es el primero
                        result = fleetAttackModule.getMinRange(); // Establece rango mínimo
                    else if(result > fleetAttackModule.getMinRange()) // Si es menor
                        result = fleetAttackModule.getMinRange(); // Actualiza
            }

        return result; // Retorna rango mínimo
    }

    // Método para obtener rango máximo de ataque
    public int getMaxRange() {
        int result = 0; // Inicializa resultado

        for(BattleFleetCell cell : team.getCells()) // Itera sobre celdas
            if(cell.getShipModelId() >= -1 && cell.getAmount() > 0) { // Si tiene modelo y cantidad
                List<BattleFleetAttackModule> weapons = cell.getWeaponModules(true); // Obtiene módulos de arma

                for(BattleFleetAttackModule fleetAttackModule : weapons) { // Itera sobre armas
                    int maxRange = fleetAttackModule.getMaxRange(techs); // Obtiene rango máximo con techs
                    if (result == 0) // Si es el primero
                        result = maxRange; // Establece
                    else if (result < maxRange) // Si es mayor
                        result = maxRange; // Actualiza
                }
            }

        return result; // Retorna rango máximo
    }

    // Método para obtener durabilidad total
    public int getTotalDurability() {
        int durability = 0; // Contador

        for(BattleFleetCell cell : getCells()) // Itera sobre celdas
            if(cell.hasShips()) durability += (cell.getShields() + cell.getStructure()); // Suma escudos + estructura

        return durability; // Retorna durabilidad total
    }

    // Método para obtener estructura total
    public int getTotalStructure() {
        int structure = 0; // Contador
        for(BattleFleetCell cell : getCells()) // Itera sobre celdas
            if(cell.hasShips()) structure += cell.getStructure(); // Suma estructura
        return structure; // Retorna estructura total
    }

    // Método para obtener escudos totales
    public int getTotalShields() {
        int shields = 0; // Contador
        for(BattleFleetCell cell : getCells()) // Itera sobre celdas
            if(cell.hasShips()) shields += cell.getShields(); // Suma escudos
        return shields; // Retorna escudos totales
    }

    // Método para obtener poder de ataque (mínimo o máximo)
    public int getAttackPower(boolean min) {
        int attackPower = 0; // Contador

        for(BattleFleetCell cell : getCells()) // Itera sobre celdas
            if(cell.getShipModelId() >= -1 && cell.getAmount() > 0) { // Si tiene modelo y cantidad
                ShipModel model = PacketService.getShipModel(cell.getShipModelId()); // Obtiene modelo
                attackPower += (Long.valueOf(min ? model.getMinAttack() : model.getMaxAttack()) * Long.valueOf(cell.getAmount())); // Suma ataque
            }

        return attackPower; // Retorna poder de ataque
    }

    // Método para obtener objetivo de flota
    public Target getFleetTarget() {
        return target == 0 ? Target.MIN_RANGE : Target.MAX_RANGE; // Retorna objetivo basado en valor
    }

    // Método para obtener intervalo de objetivo
    public TargetInterval getFleetTargetInterval() {
        return Arrays.asList(TargetInterval.values()).get(targetInterval); // Obtiene de enum
    }

    // Método para obtener celda específica
    public BattleFleetCell getCell(int position) {
        return getTeam().getCells().get(position); // Retorna celda por posición
    }

    // Método para obtener todas las celdas
    public List<BattleFleetCell> getCells() {
        return getTeam().getCells(); // Retorna lista de celdas
    }

    // Método para verificar si está destruida
    public boolean isDestroyed() {
        for(BattleFleetCell cell : getCells()) // Itera sobre celdas
            if(cell.hasShips()) // Si alguna tiene naves
                return false; // No está destruida
        return true; // Está destruida
    }

    // Método para verificar si es pirata
    public boolean isPirate() {
        return guid == -1; // GUID -1 indica pirata
    }

    // Método para verificar si tiene comandante Rocky
    public boolean hasRocky() {
        int skill = battleCommander.getSkillId(); // Obtiene ID de habilidad
        return skill == 82 || skill == 53; // Verifica skills específicos
    }

    // Método para verificar si tiene comandante Robert
    public boolean hasRobert() {
        int skill = battleCommander.getSkillId(); // Obtiene ID de habilidad
        return skill == 78 || skill == 68 || skill == 45; // Verifica skills específicos
    }

    // Método para verificar si puede afectar a otra flota
    public boolean canAffect(BattleFleet other) {
        if(isCommanded("commander:rayo")) // Si comandado por Rayo
            if(battleCommander.isTotalMoreThan(other.getBattleCommander())) // Si total es mayor
                return false; // No puede afectar
        return true; // Puede afectar
    }

    // Método para obtener nave insignia opcional
    public Optional<ShipModel> getFlagship() {
        for(BattleFleetCell cell : getCells()) // Itera sobre celdas
            if(cell.hasShips()) { // Si tiene naves
                ShipModel model = PacketService.getShipModel(cell.getShipModelId()); // Obtiene modelo
                if(model.isFlagship()) // Si es insignia
                    return Optional.of(model); // Retorna opcional con modelo
            }
        return Optional.empty(); // Retorna vacío
    }

    // Método para comparar flotas por velocidad (implementa Comparable)
    @Override
    public int compareTo(BattleFleet fleet) {
        if(getBattleCommander().getTotalSpeed() > fleet.getBattleCommander().getTotalSpeed()) return -1; // Más rápido primero
        else if(getBattleCommander().getTotalSpeed() < fleet.getBattleCommander().getTotalSpeed()) return 1; // Más lento después
        else return 0; // Igual
    }

}
