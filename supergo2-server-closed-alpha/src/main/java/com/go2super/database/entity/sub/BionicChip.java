// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de objetos de juego y recursos
import com.go2super.obj.game.CmosInfo; // Información CMOS del chip
import com.go2super.resources.ResourceManager; // Gestor de recursos
import com.go2super.resources.data.PropData; // Datos de propiedad
import com.go2super.resources.data.props.PropChipData; // Datos específicos del chip

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa un chip biónico
public class BionicChip {

    private int chipId; // ID del chip
    private int chipExperience; // Experiencia del chip
    private int holeId; // ID del agujero donde está equipado

    private boolean bound; // Si está ligado/vinculado

    // Método para agregar experiencia de otro chip
    public boolean addExperience(BionicChip other) {
        if(other.getChipData().getAddExperience() == null) other.getChipData().setAddExperience(0); // Inicializa si null
        return addExperience(other.getChipExperience() + other.getChipData().getAddExperience()); // Agrega experiencia calculada
    }

    // Método para agregar experiencia específica
    public boolean addExperience(int chipExperience) {
        PropChipData chipData = getChipData(); // Obtiene datos del chip
        if(chipData == null || chipData.getNeedExperience() == null) return false; // Si no hay datos o experiencia necesaria, retorna false

        while(chipExperience > 0 && chipData.getNeedExperience() != null) { // Mientras haya experiencia para agregar y necesidad
            this.chipExperience += chipExperience; // Agrega experiencia
            if(this.chipExperience >= chipData.getNeedExperience()) { // Si alcanza la experiencia necesaria
                chipExperience = this.chipExperience - chipData.getNeedExperience(); // Calcula experiencia sobrante
                this.chipId++; // Incrementa ID del chip (subida de nivel)
                this.chipExperience = 0; // Resetea experiencia
                chipData = getChipData(); // Actualiza datos del chip
            } else {
                break; // Sale del bucle si no alcanza
            }
        }
        return true; // Retorna true si se agregó experiencia
    }

    // Método para obtener datos de propiedad del chip
    public PropData getPropData() {
        return ResourceManager.getProps().getChipData(chipId); // Obtiene datos de propiedad por ID
    }

    // Método para obtener datos específicos del chip
    public PropChipData getChipData() {
        return getPropData().getChipData(); // Obtiene datos del chip de la propiedad
    }

    // Método para obtener información CMOS del chip
    public CmosInfo getCmosInfo() {
        return new CmosInfo(chipExperience, (short) chipId, (short) (bound ? 1 : 0)); // Crea info CMOS con experiencia, ID y estado de ligado
    }

}
