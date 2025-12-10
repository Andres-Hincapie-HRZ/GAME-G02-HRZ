// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de entidades relacionadas con comandantes y batalla
import com.go2super.database.entity.sub.BattleCommander; // Entidad para comandante en batalla
import com.go2super.database.entity.sub.BionicChip; // Entidad para chips biónicos
import com.go2super.database.entity.sub.CommanderExpertise; // Entidad para expertise de comandante
import com.go2super.database.entity.sub.UserPlanet; // Entidad para planeta de usuario
import com.go2super.database.entity.type.ExpertiseType; // Enum para tipos de expertise

// Importaciones de objetos de juego
import com.go2super.obj.game.CommanderAttributes; // Atributos del comandante
import com.go2super.obj.game.CommanderLevel; // Nivel del comandante

// Importaciones de recursos y datos
import com.go2super.resources.ResourceManager; // Gestor de recursos
import com.go2super.resources.data.CommanderLevelsData; // Datos de niveles de comandante
import com.go2super.resources.data.CommanderStatsData; // Datos de estadísticas de comandante
import com.go2super.resources.data.PropData; // Datos de propiedades
import com.go2super.resources.data.meta.ChipMeta; // Metadatos de chip
import com.go2super.resources.data.meta.EnemyStatsMeta; // Metadatos de estadísticas enemigas
import com.go2super.resources.data.meta.GemMeta; // Metadatos de gema
import com.go2super.resources.data.props.PropChipData; // Datos de propiedad de chip
import com.go2super.resources.data.props.PropGemData; // Datos de propiedad de gema
import com.go2super.resources.localization.Localization; // Localización de textos

// Importaciones de servicios
import com.go2super.service.BattleService; // Servicio de batalla
import com.go2super.service.CommanderService; // Servicio de comandante
import com.go2super.service.GalaxyService; // Servicio de galaxia
import com.go2super.service.PacketService; // Servicio de paquetes

// Importaciones de utilidades
import com.go2super.socket.util.MathUtil; // Utilidades matemáticas

// Importaciones de Lombok
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones de Apache Commons
import org.apache.commons.lang3.tuple.Pair; // Para pares de valores

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB
import org.springframework.data.mongodb.core.mapping.Document; // Anotación para documento MongoDB

// Importaciones de JPA
import javax.persistence.Column; // Anotación para columna de base de datos
import javax.persistence.Id; // Anotación para ID de entidad

// Importaciones estándar de Java
import java.util.*; // Utilidades de colecciones

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_commanders"
@Document(collection = "game_commanders")
// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa un comandante en el juego
public class Commander {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del comandante

    // Campo único para ID del comandante
    @Column(unique = true) private int commanderId; // ID único del comandante

    // Campos de asociación con usuario y equipo de naves
    private long userId; // ID del usuario propietario
    private int shipTeamId = -1; // ID del equipo de naves (-1 significa sin asignar)

    // Campo para nombre del comandante
    private String name; // Nombre del comandante

    // Campos de estadísticas básicas
    private int skill; // ID de la habilidad especial
    private int stars; // Número de estrellas (rareza)
    private int level; // Nivel actual
    private int experience; // Experiencia acumulada
    private int variance; // Varianza para aleatoriedad

    // Campos de estado del comandante con comentarios sobre valores posibles
    private Date untilRest; // Fecha hasta la que debe descansar
    private boolean dead; // Si el comandante está muerto
    private String injuredMatch; // ID de la batalla donde resultó herido

    // Campos de crecimiento de atributos
    private int growthAim; // Crecimiento en puntería
    private int growthDodge; // Crecimiento en esquiva
    private int growthSpeed; // Crecimiento en velocidad
    private int growthElectron; // Crecimiento en electrónica

    // Listas de equipamiento
    private List<Integer> gems = new ArrayList<>(); // Lista de IDs de gemas equipadas
    private List<BionicChip> chips = new ArrayList<>(); // Lista de chips biónicos equipados

    // Campos base para comandantes comunes (no legendarios)
    private int commonBaseAim; // Base de puntería para comunes
    private int commonBaseDodge; // Base de esquiva para comunes
    private int commonBaseSpeed; // Base de velocidad para comunes
    private int commonBaseElectron; // Base de electrónica para comunes

    // Expertise para comandantes comunes
    private CommanderExpertise commonExpertise; // Expertise del comandante común

    // Método para agregar experiencia al comandante
    public int addExp(int exp) { // Agrega experiencia y retorna la cantidad agregada
        if(isVinna()) exp = (int) (exp * (1.3)); // Bonus de 30% para Vinna
        if((this.experience + exp) >= CommanderService.MAXIMUM_EXPERIENCE) // Si excede el máximo
            this.experience = CommanderService.MAXIMUM_EXPERIENCE; // Limita al máximo
        else this.experience += exp; // Sino, suma la experiencia
        return exp; // Retorna la experiencia agregada
    }

    // Método para obtener el siguiente agujero disponible para chip
    public int getNextChipHole() { // Retorna el ID del siguiente agujero libre (0-4) o -1 si lleno
        int holeId; // Variable para el ID del agujero
        hole : for(holeId = 0; holeId < 5; holeId++) { // Itera sobre los 5 agujeros
            for (BionicChip chip : chips) // Para cada chip equipado
                if (chip.getHoleId() == holeId) // Si el agujero está ocupado
                    continue hole; // Salta al siguiente agujero
            return holeId; // Retorna el agujero libre encontrado
        }
        return -1; // Retorna -1 si todos los agujeros están ocupados
    }

    // Método para obtener el ID de propiedad del comandante
    public int propId() { // Retorna el ID de propiedad del comandante
        return CommanderService.getInstance().getPropId(this); // Delega al servicio
    }

    // Método para guardar el comandante en cache
    public void save() { // Guarda el comandante en el cache
        CommanderService.getInstance().getCommanderCache().save(this); // Delega al servicio
    }

    // Método para resetear el comandante (reiniciar estadísticas)
    public void reset() { // Resetea el comandante a valores iniciales
        if(isCommon()) { // Si es un comandante común
            setCommonBaseAim(MathUtil.random(0, 11)); // Randomiza base de puntería (0-10)
            setCommonBaseElectron(MathUtil.random(0, 11)); // Randomiza base de electrónica
            setCommonBaseDodge(MathUtil.random(0, 11)); // Randomiza base de esquiva
            setCommonBaseSpeed(MathUtil.random(0, 11)); // Randomiza base de velocidad
            setCommonExpertise(CommanderExpertise.common()); // Establece expertise común
        }
        this.experience = 0; // Resetea experiencia a 0
        randomizeGrowth(); // Randomiza crecimiento
        randomizeVariance(); // Randomiza varianza
    }

    // Método para crear un BattleCommander a partir de este Commander
    public BattleCommander createBattleCommander(double additionalGrowth, EnemyStatsMeta stats) {
        // Crea nueva instancia de BattleCommander
        BattleCommander commander = new BattleCommander();

        // Obtiene atributos base del servicio
        CommanderAttributes baseAttributes = CommanderService.getInstance().getBaseAttributes(this);

        // Establece propiedades básicas del comandante de batalla
        commander.setCommanderId(commanderId); // ID del comandante
        commander.setSkillId(skill); // ID de la habilidad
        commander.setExpertise(getExpertise()); // Expertise del comandante
        commander.setNameId(name); // ID del nombre
        commander.setName(Localization.EN_US.get(name)); // Nombre localizado
        commander.setStars(stars); // Número de estrellas

        // Variables para atributos totales
        double totalAim, totalDodge, totalSpeed, totalElectron;

        if(stats == null) { // Si no hay estadísticas enemigas (comandante aliado)
            // Calcula atributos totales usando métodos propios
            totalAim = getTotalAim(baseAttributes);
            totalDodge = getTotalDodge(baseAttributes);
            totalSpeed = getTotalSpeed(baseAttributes);
            totalElectron = getTotalElectron(baseAttributes);
        } else { // Si hay estadísticas enemigas (comandante enemigo)
            // Usa las estadísticas proporcionadas
            totalAim = stats.getAccuracy();
            totalDodge = stats.getDodge();
            totalSpeed = stats.getSpeed();
            totalElectron = stats.getElectron();
        }

        // Establece atributos totales en el comandante de batalla
        commander.setTotalAccuracy(totalAim);
        commander.setTotalDodge(totalDodge);
        commander.setTotalSpeed(totalSpeed);
        commander.setTotalElectron(totalElectron);

        // Calcula incrementos de combate de las gemas
        double attackIncrement = getStoneAssault(); // Incremento de ataque
        double structureIncrement = getStoneEndure(); // Incremento de estructura
        double shieldIncrement = getStoneShield(); // Incremento de escudo
        double criticalAttackIncrement = getStoneBlastHurt(); // Incremento de daño crítico
        double criticalAttackRateIncrement = getStoneBlastHurtRate(); // Incremento de tasa crítica
        double doubleAttackRateIncrement = getStoneDoubleHit(); // Incremento de tasa doble ataque
        double shieldHealIncrement = getStoneRepairShield(); // Incremento de curación escudo
        double experienceRateIncrement = getStoneExp(); // Incremento de tasa experiencia

        // Establece incrementos de combate en el comandante
        commander.setAttackPowerIncrement(attackIncrement);
        commander.setStructureIncrement(structureIncrement);
        commander.setShieldIncrement(shieldIncrement);
        commander.setCriticalAttackDamageIncrement(criticalAttackIncrement);
        commander.setCriticalAttackRateIncrement(criticalAttackRateIncrement);
        commander.setDoubleAttackRateIncrement(doubleAttackRateIncrement);
        commander.setShieldHealIncrement(shieldHealIncrement);
        commander.setExperienceRateIncrement(experienceRateIncrement);

        // Calcula atributos adicionales de los chips
        double additionalArmor = getChipAdditionalArmor(); // Armadura adicional
        double additionalShield = getChipAdditionalShield(); // Escudo adicional

        double additionalDaedalus = getChipAdditionalDaedalus(); // Daedalus adicional
        double additionalStability = getChipAdditionalStability(); // Estabilidad adicional
        double additionalAbsorption = getChipAdditionalAbsorption(); // Absorción adicional
        double additionalArmorRegeneration = getChipAdditionalArmorRegen(); // Regeneración armadura
        double additionalShieldRegeneration = getChipAdditionalShieldRegen(); // Regeneración escudo

        // Obtiene ataques adicionales de chips
        List<Pair<String, Double>> additionalMinAttack = getChipAdditionalMinAttack(); // Ataque mínimo adicional
        List<Pair<String, Double>> additionalMaxAttack = getChipAdditionalMaxAttack(); // Ataque máximo adicional

        // Establece atributos adicionales en el comandante
        commander.setAdditionalArmor(additionalArmor);
        commander.setAdditionalShield(additionalShield);

        commander.setAdditionalDaedalus(additionalDaedalus);
        commander.setAdditionalStability(additionalStability);
        commander.setAdditionalAbsorption(additionalAbsorption);
        commander.setAdditionalArmorRegeneration(additionalArmorRegeneration);
        commander.setAdditionalShieldRegeneration(additionalShieldRegeneration);

        commander.setAdditionalMinAttack(additionalMinAttack);
        commander.setAdditionalMaxAttack(additionalMaxAttack);

        // Establece nivel y trigger del comandante
        commander.setLevel(getLevel().getLevel()); // Nivel del comandante
        commander.setTrigger(CommanderService.getInstance().createTrigger(commander)); // Trigger de batalla

        return commander; // Retorna el comandante de batalla creado
    }

    // Método para obtener la flota asociada al comandante
    public Fleet getFleet() { // Retorna la flota del comandante o null si no tiene
        return PacketService.getInstance().getFleetCache().findByCommanderId(commanderId); // Busca por ID
    }

    // Método para verificar si el comandante tiene flota asignada
    public boolean hasFleet() { // Retorna true si tiene flota asignada
        return getFleet() != null; // Verifica si getFleet() retorna algo
    }

    // Métodos para calcular atributos totales incluyendo bonos de gemas
    public double getTotalAim(CommanderAttributes commanderAttributes) { // Puntería total
        return commanderAttributes.getAim() + getStoneAim(); // Base + bono de gemas
    }

    public double getTotalDodge(CommanderAttributes commanderAttributes) { // Esquiva total
        return commanderAttributes.getDodge() + getStoneDodge(); // Base + bono de gemas
    }

    public double getTotalSpeed(CommanderAttributes commanderAttributes) { // Velocidad total
        return commanderAttributes.getSpeed() + getStonePriority(); // Base + bono de gemas
    }

    public double getTotalElectron(CommanderAttributes commanderAttributes) { // Electrónica total
        return commanderAttributes.getElectron() + getStoneElectron(); // Base + bono de gemas
    }

    // Métodos para obtener atributos adicionales de chips (delegan a getChipAttribute)
    public double getChipAdditionalArmor() { // Armadura adicional de chips
        return getChipAttribute("armor");
    }

    public double getChipAdditionalShield() { // Escudo adicional de chips
        return getChipAttribute("shield");
    }

    public double getChipAdditionalDaedalus() { // Daedalus adicional de chips
        return getChipAttribute("daedalus");
    }

    public double getChipAdditionalStability() { // Estabilidad adicional de chips
        return getChipAttribute("stability");
    }

    public double getChipAdditionalAbsorption() { // Absorción adicional de chips
        return getChipAttribute("negation");
    }

    public double getChipAdditionalArmorRegen() { // Regeneración de armadura de chips
        return getChipAttribute("armorRepair");
    }

    public double getChipAdditionalShieldRegen() { // Regeneración de escudo de chips
        return getChipAttribute("shieldRepair");
    }

    // Métodos para obtener ataques adicionales de chips (delegan a getChipAttackAttribute)
    public List<Pair<String, Double>> getChipAdditionalMinAttack() { // Ataque mínimo adicional
        return getChipAttackAttribute("minAssault");
    }

    public List<Pair<String, Double>> getChipAdditionalMaxAttack() { // Ataque máximo adicional
        return getChipAttackAttribute("maxAssault");
    }

    // Métodos para obtener atributos de gemas (delegan a getGemAttribute)
    public double getStoneAim() { // Puntería de gemas
        return getGemAttribute("accuracy");
    }

    public double getStoneDodge() { // Esquiva de gemas
        return getGemAttribute("dodge");
    }

    public double getStoneElectron() { // Electrónica de gemas
        return getGemAttribute("electron");
    }

    public double getStonePriority() { // Prioridad (velocidad) de gemas
        return getGemAttribute("speed");
    }

    public double getStoneAssault() { // Asalto (ataque) de gemas
        return getGemAttribute("attack");
    }

    public double getStoneEndure() { // Resistencia (armadura) de gemas
        return getGemAttribute("armor");
    }

    public double getStoneShield() { // Escudo de gemas
        return getGemAttribute("shield");
    }

    public double getStoneBlastHurt() { // Daño crítico de gemas
        return getGemAttribute("critAttack");
    }

    public double getStoneBlastHurtRate() { // Tasa crítica de gemas
        return getGemAttribute("critRate");
    }

    public double getStoneDoubleHit() { // Tasa doble ataque de gemas
        return getGemAttribute("doubleRate");
    }

    public double getStoneRepairShield() { // Curación escudo de gemas
        return getGemAttribute("shieldHeal");
    }

    public double getStoneExp() { // Tasa experiencia de gemas
        return getGemAttribute("expRate");
    }

    // Métodos para obtener expertise de gemas (delegan a getGemExpertise)
    public ExpertiseType getStoneBallisticExpertise() { // Expertise balístico de gemas
        return getGemExpertise("expertiseBallistic");
    }

    public ExpertiseType getStoneMissileExpertise() { // Expertise de misiles de gemas
        return getGemExpertise("expertiseMissile");
    }

    public ExpertiseType getStoneDirectionalExpertise() { // Expertise direccional de gemas
        return getGemExpertise("expertiseDirectional");
    }

    public ExpertiseType getStoneShipBasedExpertise() { // Expertise basado en naves de gemas
        return getGemExpertise("expertiseShipBased");
    }

    public ExpertiseType getStoneDefendExpertise() { // Expertise defensivo de gemas
        return getGemExpertise("expertiseBuilding");
    }

    public ExpertiseType getStoneFrigateExpertise() { // Expertise de fragatas de gemas
        return getGemExpertise("expertiseFrigate");
    }

    public ExpertiseType getStoneCruiserExpertise() { // Expertise de cruceros de gemas
        return getGemExpertise("expertiseCruiser");
    }

    public ExpertiseType getStoneBattleshipExpertise() { // Expertise de acorazados de gemas
        return getGemExpertise("expertiseBattleship");
    }

    // Método para obtener atributo numérico de chips
    public double getChipAttribute(String name) { // Suma valores de chips que coinciden con el tipo
        double result = 0.0d; // Resultado acumulado
        List<BionicChip> chips = getChips(); // Obtiene lista de chips

        for(BionicChip chip : chips) { // Itera sobre cada chip
            ChipMeta chipMeta = chip.getChipData().getEffect(); // Obtiene metadatos del efecto
            if(chipMeta.getType().equals(name)) result += chipMeta.getValue(); // Suma si coincide el tipo
        }

        return result; // Retorna el total acumulado
    }

    // Método para obtener atributos de ataque de chips
    public List<Pair<String, Double>> getChipAttackAttribute(String name) { // Lista de pares tag-valor
        List<Pair<String, Double>> result = new ArrayList<>(); // Lista resultado
        List<BionicChip> chips = getChips(); // Obtiene lista de chips

        for(BionicChip chip : chips) { // Itera sobre cada chip
            PropChipData chipData = chip.getChipData(); // Obtiene datos del chip
            ChipMeta chipMeta = chipData.getEffect(); // Obtiene metadatos del efecto

            if(name.equals(chipMeta.getType())) // Si coincide el tipo
                result.add(Pair.of(chipMeta.getTag(), chipMeta.getValue())); // Agrega par tag-valor
        }

        return result; // Retorna lista de pares
    }

    // Método para obtener el mejor expertise de gemas para un tipo específico
    public ExpertiseType getGemExpertise(String name) { // Retorna el mejor expertise encontrado
        List<Integer> gems = getGems(); // Obtiene lista de gemas
        ExpertiseType result = ExpertiseType.D; // Valor por defecto

        for(int i = 0; i < getLevel().getLevelData().getGem(); i++) { // Itera sobre slots de gemas disponibles
            int gemId = gems.get(i); // Obtiene ID de gema en slot
            if(gemId == -1) continue; // Salta si no hay gema

            PropData gem = ResourceManager.getProps().getGemData(gemId); // Obtiene datos de gema
            if(gem == null) continue; // Salta si no existen datos

            PropGemData data = gem.getGemData(); // Obtiene datos específicos de gema

            if(data.getEffects() != null && data.getEffects().size() > 0) // Si tiene efectos
                for(GemMeta meta : data.getEffects()) // Itera sobre efectos
                    if(meta.getType().equals(name)) { // Si coincide el tipo
                        String expertise = meta.getExpertise(); // Obtiene expertise
                        if(expertise == null) continue; // Salta si no hay expertise
                        ExpertiseType type = ExpertiseType.valueOf(expertise); // Convierte a enum
                        if (type.isBetterThan(result)) result = type; // Actualiza si es mejor
                    }
        }

        return result; // Retorna el mejor expertise encontrado
    }

    // Método para obtener atributo numérico acumulado de gemas
    public double getGemAttribute(String name) { // Suma valores de gemas que coinciden con el tipo
        List<Integer> gems = getGems(); // Obtiene lista de gemas
        double result = 0; // Resultado acumulado

        for(int i = 0; i < getLevel().getLevelData().getGem(); i++) { // Itera sobre slots disponibles
            int gemId = gems.get(i); // Obtiene ID de gema
            if(gemId == -1) continue; // Salta si no hay gema

            PropData gem = ResourceManager.getProps().getGemData(gemId); // Obtiene datos de gema
            if(gem == null) continue; // Salta si no existen datos

            PropGemData data = gem.getGemData(); // Obtiene datos específicos

            if(data.getEffects() != null && data.getEffects().size() > 0) // Si tiene efectos
                for(GemMeta meta : data.getEffects()) // Itera sobre efectos
                    if(meta.getType().equals(name)) // Si coincide el tipo
                        result += meta.getValue(); // Suma el valor
        }

        return result; // Retorna el total acumulado
    }

    // Método para obtener el nivel heredado (simplemente retorna el campo level)
    public int getInheritedLevel() { // Retorna el nivel actual
        return level;
    }

    // Método para obtener el objeto CommanderLevel completo
    public CommanderLevel getLevel() { // Retorna objeto con datos de nivel
        if(experience == -1) return CommanderLevel.builder() // Si experiencia es -1 (especial)
                .levelData(CommanderLevelsData.builder()
                        .exp(-1)
                        .gem(-1)
                        .build())
                .level(level)
                .levelExperience(-1)
                .build();
        return CommanderService.getInstance().getLevel(this); // Sino, obtiene del servicio
    }

    // Método para eliminar el comandante
    public void delete() { // Elimina el comandante del cache
        CommanderService.getInstance().getCommanderCache().delete(this);
    }

    // Métodos para verificar tipo de comandante basado en skill
    public boolean isPirate() { // Verifica si es pirata (skill -1)
        return commanderId == -1;
    }

    public boolean isCommon() { // Verifica si es común (skill -1)
        return skill == -1;
    }

    public boolean isAngla() { // Verifica si es Angla (skill 0)
        return skill == 0;
    }

    public boolean isVinna() { // Verifica si es Vinna (skill 34)
        return skill == 34;
    }

    public boolean isTitan() { // Verifica si es Titan (skills específicos)
        return Arrays.asList(85, 86, 87, 88, 89, 90, 94, 105, 106).contains(skill);
    }

    // Métodos para randomizar atributos
    public void randomizeGrowth() { // Randomiza crecimiento de atributos
        CommanderService.getInstance().randomizeGrowth(this);
    }

    public void randomizeVariance() { // Randomiza varianza
        CommanderService.getInstance().randomizeVariance(this);
    }

    // Métodos para obtener atributos base (diferentes para comunes y legendarios)
    public int getBaseAim() { // Puntería base
        return isCommon() ? commonBaseAim : getStats().getBaseStats().getAccuracy();
    }

    public int getBaseElectron() { // Electrónica base
        return isCommon() ? commonBaseElectron : getStats().getBaseStats().getElectron();
    }

    public int getBaseDodge() { // Esquiva base
        return isCommon() ? commonBaseDodge : getStats().getBaseStats().getDodge();
    }

    public int getBaseSpeed() { // Velocidad base
        return isCommon() ? commonBaseSpeed : getStats().getBaseStats().getSpeed();
    }

    // Método para obtener nombre localizado
    public String getName() { // Retorna nombre localizado o campo name para comunes
        return isCommon() ? name : Localization.EN_US.get(getStats().getName());
    }

    // Método para obtener tipo de comandante
    public int getType() { // Retorna 1 para comunes, sino código de tipo de stats
        return isCommon() ? 1 : getStats().typeCode();
    }

    // Método para obtener usuario propietario
    public User getUser() { // Retorna usuario propietario del comandante
        UserPlanet userPlanet = getUserPlanet(); // Obtiene planeta del usuario
        if(userPlanet == null) return null; // Si no hay planeta, retorna null
        Optional<User> optionalUser = userPlanet.getUser(); // Obtiene usuario opcional
        if(optionalUser.isEmpty()) return null; // Si está vacío, retorna null
        return optionalUser.get(); // Retorna el usuario
    }

    // Método para obtener planeta del usuario
    public UserPlanet getUserPlanet() { // Retorna planeta del usuario por ID
        return GalaxyService.getInstance().getUserPlanet(userId);
    }

    // Método para obtener expertise completo (base + bonos de gemas)
    public CommanderExpertise getExpertise() { // Retorna expertise con bonos aplicados
        CommanderExpertise expertise = isCommon() ? commonExpertise : getStats().getExpertise(); // Base

        // Obtiene expertise de gemas para cada tipo
        ExpertiseType ballisticExpertise = getStoneBallisticExpertise();
        ExpertiseType directionalExpertise = getStoneDirectionalExpertise();
        ExpertiseType missileExpertise = getStoneMissileExpertise();
        ExpertiseType carrierExpertise = getStoneShipBasedExpertise();
        ExpertiseType defendExpertise = getStoneDefendExpertise();

        ExpertiseType frigateExpertise = getStoneFrigateExpertise();
        ExpertiseType cruiserExpertise = getStoneCruiserExpertise();
        ExpertiseType battleShipExpertise = getStoneBattleshipExpertise();

        // Aplica bonos si son mejores que la base
        if(ballisticExpertise.isBetterThan(expertise.getBallistic())) expertise.setBallistic(ballisticExpertise);
        if(directionalExpertise.isBetterThan(expertise.getDirectional())) expertise.setDirectional(directionalExpertise);
        if(missileExpertise.isBetterThan(expertise.getMissile())) expertise.setMissile(missileExpertise);
        if(carrierExpertise.isBetterThan(expertise.getCarrier())) expertise.setCarrier(carrierExpertise);
        if(defendExpertise.isBetterThan(expertise.getDefend())) expertise.setDefend(defendExpertise);

        if(frigateExpertise.isBetterThan(expertise.getFrigate())) expertise.setFrigate(frigateExpertise);
        if(cruiserExpertise.isBetterThan(expertise.getCruiser())) expertise.setCruiser(cruiserExpertise);
        if(battleShipExpertise.isBetterThan(expertise.getBattleShip())) expertise.setBattleShip(battleShipExpertise);

        return expertise; // Retorna expertise con bonos aplicados
    }

    // Método para obtener lista de gemas (asegura 12 posiciones)
    public List<Integer> getGems() { // Retorna lista de gemas con 12 posiciones
        if (gems == null || gems.size() != 12) // Si no está inicializada o tamaño incorrecto
            for (int i = 0; i < 12; i++) // Inicializa con -1 (sin gema)
                gems.add(-1);
        return gems; // Retorna la lista
    }

    // Método para verificar si tiene gemas equipadas
    public boolean hasGems() { // Retorna true si tiene al menos una gema equipada
        for(int gem : getGems()) // Itera sobre gemas
            if(gem != -1) // Si encuentra una gema (no -1)
                return true; // Retorna true
        return false; // Sino, retorna false
    }

    // Método para obtener estado del comandante
    public int getState() { // Retorna código de estado (0-4)
        if(BattleService.getInstance().getCurrent(this) != null) return 4; // En batalla actual
        if(injuredMatch != null && BattleService.getInstance().getBattle(injuredMatch) != null) return 4; // En batalla herida
        if(isDead()) return 2; // Muerto
        if(untilRest != null && untilRest.before(new Date())) return 1; // Herido (descansando)
        return 0; // Disponible
    }

    // Método para verificar si puede pilotar
    public boolean canPilot() { // Retorna true si no está muerto y no en batalla
        return !isDead() && getState() != 4;
    }

    // Método para verificar si tiene chips equipados
    public boolean hasChips() { // Retorna true si la lista de chips no está vacía
        return !getChips().isEmpty();
    }

    // Método para obtener atributos base
    public CommanderAttributes getBaseAttributes() { // Retorna atributos base del servicio
        return CommanderService.getInstance().getBaseAttributes(this);
    }

    // Método para obtener datos de estadísticas
    public CommanderStatsData getStats() { // Retorna datos de stats del servicio
        return CommanderService.getInstance().getStats(this);
    }

}
