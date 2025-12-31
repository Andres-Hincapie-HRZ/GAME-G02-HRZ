// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad GameBoost
import com.go2super.database.entity.GameBoost; // Entidad de boost/mejora temporal

// Importación de enum BonusType
import com.go2super.obj.type.BonusType; // Tipos de bonos

// Importación de gestor de recursos
import com.go2super.resources.ResourceManager; // Gestor de recursos del juego

// Importación de datos de nivel
import com.go2super.resources.data.LevelData; // Datos de nivel

// Importación de utilidad DateUtil
import com.go2super.socket.util.DateUtil; // Utilidades para manejo de fechas

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.Date; // Clase para fechas
import java.util.List; // Interfaz de lista
import java.util.stream.Collectors; // Operaciones de stream

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa las estadísticas de un usuario
public class UserStats {

    private int level; // Nivel del usuario
    private int exp; // Experiencia acumulada

    private int restrictedUsedEntries; // Entradas restringidas usadas

    private int raidAttemptsEntries; // Entradas de intentos de incursión
    private int raidInterceptEntries; // Entradas de intercepción de incursión

    private int instance; // Instancia
    private int trial; // Prueba/trial

    private int sp; // Puntos de habilidad
    private int kills; // Asesinatos/derribos

    private Date nextInvitation; // Próxima invitación disponible
    private boolean collectedPoints; // Si recolectó puntos

    private List<UserBoost> buffs = new ArrayList<>(); // Lista de boosts activos

    // Método para agregar experiencia (con subida de nivel automática)
    public void addExp(int exp) {
        int maxExp = ResourceManager.getLevels().getMaxLevelExp(getLevel()); // Obtiene EXP máximo para nivel actual
        if(maxExp == 0) return; // Si no hay límite, sale

        if(this.exp + exp > maxExp) { // Si excede el máximo
            int leftover = (this.exp + exp) - maxExp; // Calcula excedente
            this.level++; // Sube de nivel
            this.exp = 0; // Resetea EXP
            addExp(leftover); // Agrega excedente recursivamente
            return; // Sale
        }

        this.exp += exp; // Sino, agrega EXP normal
    }

    // Método para obtener SP máximo (20 + nivel)
    public int getMaxSp() {
        return 20 + level; // Fórmula: base 20 + nivel
    }

    // Método para verificar si tiene tregua activa
    public boolean hasTruce() {
        List<UserBoost> buffs = getUserBonus(BonusType.PLANET_PROTECTION); // Obtiene boosts de protección planetaria
        for(UserBoost boost : buffs) // Itera sobre boosts
            if(boost.getUntil() != null && boost.getUntil().after(new Date())) // Si boost activo y no expirado
                return true; // Retorna true
        return false; // Retorna false
    }

    // Método para obtener boosts de un tipo específico
    public List<UserBoost> getUserBonus(BonusType bonusType) {
        return getBuffs().stream() // Stream de buffs
                .filter(userBoost -> userBoost.boost().getBonuses().contains(bonusType)) // Filtra por tipo de bono
                .collect(Collectors.toList()); // Recolecta en lista
    }

    // Método para verificar si tiene un bono específico
    public boolean hasBonus(BonusType bonusType) {
        return getAllBonuses().contains(bonusType); // Verifica en lista de todos los bonos
    }

    // Método para obtener todos los bonos activos
    public List<BonusType> getAllBonuses() {
        List<BonusType> bonusList = new ArrayList<>(); // Lista resultado
        for(UserBoost userBoost : getBuffs()) // Itera sobre boosts
            for(BonusType bonusType : userBoost.boost().getBonuses()) // Itera sobre bonos del boost
                bonusList.add(bonusType); // Agrega a lista
        return bonusList; // Retorna lista completa
    }

    // Método para remover boosts de un tipo específico
    public void removeBoost(BonusType bonusType) {
        List<UserBoost> boosts = getUserBonus(bonusType); // Obtiene boosts del tipo
        if(boosts.isEmpty()) return; // Si no hay, sale
        buffs.removeAll(boosts); // Remueve todos los boosts del tipo
    }

    // Método para remover un boost específico
    public void removeBoost(UserBoost userBoost) {
        buffs.remove(userBoost); // Remueve el boost específico
    }

    // Método para agregar boost
    public boolean addBoost(GameBoost gameBoost) {
        addBonusTime(gameBoost, gameBoost.getSeconds()); // Agrega tiempo del boost
        return true; // Retorna true
    }

    // Método para agregar tiempo a un boost
    public void addBonusTime(GameBoost gameBoost, int seconds) {
        if(buffs == null) // Si lista es null
            buffs = new ArrayList<>(); // Inicializa

        UserBoost oldBoost = getUserBoost(gameBoost); // Busca boost existente

        if(oldBoost == null) { // Si no existe
            buffs.add(new UserBoost(gameBoost.getId().toString(), DateUtil.now(seconds))); // Agrega nuevo boost
            return; // Sale
        }

        oldBoost.addSeconds(seconds); // Sino, agrega segundos al existente
    }

    // Método para obtener boost específico por GameBoost
    public UserBoost getUserBoost(GameBoost gameBoost) {
        if(buffs == null) // Si lista es null
            buffs = new ArrayList<>(); // Inicializa

        for(UserBoost boost : buffs) // Itera sobre boosts
            if(boost.getGameBoostId().equals(gameBoost.getId().toString())) // Si coincide ID
                return boost; // Retorna el boost

        return null; // Retorna null si no encuentra
    }

    // Método para establecer lista de buffs
    public void setBuffs(List<UserBoost> buffs) {
        this.buffs = buffs; // Asigna la lista
    }

    // Método para obtener lista de buffs (inicializa si null)
    public List<UserBoost> getBuffs() {
        if(buffs == null) // Si es null
            this.buffs = new ArrayList<>(); // Inicializa nueva lista
        return buffs; // Retorna la lista
    }

    // Método para obtener datos del nivel actual
    public LevelData getLevelData() {
        return ResourceManager.getLevels().getData(level); // Obtiene datos del nivel
    }

}
