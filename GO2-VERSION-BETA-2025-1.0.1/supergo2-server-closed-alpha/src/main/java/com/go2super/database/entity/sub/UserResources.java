// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de logger del bot
import com.go2super.logger.BotLogger; // Logger para registrar información

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Builder // Genera patrón builder
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa los recursos de un usuario
public class UserResources {

    public static final int MAX_RESOURCES = 900000000; // Límite máximo de recursos (900M)

    private long gold; // Cantidad de oro
    private long he3; // Cantidad de Helio-3
    private long metal; // Cantidad de metal

    private long vouchers; // Cantidad de vales
    private long mallPoints; // Puntos de tienda
    private long coupons; // Cupones
    private long corsairs; // Corsarios

    private long honor; // Honor
    private long badge; // Insignias
    private long championPoints; // Puntos de campeón

    private int freeSpins; // Giros gratuitos
    private Date lastSpin; // Último giro

    // Método para refrescar y validar límites de recursos
    public void refresh() {
        if(gold < 0 || gold > MAX_RESOURCES) { // Si oro fuera de límites
            BotLogger.info("User gold is: " + gold); // Log del valor actual
            gold = gold < 0 ? 0 : MAX_RESOURCES; // Ajusta a 0 o máximo
        }

        if(he3 < 0 || he3 > MAX_RESOURCES) // Si He3 fuera de límites
            he3 = he3 < 0 ? 0 : MAX_RESOURCES; // Ajusta

        if(metal < 0 || metal > MAX_RESOURCES) // Si metal fuera de límites
            metal = metal < 0 ? 0 : MAX_RESOURCES; // Ajusta

        if(mallPoints < 0 || mallPoints > MAX_RESOURCES) // Si puntos de tienda fuera de límites
            mallPoints = mallPoints < 0 ? 0 : MAX_RESOURCES; // Ajusta

        if(vouchers < 0 || vouchers > MAX_RESOURCES) // Si vales fuera de límites
            vouchers = vouchers < 0 ? 0 : MAX_RESOURCES; // Ajusta
    }

    // Método para agregar oro con límite
    public void addGold(long gold) {
        if(this.gold + gold > MAX_RESOURCES) { // Si excede máximo
            this.gold = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.gold += gold; // Sino, agrega
    }

    // Método para agregar He3 con límite
    public void addHe3(long he3) {
        if(this.he3 + he3 > MAX_RESOURCES) { // Si excede máximo
            this.he3 = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.he3 += he3; // Sino, agrega
    }

    // Método para agregar metal con límite
    public void addMetal(long metal) {
        if(this.metal + metal > MAX_RESOURCES) { // Si excede máximo
            this.metal = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.metal += metal; // Sino, agrega
    }

    // Método para agregar puntos de tienda con límite
    public void addMallPoints(int mallPoints) {
        if(this.mallPoints + mallPoints > MAX_RESOURCES) { // Si excede máximo
            this.mallPoints = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.mallPoints += mallPoints; // Sino, agrega
    }

    // Método para agregar vales con límite
    public void addVouchers(int vouchers) {
        if(this.vouchers + vouchers > MAX_RESOURCES) { // Si excede máximo
            this.vouchers = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.vouchers += vouchers; // Sino, agrega
    }

    // Método para agregar corsarios con límite
    public void addCorsairs(int corsairs) {
        if(this.corsairs + corsairs > MAX_RESOURCES) { // Si excede máximo
            this.corsairs = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.corsairs += corsairs; // Sino, agrega
    }

    // Método para agregar puntos de campeón con límite
    public void addChampionPoints(int championPoints) {
        if(this.championPoints + championPoints > MAX_RESOURCES) { // Si excede máximo
            this.championPoints = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.championPoints += championPoints; // Sino, agrega
    }

    // Método para agregar insignias con límite
    public void addBadges(int badges) {
        if(this.badge + badges > MAX_RESOURCES) { // Si excede máximo
            this.badge = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.badge += badges; // Sino, agrega
    }

    // Método para agregar honor con límite
    public void addHonor(int honor) {
        if(this.honor + honor > MAX_RESOURCES) { // Si excede máximo
            this.honor = MAX_RESOURCES; // Establece al máximo
            return; // Sale
        }

        this.honor += honor; // Sino, agrega
    }

    // Método para remover un giro gratuito
    public void removeSpin() {
        if(freeSpins > 0) // Si tiene giros disponibles
            this.freeSpins -= 1; // Reduce en 1
    }

}
