// Paquete que contiene la clase, parte del módulo de base de datos para entidades de batalla
package com.go2super.database.entity.sub.battle.meta;

// Importaciones para tipos de datos, servicios de cálculo y tipos de efectos
import com.go2super.obj.game.IntegerArray; // Clase para arreglos de enteros
import com.go2super.service.battle.calculator.*; // Todas las clases de calculator (reductions, shootdowns, etc.)
import com.go2super.service.battle.type.EffectType; // Enum para tipos de efectos
import lombok.Getter; // Genera getters
import lombok.Setter; // Genera setters
import lombok.ToString; // Genera toString
import org.springframework.data.annotation.Transient; // Campo no persistente en DB

// Importaciones estándar de Java
import java.util.*; // Utilidades como Map, List, HashMap, ArrayList, etc.

// Anotaciones Lombok
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
public class ShipCellAttackMeta { // Clase para metadatos de ataque entre naves en celda de batalla

    // Campos públicos para reducciones en suministro y almacenamiento de fuente y objetivo
    public int sourceReduceSupply; // Reducción en suministro del atacante
    public int targetReduceSupply; // Reducción en suministro del defensor

    public int sourceReduceStorage; // Reducción en almacenamiento del atacante
    public int targetReduceStorage; // Reducción en almacenamiento del defensor

    // Reducciones en HP y número de naves del atacante
    public int sourceReduceHp; // Reducción en puntos de vida del atacante
    public int sourceReduceShipNum; // Reducción en número de naves del atacante

    // Arreglos para reducciones en escudo, estructura, número de naves y reparaciones del objetivo (9 posiciones)
    public int[] targetReduceShield = new int[9]; // Reducciones en escudo por posición
    public int[] targetReduceStructure = new int[9]; // Reducciones en estructura por posición

    public int[] targetReduceShipNum = new int[9]; // Reducciones en número de naves por posición
    public int[] targetRepairShipNum = new int[9]; // Reparaciones en número de naves por posición

    // Arreglos para partes del atacante: ID, número y tasa (7 posiciones)
    public int[] sourcePartId = new int[7]; // IDs de partes del atacante
    public int[] sourcePartNum = new int[7]; // Números de partes del atacante
    public int[] sourcePartRate = new int[7]; // Tasas de partes del atacante

    // Arreglos para partes del objetivo: ID y número (7 posiciones)
    public int[] targetPartId = new int[7]; // IDs de partes del objetivo
    public int[] targetPartNum = new int[7]; // Números de partes del objetivo

    // Animaciones de uso de habilidades de comandantes
    public int sourceSkill; // Habilidad usada por comandante atacante
    public int targetSkill; // Habilidad usada por comandante defensor

    // Animaciones de disparos con valores 0-7 para combinaciones de hits
    public int targetBlast; // Tipo de animación de impacto

    // Campos privados para uso interno (IDs de equipos, usuarios, etc.)
    private int fromShipTeamId; // ID del equipo de naves atacante
    private int toShipTeamId; // ID del equipo de naves defensor

    private int fromUserGuid; // GUID del usuario atacante
    private int toUserGuid; // GUID del usuario defensor

    private int fromAmount; // Cantidad relacionada con atacante
    private int toAmount; // Cantidad relacionada con defensor

    private int fromId; // ID genérico del atacante
    private int toId; // ID genérico del defensor

    private boolean attack; // Bandera de ataque

    // Campos para utilidad de matriz (posicionamiento de atacante y defensor)
    private int attackerDirection; // Dirección del atacante
    private int attackerSegmentedPosIndex; // Índice de posición segmentada del atacante
    private int attackerPosIndex; // Índice de posición del atacante
    private int attackerPos; // Posición del atacante

    private int defenderDirection; // Dirección del defensor
    private int defenderSegmentedPosIndex; // Índice de posición segmentada del defensor
    private int defenderPosIndex; // Índice de posición del defensor
    private int defenderPos; // Posición del defensor

    // Campos para utilidad de reproducción (playback)
    private ShipReduction reflectionReduction; // Reducción por reflexión

    // Listas de reducciones y derribos
    private List<ShipReduction> shipReductions; // Reducciones en naves
    private List<ShipShootdowns> shipShootdowns; // Derribos de naves
    private List<FortShootdowns> fortShootdowns; // Derribos de fuertes

    // Ataques más altos de atacante y defensor
    private ShipHighestAttack attackerHighestAttack; // Ataque más alto del atacante
    private ShipHighestAttack defenderHighestAttack; // Ataque más alto del defensor

    // Usos de módulos por defensor y atacante
    private List<ModuleUsage> defenderUsages; // Usos de módulos del defensor
    private List<ModuleUsage> attackerUsages; // Usos de módulos del atacante

    // Mapas de efectos por posición de nave para defensor y atacante
    private Map<ShipPosition, ShipEffects> defenderEffects = new HashMap<>(); // Efectos en defensor
    private Map<ShipPosition, ShipEffects> attackerEffects = new HashMap<>(); // Efectos en atacante

    // Lista de acciones de paquetes de ataque, no persistente
    @Transient
    private List<ShipAttackPacketAction> shipAttackPacketActions = new ArrayList<>(); // Acciones de ataque

    // Constructor que inicializa arreglos con valores por defecto
    public ShipCellAttackMeta() {
        Arrays.fill(targetReduceShield, 0); // Escudos con 0
        Arrays.fill(targetReduceStructure, -1); // Estructuras con -1
        Arrays.fill(targetReduceShipNum, 0); // Número de naves con 0
        Arrays.fill(targetRepairShipNum, 0); // Reparaciones con 0

        Arrays.fill(sourcePartId, -1); // IDs de partes fuente con -1
        Arrays.fill(sourcePartNum, -1); // Números de partes fuente con -1
        Arrays.fill(sourcePartRate, -1); // Tasas de partes fuente con -1

        Arrays.fill(targetPartId, -1); // IDs de partes objetivo con -1
        Arrays.fill(targetPartNum, -1); // Números de partes objetivo con -1
    }

    // Método para agregar una acción de paquete de ataque de nave a la lista
    public void add(ShipAttackPacketAction packetAction) {
        getShipAttackPacketActions().add(packetAction); // Agrega la acción a la lista
    }

    // Métodos para obtener buffers de IntegerArray de los arreglos de reducciones y partes
    public IntegerArray targetReduceShieldBuffer() { // Buffer de reducciones en escudo
        return new IntegerArray(targetReduceShield);
    }

    public IntegerArray targetReduceStructureBuffer() { // Buffer de reducciones en estructura
        return new IntegerArray(targetReduceStructure);
    }

    public IntegerArray targetReduceShipNumBuffer() { // Buffer de reducciones en número de naves
        return new IntegerArray(targetReduceShipNum);
    }

    public IntegerArray targetRepairShipNumBuffer() { // Buffer de reparaciones en número de naves
        return new IntegerArray(targetRepairShipNum);
    }

    public IntegerArray sourcePartIdBuffer() { // Buffer de IDs de partes del atacante
        return new IntegerArray(sourcePartId);
    }

    public IntegerArray sourcePartNumBuffer() { // Buffer de números de partes del atacante
        return new IntegerArray(sourcePartNum);
    }

    public IntegerArray sourcePartRateBuffer() { // Buffer de tasas de partes del atacante
        return new IntegerArray(sourcePartRate);
    }

    public IntegerArray targetPartIdBuffer() { // Buffer de IDs de partes del objetivo
        return new IntegerArray(targetPartId);
    }

    public IntegerArray targetPartNumBuffer() { // Buffer de números de partes del objetivo
        return new IntegerArray(targetPartNum);
    }

    // Método para establecer un efecto en el defensor en una posición específica
    public void setDefenderEffect(ShipPosition shipPosition, EffectType effectType, double value, int until) {
        // Si no existe entrada para la posición, crea una nueva con lista vacía de efectos
        if(!defenderEffects.containsKey(shipPosition))
            defenderEffects.put(shipPosition, ShipEffects.builder().effects(new ArrayList<>()).build());

        // Construye el nuevo efecto
        ShipEffect shipEffect = ShipEffect.builder()
                .effectType(effectType)
                .value(value)
                .until(until)
                .build();

        // Procesa el efecto en la celda de flota de batalla
        shipPosition.getBattleFleetCell().process(shipEffect);

        // Busca si ya existe un efecto del mismo tipo
        Optional<ShipEffect> optionalEffect = defenderEffects.get(shipPosition).getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

        if(optionalEffect.isPresent()) {
            // Si existe, actualiza el valor y duración
            ShipEffect effect = optionalEffect.get();
            effect.setValue(value);
            effect.setUntil(until);
        } else {
            // Si no existe, agrega el nuevo efecto
            defenderEffects.get(shipPosition).getEffects().add(shipEffect);
        }
    }

    // Método para obtener y remover un efecto específico del defensor
    public ShipEffect fetchDefenderAndRemove(ShipPosition shipPosition, EffectType effectType) {
        List<ShipEffect> shipEffects = getDefenderFleetEffects(shipPosition); // Obtiene efectos de la posición

        // Busca el efecto por tipo
        Optional<ShipEffect> optionalResult = shipEffects.stream().filter(shipEffect -> shipEffect.getEffectType() == effectType).findFirst();
        if(optionalResult.isEmpty()) return null; // Si no encuentra, retorna null

        shipEffects.remove(optionalResult.get()); // Remueve el efecto
        return optionalResult.get(); // Retorna el efecto removido
    }

    // Método para remover efectos específicos del defensor
    public void removeDefenderShipEffects(ShipPosition shipPosition, ShipEffect...shipEffects) {
        if(!defenderEffects.containsKey(shipPosition)) return; // Si no hay efectos, sale
        for(ShipEffect effect : shipEffects) { // Remueve cada efecto especificado
            defenderEffects.get(shipPosition).getEffects().remove(effect);
        }
    }

    // Método para obtener la lista de efectos del defensor en una posición
    public List<ShipEffect> getDefenderFleetEffects(ShipPosition shipPosition) {
        if(!defenderEffects.containsKey(shipPosition)) return new ArrayList<>(); // Retorna lista vacía si no existe
        return defenderEffects.get(shipPosition).getEffects(); // Retorna la lista de efectos
    }

    // Método para remover un efecto del atacante marcándolo para eliminación
    public void removeAttackerEffect(ShipPosition shipPosition, EffectType effectType) {
        // Si no existe entrada, crea una nueva
        if(!attackerEffects.containsKey(shipPosition))
            attackerEffects.put(shipPosition, ShipEffects.builder().effects(new ArrayList<>()).build());

        // Busca el efecto existente
        Optional<ShipEffect> optionalEffect = attackerEffects.get(shipPosition).getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

        if(optionalEffect.isPresent()) {
            // Si existe, marca para remover y establece until en -1
            ShipEffect effect = optionalEffect.get();
            effect.setRemove(true);
            effect.setUntil(-1);
        } else {
            // Si no existe, agrega un nuevo efecto marcado para remover
            attackerEffects.get(shipPosition).getEffects().add(ShipEffect.builder()
                    .effectType(effectType)
                    .remove(true)
                    .until(-1).build());
        }
    }

    // Método para remover un efecto del defensor marcándolo para eliminación
    public void removeDefenderEffect(ShipPosition shipPosition, EffectType effectType) {
        // Si no existe entrada, crea una nueva
        if(!defenderEffects.containsKey(shipPosition))
            defenderEffects.put(shipPosition, ShipEffects.builder().effects(new ArrayList<>()).build());

        // Busca el efecto existente
        Optional<ShipEffect> optionalEffect = defenderEffects.get(shipPosition).getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

        if(optionalEffect.isPresent()) {
            // Si existe, marca para remover y establece until en -1
            ShipEffect effect = optionalEffect.get();
            effect.setRemove(true);
            effect.setUntil(-1);
        } else {
            // Si no existe, agrega un nuevo efecto marcado para remover
            defenderEffects.get(shipPosition).getEffects().add(ShipEffect.builder()
                    .effectType(effectType)
                    .remove(true)
                    .until(-1).build());
        }
    }

    // Método para agregar un efecto al defensor, acumulando el valor si ya existe
    public void addDefenderEffect(ShipPosition shipPosition, EffectType effectType, double value, int until) {
        // Si no existe entrada, crea una nueva
        if(!defenderEffects.containsKey(shipPosition))
            defenderEffects.put(shipPosition, ShipEffects.builder().effects(new ArrayList<>()).build());

        // Construye el nuevo efecto
        ShipEffect shipEffect = ShipEffect.builder()
                .effectType(effectType)
                .value(value)
                .until(until)
                .build();

        // Procesa el efecto en la celda de flota
        shipPosition.getBattleFleetCell().process(shipEffect);

        // Busca efecto existente del mismo tipo
        Optional<ShipEffect> optionalEffect = defenderEffects.get(shipPosition).getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

        if(optionalEffect.isPresent()) {
            // Si existe, suma el valor al existente
            ShipEffect effect = optionalEffect.get();
            effect.setValue(value + effect.getValue());
            effect.setUntil(until);
        } else {
            // Si no existe, agrega el nuevo efecto
            defenderEffects.get(shipPosition).getEffects().add(shipEffect);
        }
    }

    // Método para agregar un efecto al atacante, acumulando el valor si ya existe
    public void addAttackerEffect(ShipPosition shipPosition, EffectType effectType, double value, int until) {
        // Si no existe entrada, crea una nueva
        if(!attackerEffects.containsKey(shipPosition))
            attackerEffects.put(shipPosition, ShipEffects.builder().effects(new ArrayList<>()).build());

        // Construye el nuevo efecto
        ShipEffect shipEffect = ShipEffect.builder()
                .effectType(effectType)
                .value(value)
                .until(until)
                .build();

        // Procesa el efecto en la celda de flota
        shipPosition.getBattleFleetCell().process(shipEffect);

        // Busca efecto existente del mismo tipo
        Optional<ShipEffect> optionalEffect = attackerEffects.get(shipPosition).getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

        if(optionalEffect.isPresent()) {
            // Si existe, suma el valor al existente
            ShipEffect effect = optionalEffect.get();
            effect.setValue(value + effect.getValue());
            effect.setUntil(until);
        } else {
            // Si no existe, agrega el nuevo efecto
            attackerEffects.get(shipPosition).getEffects().add(shipEffect);
        }
    }

    // Método para establecer un efecto en el atacante, sobrescribiendo si existe
    public void setAttackerEffect(ShipPosition shipPosition, EffectType effectType, double value, int until) {
        // Si no existe entrada, crea una nueva
        if(!attackerEffects.containsKey(shipPosition))
            attackerEffects.put(shipPosition, ShipEffects.builder().effects(new ArrayList<>()).build());

        // Construye el nuevo efecto
        ShipEffect shipEffect = ShipEffect.builder()
                .effectType(effectType)
                .value(value)
                .until(until)
                .build();

        // Procesa el efecto en la celda de flota
        shipPosition.getBattleFleetCell().process(shipEffect);

        // Busca efecto existente
        Optional<ShipEffect> optionalEffect = attackerEffects.get(shipPosition).getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

        if(optionalEffect.isPresent()) {
            // Si existe, sobrescribe el valor y duración
            ShipEffect effect = optionalEffect.get();
            effect.setValue(value);
            effect.setUntil(until);
        } else {
            // Si no existe, agrega el nuevo efecto
            attackerEffects.get(shipPosition).getEffects().add(shipEffect);
        }
    }

    // Método para obtener y remover un efecto específico del atacante
    public ShipEffect fetchAttackerAndRemove(ShipPosition shipPosition, EffectType effectType) {
        List<ShipEffect> shipEffects = getAttackerFleetEffects(shipPosition); // Obtiene efectos

        // Busca el efecto por tipo
        Optional<ShipEffect> optionalResult = shipEffects.stream().filter(shipEffect -> shipEffect.getEffectType() == effectType).findFirst();
        if(optionalResult.isEmpty()) return null; // Si no encuentra, retorna null

        shipEffects.remove(optionalResult.get()); // Remueve el efecto
        return optionalResult.get(); // Retorna el efecto removido
    }

    // Método para remover efectos específicos del atacante
    public void removeAttackerShipEffects(ShipPosition shipPosition, ShipEffect...shipEffects) {
        for(ShipEffect effect : shipEffects) { // Remueve cada efecto especificado
            attackerEffects.get(shipPosition).getEffects().remove(effect);
        }
    }

    // Método para obtener la lista de efectos del atacante en una posición
    public List<ShipEffect> getAttackerFleetEffects(ShipPosition shipPosition) {
        return attackerEffects.get(shipPosition).getEffects(); // Retorna la lista de efectos
    }

}
