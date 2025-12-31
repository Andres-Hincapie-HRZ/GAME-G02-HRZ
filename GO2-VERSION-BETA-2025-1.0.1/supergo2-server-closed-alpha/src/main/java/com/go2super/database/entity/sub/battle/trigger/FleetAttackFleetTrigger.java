// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importaciones de entidades y servicios relacionados con batalla
import com.go2super.database.entity.sub.BattleFleet; // Entidad que representa una flota en batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger; // Clase base para triggers de acciones de batalla
import com.go2super.database.entity.sub.battle.meta.ShipCellAttackMeta; // Metadatos de ataque entre naves
import com.go2super.service.battle.calculator.FleetEffect; // Efecto individual en flota
import com.go2super.service.battle.calculator.FleetEffects; // Conjunto de efectos en flota
import com.go2super.service.battle.calculator.ShipAttackPacketAction; // Acción de paquete de ataque de nave
import com.go2super.service.battle.type.EffectType; // Enum para tipos de efectos
import lombok.Getter; // Genera getters
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.Setter; // Genera setters
import lombok.ToString; // Genera toString
import lombok.experimental.SuperBuilder; // Genera builder con herencia
import org.springframework.data.annotation.Transient; // Campo no persistente en DB

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Anotaciones Lombok
@Getter // Genera getters para todos los campos
@Setter // Genera setters para todos los campos
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString que incluye superclase
// Clase que representa un trigger para ataque entre flotas en batalla
public class FleetAttackFleetTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // IDs de los equipos de naves atacante y defensor
    private int attackerShipTeamId; // ID del equipo atacante
    private int defenderShipTeamId; // ID del equipo defensor

    // Direcciones de ataque y defensa
    private int attackerDirection; // Dirección del atacante
    private int defensiveDirection; // Dirección del defensor

    // Lista de metadatos de ataques y matriz de ataque (9 posiciones)
    private List<ShipCellAttackMeta> attacks; // Lista de metadatos de ataques
    private int[] attackMatrix = new int[9]; // Matriz que representa el patrón de ataque

    // Bandera para animación de fuente y lista de efectos en flotas
    private boolean sourceAnimation = false; // Indica si hay animación de fuente
    private List<FleetEffects> fleetEffects = new ArrayList<>(); // Efectos aplicados a flotas

    // Pasos de repulsión
    private int repelSteps; // Número de pasos de repulsión

    // Lista de acciones de paquetes de ataque, no persistente
    @Transient
    private List<ShipAttackPacketAction> shipAttackPacketActions = new ArrayList<>(); // Acciones de ataque

    // Método para obtener metadatos de ataque por ID de origen
    public ShipCellAttackMeta getMeta(int fromId) { // Retorna metadatos de ataque para un ID específico
        // Itera sobre la lista de ataques
        for(ShipCellAttackMeta attackMeta : attacks)
            // Si el ID de origen coincide, retorna el metadato
            if(attackMeta.getFromId() == fromId)
                return attackMeta;
        // Si no encuentra, retorna null
        return null;
    }

    // Método sobrecargado para agregar efecto a flota, con opción de procesar
    public void addEffect(BattleFleet battleFleet, EffectType effectType, double value, int until, boolean process) {
        // Si process es true, procesa el efecto en la flota
        if(process) battleFleet.process(FleetEffect.builder().effectType(effectType).value(value).until(until).build());
        // Agrega el efecto usando el ID del equipo de naves
        addEffect(battleFleet.getShipTeamId(), effectType, value, until);
    }

    // Método para agregar efecto a flota, procesando automáticamente
    public void addEffect(BattleFleet battleFleet, EffectType effectType, double value, int until) {
        // Procesa el efecto en la flota
        battleFleet.process(FleetEffect.builder().effectType(effectType).value(value).until(until).build());
        // Agrega el efecto usando el ID del equipo de naves
        addEffect(battleFleet.getShipTeamId(), effectType, value, until);
    }

    // Método para establecer efecto en flota, procesando automáticamente
    public void setEffect(BattleFleet battleFleet, EffectType effectType, double value, int until) {
        // Procesa el efecto en la flota
        battleFleet.process(FleetEffect.builder().effectType(effectType).value(value).until(until).build());
        // Establece el efecto usando el ID del equipo de naves
        setEffect(battleFleet.getShipTeamId(), effectType, value, until);
    }

    // Método para agregar efecto por ID de equipo de naves, acumulando valor si existe
    public void addEffect(int shipTeamId, EffectType effectType, double value, int until) {
        // Busca efectos existentes para el equipo de naves
        Optional<FleetEffects> optionalEffects = fleetEffects.stream().filter(current -> current.getShipTeamId() == shipTeamId).findFirst();

        if(optionalEffects.isPresent()) { // Si ya existen efectos para este equipo
            FleetEffects effects = optionalEffects.get();
            // Busca efecto específico del tipo
            Optional<FleetEffect> optionalEffect = effects.getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

            if(optionalEffect.isPresent()) { // Si el efecto ya existe, suma el valor
                FleetEffect effect = optionalEffect.get();
                effect.setValue(value + effect.getValue()); // Acumula valor
                effect.setUntil(until); // Actualiza duración
            } else { // Si no existe, agrega nuevo efecto
                effects.getEffects().add(FleetEffect.builder()
                        .effectType(effectType)
                        .value(value)
                        .until(until)
                        .build());
            }
        } else { // Si no hay efectos para este equipo, crea nuevos
            FleetEffects effects = FleetEffects.builder()
                    .shipTeamId(shipTeamId)
                    .effects(new ArrayList<>())
                    .build();

            // Agrega el nuevo efecto
            effects.getEffects().add(FleetEffect.builder()
                    .effectType(effectType)
                    .value(value)
                    .until(until)
                    .build());

            // Agrega a la lista de efectos de flota
            fleetEffects.add(effects);
        }
    }

    // Método para establecer efecto por ID de equipo de naves, sobrescribiendo si existe
    public void setEffect(int shipTeamId, EffectType effectType, double value, int until) {
        // Busca efectos existentes para el equipo de naves
        Optional<FleetEffects> optionalEffects = fleetEffects.stream().filter(current -> current.getShipTeamId() == shipTeamId).findFirst();

        if(optionalEffects.isPresent()) { // Si ya existen efectos
            FleetEffects effects = optionalEffects.get();
            // Busca efecto específico del tipo
            Optional<FleetEffect> optionalEffect = effects.getEffects().stream().filter(current -> current.getEffectType() == effectType).findFirst();

            if(optionalEffect.isPresent()) { // Si existe, sobrescribe valor y duración
                FleetEffect effect = optionalEffect.get();
                effect.setValue(value); // Sobrescribe valor
                effect.setUntil(until); // Actualiza duración
            } else { // Si no existe, agrega nuevo efecto
                effects.getEffects().add(FleetEffect.builder()
                        .effectType(effectType)
                        .value(value)
                        .until(until)
                        .build());
            }
        } else { // Si no hay efectos, crea nuevos
            FleetEffects effects = FleetEffects.builder()
                    .shipTeamId(shipTeamId)
                    .effects(new ArrayList<>())
                    .build();

            // Agrega el nuevo efecto
            effects.getEffects().add(FleetEffect.builder()
                    .effectType(effectType)
                    .value(value)
                    .until(until)
                    .build());

            // Agrega a la lista de efectos de flota
            fleetEffects.add(effects);
        }
    }

    // Método sobrecargado para obtener y remover efecto de flota
    public FleetEffect fetchAndRemove(EffectType effectType, BattleFleet battleFleet) {
        // Llama al método con ID del equipo de naves
        return fetchAndRemove(effectType, battleFleet.getShipTeamId());
    }

    // Método para obtener y remover efecto específico por tipo y ID de equipo
    public FleetEffect fetchAndRemove(EffectType effectType, int shipTeamId) {
        // Obtiene la lista de efectos para el equipo
        List<FleetEffect> fleetEffects = getFleetEffects(shipTeamId);

        // Busca el efecto por tipo
        Optional<FleetEffect> optionalResult = fleetEffects.stream().filter(fleetEffect -> fleetEffect.getEffectType() == effectType).findFirst();
        if(optionalResult.isEmpty()) return null; // Si no encuentra, retorna null

        // Remueve el efecto de la lista
        fleetEffects.remove(optionalResult.get());
        // Retorna el efecto removido
        return optionalResult.get();
    }

    // Método para remover efectos específicos de un equipo de naves
    public void removeFleetEffects(int shipTeamId, FleetEffect...effects) {
        // Itera sobre todos los efectos de flota
        for(FleetEffects current : fleetEffects) {
            // Para cada efecto especificado
            for(FleetEffect effect : effects) {
                // Si el ID del equipo coincide, remueve el efecto
                if(current.getShipTeamId() == shipTeamId) {
                    current.getEffects().remove(effect);
                }
            }
        }
    }

    // Método para remover todos los efectos de un equipo de naves
    public void removeFleetEffects(int shipTeamId) {
        // Filtra y remueve todos los efectos del equipo especificado
        fleetEffects.stream().filter(fleetEffect -> fleetEffect.getShipTeamId() == shipTeamId).forEach(fleetEffect -> fleetEffects.remove(fleetEffect));
    }

    // Método para obtener lista de efectos de un equipo de naves específico
    public List<FleetEffect> getFleetEffects(int shipTeamId) {
        // Crea lista vacía para almacenar efectos
        List<FleetEffect> fleetEffects = new ArrayList<>();
        // Itera sobre todos los efectos de flota
        for(FleetEffects fleetEffect : getFleetEffects())
            // Si el ID del equipo coincide, agrega todos sus efectos
            if(fleetEffect.getShipTeamId() == shipTeamId)
                fleetEffects.addAll(fleetEffect.getEffects());
        // Retorna la lista de efectos
        return fleetEffects;
    }

}
