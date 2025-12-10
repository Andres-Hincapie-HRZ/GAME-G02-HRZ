// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de recursos y datos relacionados con naves
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego
import com.go2super.resources.data.ShipBodyData; // Datos de cuerpo de nave
import com.go2super.resources.data.ShipPartData; // Datos de partes de nave
import com.go2super.resources.data.meta.*; // Metadatos de recursos (BodyLevelMeta, PartEffectMeta, etc.)
import com.go2super.service.PacketService; // Servicio de paquetes

// Importaciones de Lombok
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Column; // Anotación para columna de base de datos
import javax.persistence.Id; // Anotación para ID de entidad

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.HashMap; // Mapa hash
import java.util.List; // Interfaz de lista
import java.util.Map; // Interfaz de mapa

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_models"
@Document(collection = "game_models")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa un modelo de nave en el juego
public class ShipModel {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del modelo de nave

    // Campo único para ID del modelo de nave
    @Column(unique = true) // Restricción de unicidad
    private int shipModelId; // ID único del modelo de nave
    private int guid; // GUID del usuario propietario

    // Campos básicos del modelo
    private String name; // Nombre del modelo
    private int bodyId; // ID del cuerpo/casco de la nave

    // Campo de estado
    private boolean deleted; // Si el modelo está marcado como eliminado

    // Lista de partes que componen el modelo
    private List<Integer> parts = new ArrayList<>(); // IDs de las partes equipadas

    // Método para obtener metadatos de todas las partes equipadas
    public List<PartLevelMeta> getPartsMeta() { // Retorna lista de metadatos de partes
        List<PartLevelMeta> partLevelMetas = new ArrayList<>(); // Lista resultado
        for (int partId : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(partId); // Obtiene datos de parte
            partLevelMetas.add(partData.getLevel(partId)); // Agrega metadatos de nivel
        }
        return partLevelMetas; // Retorna lista completa
    }

    // Método para obtener el tiempo de inicio de transmisión
    public int getTransmissionStart() { // Retorna tiempo de inicio de transmisión
        if(PacketService.getInstance().isFastTransmission()) // Si transmisión rápida activada
            return 2; // Retorna 2 (transmisión rápida)

        int result = 0; // Resultado acumulado

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo
        if(body != null) result += body.getTransmission().getStart(); // Suma tiempo de inicio

        return result; // Retorna tiempo total
    }

    // Método para obtener la tasa de transmisión
    public int getTransmissionRate() { // Retorna tasa de transmisión
        if(PacketService.getInstance().isFastTransmission()) // Si transmisión rápida activada
            return 2; // Retorna 2 (transmisión rápida)

        int result = 0; // Resultado acumulado

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo
        if(body != null) result += body.getTransmission().getRate(); // Suma tasa

        return result; // Retorna tasa total
    }

    // Método para calcular el tiempo total de construcción
    public int getBuildTime() { // Retorna tiempo total de construcción en segundos
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartLevelMeta meta = ResourceManager.getShipParts().getMeta(part); // Obtiene metadatos

            if(meta == null) // Si no existen metadatos
                continue; // Salta esta parte

            result += meta.getBuildCost().getTime(); // Suma tiempo de construcción
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getBuildCost().getTime(); // Suma tiempo del cuerpo

        return result; // Retorna tiempo total
    }

    // Método para calcular el costo de construcción en metal
    public int getMetalBuildCost() { // Retorna costo total en metal
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartLevelMeta meta = ResourceManager.getShipParts().getMeta(part); // Obtiene metadatos

            if(meta == null) // Si no existen metadatos
                continue; // Salta esta parte

            result += meta.getBuildCost().getMetal(); // Suma costo en metal
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getBuildCost().getMetal(); // Suma costo del cuerpo

        return result; // Retorna costo total en metal
    }

    // Método para calcular el costo de construcción en He3
    public int getHe3BuildCost() { // Retorna costo total en He3
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartLevelMeta meta = ResourceManager.getShipParts().getMeta(part); // Obtiene metadatos

            if(meta == null) // Si no existen metadatos
                continue; // Salta esta parte

            result += meta.getBuildCost().getFuel(); // Suma costo en combustible (He3)
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getBuildCost().getFuel(); // Suma costo del cuerpo

        return result; // Retorna costo total en He3
    }

    // Método para calcular el costo de construcción en oro
    public int getGoldBuildCost() { // Retorna costo total en oro
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartLevelMeta meta = ResourceManager.getShipParts().getMeta(part); // Obtiene metadatos

            if(meta == null) // Si no existen metadatos
                continue; // Salta esta parte

            result += meta.getBuildCost().getGold(); // Suma costo en oro
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getBuildCost().getGold(); // Suma costo del cuerpo

        return result; // Retorna costo total en oro
    }

    // Método para calcular la durabilidad total (estructura + escudos)
    public int getDurability() { // Retorna durabilidad total de la nave
        return getStructure() + getShields(); // Suma estructura y escudos
    }

    // Método para calcular la estructura total
    public int getStructure() { // Retorna puntos de estructura
        int result = 0; // Resultado acumulado
        PartEffectMeta effect; // Variable para efectos de partes

        for(int part : parts) { // Itera sobre cada parte
            effect = ResourceManager.getShipParts().getEffect(part, "structure"); // Obtiene efecto de estructura
            result += effect != null ? (double) effect.getValue() : 0; // Suma valor si existe
            effect = ResourceManager.getShipParts().getEffect(part, "armor"); // Obtiene efecto de armadura
            result += effect != null ? (double) effect.getValue() : 0; // Suma valor si existe
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getArmor(); // Suma armadura del cuerpo

        return result; // Retorna estructura total
    }

    // Método para calcular el almacenamiento de combustible
    public int getFuelStorage() { // Retorna capacidad de almacenamiento de He3
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "fuelStorage"); // Obtiene efecto
            result += effect != null ? (double) effect.getValue() : 0; // Suma capacidad si existe
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getFuelStorage(); // Suma capacidad del cuerpo

        return result; // Retorna capacidad total
    }

    // Método para calcular el consumo de combustible
    public double getFuelUsage() { // Retorna consumo de He3 por movimiento
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            double effect = ResourceManager.getShipParts().getMeta(part).getFuelUsage(); // Obtiene consumo
            result += effect; // Suma consumo de cada parte
        }

        return result; // Retorna consumo total
    }

    // Método para calcular los escudos totales
    public int getShields() { // Retorna puntos de escudo
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "shield"); // Obtiene efecto de escudo
            result += effect != null ? (double) effect.getValue() : 0; // Suma valor si existe
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getShield(); // Suma escudos del cuerpo

        return result; // Retorna escudos totales
    }

    // Método para obtener el rango mínimo de ataque
    public int getMinRange() { // Retorna rango mínimo de ataque
        int result = 0; // Resultado (inicializado en 0)

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "range"); // Obtiene efecto de rango

            if(effect == null) // Si no hay efecto
                continue; // Salta esta parte

            int range = (int) effect.getMin(); // Obtiene rango mínimo

            if(result == 0) // Si es el primer rango encontrado
                result = range; // Establece como resultado
            else if(result > range) // Si es menor que el actual
                result = range; // Actualiza resultado
        }

        return result; // Retorna rango mínimo
    }

    // Método para obtener el rango máximo de ataque
    public int getMaxRange() { // Retorna rango máximo de ataque
        int result = 0; // Resultado (inicializado en 0)

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "range"); // Obtiene efecto de rango

            if(effect == null) // Si no hay efecto
                continue; // Salta esta parte

            int range = (int) effect.getMax(); // Obtiene rango máximo

            if(result == 0) // Si es el primer rango encontrado
                result = range; // Establece como resultado
            else if(result < range) // Si es mayor que el actual
                result = range; // Actualiza resultado
        }

        return result; // Retorna rango máximo
    }

    // Método para calcular el ataque mínimo total
    public int getMinAttack() { // Retorna ataque mínimo acumulado
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "attack"); // Obtiene efecto de ataque
            result += effect != null ? effect.getMin() : 0; // Suma ataque mínimo si existe
        }

        return result; // Retorna ataque mínimo total
    }

    // Método para calcular el ataque máximo total
    public int getMaxAttack() { // Retorna ataque máximo acumulado
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "attack"); // Obtiene efecto de ataque
            result += effect != null ? effect.getMax() : 0; // Suma ataque máximo si existe
        }

        return result; // Retorna ataque máximo total
    }

    // Método para calcular el movimiento total
    public int getMovement() { // Retorna puntos de movimiento
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "movement"); // Obtiene efecto de movimiento
            result += effect != null ? (double) effect.getValue() : 0; // Suma movimiento si existe
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getMovement(); // Suma movimiento del cuerpo

        return result; // Retorna movimiento total
    }

    // Método para obtener la tasa de doble ataque
    public double getDoubleRate() { // Retorna tasa de ataques dobles
        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo
        PartEffectMeta effect = body.getEffect("doubleRate"); // Obtiene efecto específico

        if(effect == null) // Si no hay efecto
            return 0; // Retorna 0

        return (double) effect.getValue(); // Retorna valor del efecto
    }

    // Método para obtener la tasa crítica
    public double getCritRate() { // Retorna tasa de golpes críticos
        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo
        PartEffectMeta effect = body.getEffect("critRate"); // Obtiene efecto específico

        if(effect == null) // Si no hay efecto
            return 0; // Retorna 0

        return (double) effect.getValue(); // Retorna valor del efecto
    }

    // Método para obtener bonos de armadura por tipo
    public Map<String, Double> getArmorBonus() { // Retorna mapa de bonos de armadura
        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo
        PartSpecialMeta[] effect = body.getSpecialEffect("armorBonus"); // Obtiene efectos especiales

        Map<String, Double> result = new HashMap<>(); // Mapa resultado

        if(effect == null) // Si no hay efectos
            return result; // Retorna mapa vacío

        for(PartSpecialMeta meta : effect) // Itera sobre efectos especiales
            result.put(meta.getArmor(), meta.getAmount()); // Agrega bono al mapa

        return result; // Retorna mapa de bonos
    }

    // Método para calcular la curación de armadura
    public int getArmorHeal() { // Retorna puntos de curación de armadura por turno
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "armorHeal"); // Obtiene efecto
            result += effect != null ? effect.getMax() : 0; // Suma curación máxima si existe
        }

        return result; // Retorna curación total de armadura
    }

    // Método para calcular la curación de escudos
    public int getShieldHeal() { // Retorna puntos de curación de escudos por turno
        int result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            PartEffectMeta effect = ResourceManager.getShipParts().getEffect(part, "shieldHeal"); // Obtiene efecto
            result += effect != null ? effect.getMax() : 0; // Suma curación máxima si existe
        }

        return result; // Retorna curación total de escudos
    }

    // Método para calcular bono de tasa crítica
    public double getCritRateBonus() { // Retorna bono adicional a tasa crítica
        String effectName = "critRateBonus"; // Nombre del efecto
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(part); // Obtiene datos de parte
            if(partData.getPartOperation() == null) { // Si no es una operación especial
                PartEffectMeta effect = partData.getLevel(part).getEffect(effectName); // Obtiene efecto
                result += effect != null ? (double) effect.getValue() : 0.00; // Suma bono si existe
            }
        }

        return result; // Retorna bono total
    }

    // Método para calcular agilidad total
    public double getAgility() { // Retorna agilidad para esquivar ataques
        String effectName = "agility"; // Nombre del efecto
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(part); // Obtiene datos de parte
            if(partData.getPartOperation() == null) { // Si no es una operación especial
                PartEffectMeta effect = partData.getLevel(part).getEffect(effectName); // Obtiene efecto
                result += effect != null ? (double) effect.getValue() : 0.00; // Suma agilidad si existe
            }
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getAgility(); // Suma agilidad del cuerpo

        return result; // Retorna agilidad total
    }

    // Método para calcular bono de dirección
    public double getSteeringBonus() { // Retorna bono para maniobrabilidad
        String effectName = "steeringBonus"; // Nombre del efecto
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(part); // Obtiene datos de parte
            if(partData.getPartOperation() == null) { // Si no es una operación especial
                PartEffectMeta effect = partData.getLevel(part).getEffect(effectName); // Obtiene efecto
                result += effect != null ? (double) effect.getValue() : 0.00; // Suma bono si existe
            }
        }

        return result; // Retorna bono total de dirección
    }

    // Método para calcular bono de tasa de acierto
    public double getHitRateBonus() { // Retorna bono adicional a tasa de acierto
        String effectName = "hitRateBonus"; // Nombre del efecto
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(part); // Obtiene datos de parte
            if(partData.getPartOperation() == null) { // Si no es una operación especial
                PartEffectMeta effect = partData.getLevel(part).getEffect(effectName); // Obtiene efecto
                result += effect != null ? (double) effect.getValue() : 0.00; // Suma bono si existe
            }
        }

        return result; // Retorna bono total de acierto
    }

    // Método para calcular estabilidad total
    public double getStability() { // Retorna estabilidad para mantener posición
        double result = 0; // Resultado acumulado

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getStability(); // Suma estabilidad del cuerpo

        return result; // Retorna estabilidad total
    }

    // Método para calcular bono de estabilidad
    public double getStabilityBonus() { // Retorna bono adicional de estabilidad
        String effectName = "stability"; // Nombre del efecto
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(part); // Obtiene datos de parte
            if(partData.getPartOperation() == null) { // Si no es una operación especial
                PartEffectMeta effect = partData.getLevel(part).getEffect(effectName); // Obtiene efecto
                result += effect != null ? (double) effect.getValue() : 0.00; // Suma bono si existe
            }
        }

        return result; // Retorna bono total de estabilidad
    }

    // Método para calcular capacidad Daedalus (teletransportación)
    public double getDaedalus() { // Retorna capacidad de teletransportación
        String effectName = "daedalus"; // Nombre del efecto
        double result = 0; // Resultado acumulado

        for(int part : parts) { // Itera sobre cada parte
            ShipPartData partData = ResourceManager.getShipParts().findByPartId(part); // Obtiene datos de parte
            if(partData.getPartOperation() == null) { // Si no es una operación especial
                PartEffectMeta effect = partData.getLevel(part).getEffect(effectName); // Obtiene efecto
                result += effect != null ? (double) effect.getValue() : 0.00; // Suma capacidad si existe
            }
        }

        BodyLevelMeta body = ResourceManager.getShipBodies().getMeta(bodyId); // Obtiene metadatos del cuerpo

        if(body != null) // Si existen metadatos del cuerpo
            result += body.getDaedalus(); // Suma capacidad del cuerpo

        return result; // Retorna capacidad total de Daedalus
    }

    // Método para obtener datos del cuerpo de la nave
    public ShipBodyData getBodyData() { // Retorna datos completos del cuerpo
        return ResourceManager.getShipBodies().findByBodyId(bodyId);
    }

    // Método para obtener metadatos de nivel del cuerpo
    public BodyLevelMeta getBodyLevelMeta() { // Retorna metadatos de nivel del cuerpo
        return ResourceManager.getShipBodies().getMeta(bodyId);
    }

    // Método para verificar si es una nave insignia
    public boolean isFlagship() { // Retorna true si es nave insignia
        ShipBodyData body = ResourceManager.getShipBodies().findByBodyId(bodyId); // Obtiene datos del cuerpo
        return body != null && body.isFlagship(); // Verifica si es insignia
    }

    // Método para convertir lista de partes a arreglo
    public int[] partArray() { // Retorna arreglo de partes (máximo 50)
        int[] array = new int[50]; // Arreglo de tamaño fijo
        for(int i = 0; i < parts.size(); i++) // Itera sobre partes
            array[i] = parts.get(i); // Copia ID de parte
        return array; // Retorna arreglo
    }

    // Método para contar número de partes equipadas
    public int partNum() { // Retorna número de partes válidas (> 0)
        int count = 0; // Contador
        for(int part : parts) // Itera sobre partes
            if(part > 0) // Si es una parte válida
                count++; // Incrementa contador
        return count; // Retorna número de partes
    }

}
