// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de tipos de fortificación y ataque
import com.go2super.database.entity.type.BattleElementType; // Enum para tipos de elementos de batalla
import com.go2super.database.entity.type.SpaceFortAttackType; // Enum para tipos de ataque de fortificación espacial
import com.go2super.database.entity.type.SpaceFortType; // Enum para tipos de fortificación espacial

// Importaciones de utilidades
import com.go2super.logger.BotLogger; // Logger para el bot
import com.go2super.resources.ResourceManager; // Gestor de recursos
import com.go2super.resources.data.meta.FortificationEffectMeta; // Metadatos de efectos de fortificación
import com.go2super.resources.data.meta.FortificationLevelMeta; // Metadatos de niveles de fortificación

// Importaciones de servicios de batalla
import com.go2super.service.battle.astar.Node; // Nodo para pathfinding A*
import com.go2super.service.battle.calculator.FortReduction; // Reducción en fortificaciones

// Importaciones de Lombok
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.io.Serializable; // Para serialización
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa una fortificación en batalla, extiende BattleElement e implementa Serializable
public class BattleFort extends BattleElement implements Serializable {

    private SpaceFortType fortType; // Tipo de fortificación espacial
    private boolean defender; // Si es defensor

    private int fortId; // ID de la fortificación
    private int levelId; // ID del nivel

    private int maxHealth; // Salud máxima
    private int health; // Salud actual
    private int damage; // Daño que inflige

    private int targetShipTeamId = -1; // ID del equipo de naves objetivo

    private int radius; // Radio de alcance
    private int posX; // Posición X
    private int posY; // Posición Y

    private int guid; // GUID del propietario
    private long userId; // ID del usuario propietario

    // Constructor que inicializa la fortificación con tipo y nivel
    public BattleFort(SpaceFortType type, int levelId) {
        super(BattleElementType.FORTIFICATION); // Llama al constructor padre

        this.levelId = levelId; // Asigna ID de nivel
        this.fortType = type; // Asigna tipo de fortificación

        this.radius = type == SpaceFortType.COMMON_SPACE_STATION ? 2 : 1; // Establece radio basado en tipo

        FortificationLevelMeta meta = getMeta(); // Obtiene metadatos
        if(meta == null) { // Si no existen metadatos
            BotLogger.error("FortificationLevelMeta not found for fortType: " + type + " and levelId: " + levelId); // Log error
            return; // Sale del constructor
        }

        double endure = type == SpaceFortType.RBP_SPACE_STATION ? 300 : 1; // Valor base de resistencia

        Optional<FortificationEffectMeta> optionalAssault = meta.getEffect("assault"); // Obtiene efecto de asalto
        if(optionalAssault.isPresent()) this.damage = (int) optionalAssault.get().getValue(); // Establece daño

        Optional<FortificationEffectMeta> optionalEndure = meta.getEffect("endure"); // Obtiene efecto de resistencia
        if(optionalEndure.isPresent()) endure = optionalEndure.get().getValue(); // Actualiza resistencia

        this.maxHealth = (int) endure; // Establece salud máxima
        this.health = (int) endure; // Establece salud actual
    }

    // Método para aplicar reducción de salud
    public void doReduction(FortReduction fortReduction) {
        health = (int) Math.max(health - fortReduction.getHealthReduction(), 0); // Reduce salud, mínimo 0
    }

    // Método para crear reducción basada en daño recibido
    public FortReduction makeReduction(double damage) {
        double baseHealth = health; // Salud antes del daño
        health = (int) Math.max(health - damage, 0); // Aplica daño

        int healthReduction = (int) (health <= 0 ? baseHealth : baseHealth - health); // Calcula reducción
        return FortReduction.builder() // Construye reducción
                .healthReduction(healthReduction) // Establece reducción
                .build(); // Retorna reducción
    }

    // Método para obtener metadatos de fortificación
    public FortificationLevelMeta getMeta() {
        return getFortType().getData(levelId); // Obtiene datos del tipo y nivel
    }

    // Método para obtener rango de ataque
    public int getRange() {
        if(!hasCannon()) return 0; // Si no tiene cañón, rango 0
        if(isStation()) return 100; // Si es estación, rango 100

        if(fortType.isCommon()) { // Si es fortificación común
            FortificationLevelMeta meta = getLevelMeta(); // Obtiene metadatos de nivel
            return meta.getEffectValue("range"); // Retorna valor de rango
        }

        FortificationLevelMeta meta = ResourceManager.getRBPFortification().getLevelMeta(fortType.getDataId(), levelId); // Obtiene de RBP
        return meta.getEffectValue("range"); // Retorna valor de rango
    }

    // Método para obtener tipo de ataque
    public SpaceFortAttackType getAttackType() {
        if(!hasCannon()) return SpaceFortAttackType.NONE; // Si no tiene cañón, ninguno
        return getLevelMeta().getAttackType(); // Retorna tipo de ataque del nivel
    }

    // Método para obtener metadatos de nivel
    public FortificationLevelMeta getLevelMeta() {
        return ResourceManager.getFortification().getLevelMeta(fortType.getDataId(), levelId); // Obtiene metadatos
    }

    // Método para obtener tipo de construcción
    public int getBuildType() {
        return getFortType().getBuildType(); // Delega al tipo de fortificación
    }

    // Método para verificar si es atacante
    public boolean isAttacker() {
        return !defender; // Retorna opuesto de defender
    }

    // Método para verificar si tiene cañón
    public boolean hasCannon() {
        return fortType.isCannon(); // Delega al tipo
    }

    // Método para verificar si es estación
    public boolean isStation() {
        return fortType.isStation(); // Delega al tipo
    }

    // Método para verificar si puede atacar a un objetivo (implementa método abstracto)
    @Override
    public boolean canAttack(BattleElement target) {
        Node from = getNode(); // Nodo origen
        Node to = target.getNode(); // Nodo destino

        int distance = from.getHeuristic(to); // Calcula distancia heurística
        return distance >= 0 && distance <= getRange(); // Verifica si está en rango
    }

    // Método para verificar si está destruida
    public boolean isDestroyed() {
        return health <= 0; // Salud <= 0 significa destruida
    }

}
