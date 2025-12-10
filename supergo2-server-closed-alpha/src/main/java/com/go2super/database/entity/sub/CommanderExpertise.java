// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de enum para tipos de expertise
import com.go2super.database.entity.type.ExpertiseType; // Enum que define niveles de expertise (S, A, B, C, D)

// Importación de servicio de comandantes
import com.go2super.service.CommanderService; // Servicio para lógica de comandantes

// Importación de Google Guava para operaciones con caracteres
import com.google.common.primitives.Chars; // Utilidades para trabajar con arrays de caracteres

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones estándar de Java
import java.io.Serializable; // Para serialización
import java.util.Collections; // Utilidades para colecciones
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa la expertise de un comandante en diferentes tipos de combate
public class CommanderExpertise implements Serializable {

    // Campos de expertise con valores por defecto ExpertiseType.B (básico)
    private ExpertiseType ballistic = ExpertiseType.B; // Expertise en armas balísticas
    private ExpertiseType directional = ExpertiseType.B; // Expertise en armas direccionales
    private ExpertiseType missile = ExpertiseType.B; // Expertise en misiles
    private ExpertiseType carrier = ExpertiseType.B; // Expertise en naves portaaviones
    private ExpertiseType defend = ExpertiseType.B; // Expertise en defensa/edificios

    private ExpertiseType frigate = ExpertiseType.B; // Expertise en fragatas
    private ExpertiseType cruiser = ExpertiseType.B; // Expertise en cruceros
    private ExpertiseType battleShip = ExpertiseType.B; // Expertise en acorazados

    // Método para obtener representación en cadena de la expertise completa
    public String getJZ() {
        return ballistic.name() + directional.name() + missile.name() + carrier.name() + defend.name() + frigate.name() + cruiser.name() + battleShip.name(); // Concatena nombres de enums
    }

    // Método para obtener modificador de daño de armas basado en subtype
    public double getWeaponModifier(String subType) {
        ExpertiseType selected = ExpertiseType.B; // Valor por defecto

        // Selecciona el tipo de expertise basado en el subtype
        switch (subType) {
            case "ballistic":
                selected = this.ballistic; // Expertise balística
                break;
            case "directional":
                selected = this.directional; // Expertise direccional
                break;
            case "missile":
                selected = this.missile; // Expertise de misiles
                break;
            case "shipBased":
                selected = this.carrier; // Expertise de portaaviones
                break;
            case "building":
                selected = this.defend; // Expertise defensiva
                break;
        }

        // Retorna modificador basado en nivel de expertise
        switch (selected) {
            case S: return 0.3d; // S: +30% daño
            case A: return 0.1d; // A: +10% daño
            case C: return -0.1d; // C: -10% daño
            case D: return -0.3d; // D: -30% daño
        }

        return 0.0d; // B: sin modificador
    }

    // Método para obtener modificador de daño de naves basado en subtype
    public double getShipDamageModifier(String subType) {
        ExpertiseType selected = ExpertiseType.B; // Valor por defecto

        // Selecciona expertise basado en tipo de nave
        switch (subType) {
            case "frigate":
                selected = this.frigate; // Expertise en fragatas
                break;
            case "cruiser":
                selected = this.cruiser; // Expertise en cruceros
                break;
            case "battleship":
                selected = this.battleShip; // Expertise en acorazados
                break;
        }

        // Retorna modificador de daño
        switch (selected) {
            case S: return 0.1d; // S: +10% daño
            case A: return 0.05d; // A: +5% daño
            case C: return -0.05d; // C: -5% daño
            case D: return -0.1d; // D: -10% daño
        }

        return 0.0d; // B: sin modificador
    }

    // Método para obtener modificador de reducción de daño recibido por naves
    public double getShipDamageReductionModifier(String subType) {
        ExpertiseType selected = ExpertiseType.B; // Valor por defecto

        // Selecciona expertise basado en tipo de nave
        switch (subType) {
            case "frigate":
                selected = this.frigate; // Expertise en fragatas
                break;
            case "cruiser":
                selected = this.cruiser; // Expertise en cruceros
                break;
            case "battleship":
                selected = this.battleShip; // Expertise en acorazados
                break;
        }

        // Retorna modificador de reducción de daño
        switch (selected) {
            case S:
            case A:
                return -0.1d; // S/A: -10% daño recibido
            case C:
            case D:
                return 0.1d; // C/D: +10% daño recibido
        }

        return 0.0d; // B: sin modificador
    }

    // Método estático para crear expertise común aleatoria
    public static CommanderExpertise common() {
        CommanderExpertise expertise = new CommanderExpertise(); // Nueva instancia
        // Obtiene patrón de expertise común del servicio y lo convierte a lista de caracteres
        List<Character> chars = Chars.asList(CommanderService.getInstance().getCommonExpertisePattern().toCharArray());

        Collections.shuffle(chars); // Mezcla aleatoriamente los caracteres

        // Asigna expertise aleatoria a cada tipo
        expertise.setBallistic(ExpertiseType.getLiteral(chars.get(0))); // Balística
        expertise.setDirectional(ExpertiseType.getLiteral(chars.get(1))); // Direccional
        expertise.setMissile(ExpertiseType.getLiteral(chars.get(2))); // Misiles
        expertise.setCarrier(ExpertiseType.getLiteral(chars.get(3))); // Portaaviones

        expertise.setDefend(ExpertiseType.getLiteral(chars.get(4))); // Defensa
        expertise.setFrigate(ExpertiseType.getLiteral(chars.get(5))); // Fragatas
        expertise.setCruiser(ExpertiseType.getLiteral(chars.get(6))); // Cruceros
        expertise.setBattleShip(ExpertiseType.getLiteral(chars.get(7))); // Acorazados

        return expertise; // Retorna expertise generada
    }

}
