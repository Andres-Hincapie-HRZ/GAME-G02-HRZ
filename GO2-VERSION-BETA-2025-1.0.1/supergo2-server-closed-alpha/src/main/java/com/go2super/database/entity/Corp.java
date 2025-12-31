package com.go2super.database.entity;

import com.go2super.database.entity.sub.*;
import com.go2super.obj.game.ConsortiaJobName;
import com.go2super.resources.data.meta.FortificationEffectMeta;
import com.go2super.service.CorpService;
import com.go2super.service.GalaxyService;
import com.go2super.socket.util.DateUtil;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Document(collection = "game_corps")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Corp {

    @Id
    private ObjectId id;

    @Column(unique = true) private int corpId;

    private int contribution;

    private int maxMembers;
    private int rbpLimit;

    private double resourceBonus;
    private double mergeBonus;

    private int contributionMerge;
    private int contributionMall;

    private int wealth;
    private int icon;

    @Column(unique = true) private String name;
    @Column(unique = true) private String blocId;

    private String acronym;
    private String philosophy;
    private String bulletin;

    private int planets;
    private int territories;

    private int level;
    private int mallLevel;
    private int mergingLevel;
    private int warehouseLevel;

    private int fees;

    private int piratesLevel;
    private Date lastPirates;

    private ConsortiaJobName consortiaJobName;

    // Campos complejos mapeados con nombres personalizados en DB
    @Field(name = "corp_history") private CorpHistory history; // Historial de la corporación
    @Field(name = "corp_members") private CorpMembers members; // Miembros de la corporación
    @Field(name = "corp_upgrade") private CorpUpgrade corpUpgrade; // Mejoras de la corporación
    @Field(name = "corp_territories") private CorpTerritories corpTerritories; // Territorios de la corporación

    // Método para calcular bono total de planetas de recursos (RBP)
    public double getRBPBonus() { // Retorna bono total de estaciones espaciales en planetas RBP
        double total = 0.0d; // Inicializa total en 0
        for(ResourcePlanet rbp : getResourcePlanets()) { // Itera sobre planetas de recursos
            RBPBuilding spaceStation = rbp.getSpaceStation(); // Obtiene estación espacial
            if(spaceStation == null) continue; // Salta si no hay estación
            Optional<FortificationEffectMeta> effectMeta = spaceStation.getLevelData().getEffect("affect"); // Obtiene efecto
            if(effectMeta.isEmpty()) continue; // Salta si no hay efecto
            total += effectMeta.get().getValue(); // Suma el valor del efecto
        }
        return total; // Retorna bono total
    }

    // Método para obtener lista de planetas de recursos de la corporación
    public List<ResourcePlanet> getResourcePlanets() { // Retorna planetas de recursos por ID de corp
        return GalaxyService.getInstance().getPlanetCache().findResourcePlanets(corpId);
    }

    // Método para obtener número de piratas disponibles
    public int getPiratesNum() { // Retorna 1 si piratas disponibles hoy, 0 si no
        if(lastPirates == null || !DateUtil.sameDay(new Date(), lastPirates)) return 0; // Verifica si es el mismo día
        return 1; // Retorna 1 si es el mismo día
    }

    // Método para guardar la corporación en cache
    public void save() { // Guarda la corporación en el cache del servicio
        CorpService.getInstance().getCorpCache().save(this);
    }

}
