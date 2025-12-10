package com.go2super.resources;

import com.go2super.obj.type.InstanceType;
import com.go2super.obj.utility.GameInstance;
import com.go2super.resources.data.LayoutData;
import com.go2super.resources.json.*;
import com.go2super.resources.serialization.LevelsJsonDeserializer;
import com.go2super.resources.serialization.PropsJsonDeserializer;
import com.go2super.service.PacketService;
import com.google.common.base.Charsets;
import com.google.common.io.CharStreams;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import lombok.SneakyThrows;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.*;

@Component
public class ResourceManager {

    private static ResourceManager instance;

    private String otpHtml;

    private PropsJson propsJson;
    private LevelsJson levelsJson;
    private BuildsJson buildsJson;
    private TasksJson tasksJson;
    private ScienceJson scienceJson;
    private ChipsJson chipsJson;
    private FlagshipsJson flagshipsJson;

    private FarmLandsJson farmLandsJson;
    private FieldResourcesJson fieldResourcesJson;
    private FortificationJson fortificationJson;
    private RBPFortificationJson rbpFortificationJson;

    private ShipPartJson shipPartJson;
    private ShipBodyJson shipBodyJson;

    private GalaxyMapJson galaxyMapJson;
    private CommandersJson commandersJson;

    private CorpsPirateJson corpsPirateJson;
    private CorpsShopJson corpsShopJson;
    private CorpsLevelJson corpsLevelJson;
    private InstancesJson instancesJson;
    private RestrictedJson restrictedJson;
    private TrialsJson trialsJson;
    private ConstellationsJson constellationsJson;
    private ShipModelsJson shipModelsJson;
    private HumaroidsJson humaroidsJson;

    private RBPSSJson rbpssJson;
    private RBPJson rbpJson;

    private LotteryJson lotteryJson;
    private RewardsJson rewardsJson;
    private PiratesJson piratesJson;

    private List<String> compactedDictionary;

    private Set<GameInstance> instances;
    private Set<LayoutData> layouts;

    public ResourceManager() {

        instance = this;

        this.otpHtml = getString("email/otp.html");

        this.propsJson = getJson("props.tmp.json", PropsJson.class, new PropsJsonDeserializer());
        this.levelsJson = getJson("levels.json", LevelsJson.class, new LevelsJsonDeserializer());
        this.galaxyMapJson = getJson("galaxyMap.json", GalaxyMapJson.class);
        this.buildsJson = getJson("builds.tmp.json", BuildsJson.class);
        this.commandersJson = getJson("commanders.tmp.json", CommandersJson.class);
        this.tasksJson = getJson("tasks.json", TasksJson.class);
        this.scienceJson = getJson("science.json", ScienceJson.class);
        this.chipsJson = getJson("chips.json", ChipsJson.class);
        this.flagshipsJson = getJson("flagships.json", FlagshipsJson.class);

        this.rewardsJson = getJson("rewards.json", RewardsJson.class);
        this.piratesJson = getJson(PacketService.getInstance().isCustomInstances() ? "custom.pirates.json" : "pirates.json", PiratesJson.class);

        this.farmLandsJson = getJson("farmLands.json", FarmLandsJson.class);
        this.fieldResourcesJson = getJson("fieldResources.json", FieldResourcesJson.class);
        this.fortificationJson = getJson("fortification.json", FortificationJson.class);
        this.rbpFortificationJson = getJson("rbpFortification.json", RBPFortificationJson.class);

        this.rbpssJson = getJson("rbpSS.json", RBPSSJson.class);
        this.rbpJson = getJson("rbp.json", RBPJson.class);

        this.shipPartJson = getJson("shipPart.json", ShipPartJson.class);
        this.shipBodyJson = getJson("shipBody.json", ShipBodyJson.class);

        this.corpsPirateJson = getJson("corpsPirate.json", CorpsPirateJson.class);
        this.corpsShopJson = getJson("corpsShop.json", CorpsShopJson.class);
        this.corpsLevelJson = getJson("corpsLevel.json", CorpsLevelJson.class);
        this.instancesJson = getJson(PacketService.getInstance().isCustomInstances() ? "custom.instances.json" : "instances.json", InstancesJson.class);
        this.restrictedJson = getJson(PacketService.getInstance().isCustomInstances() ? "custom.restricted.json" : "restricted.json", RestrictedJson.class);

        this.trialsJson = getJson("trials.json", TrialsJson.class);
        this.humaroidsJson = getJson("humaroids.json", HumaroidsJson.class);
        this.constellationsJson = getJson(PacketService.getInstance().isCustomInstances() ? "custom.constellations.json" : "constellations.json", ConstellationsJson.class);
        this.shipModelsJson = getJson("shipModels.json", ShipModelsJson.class);
        this.lotteryJson = getJson("lottery.json", LotteryJson.class);

        this.compactedDictionary = new ArrayList<>();

        this.instances = new HashSet<>();
        this.layouts = new HashSet<>();

        /*for(PropData propData : propsJson.getCommanders()) {
            PropCommanderData commanderData = propData.getCommanderData();
            if(commanderData.getCommander().getType().equals("legendary")) {
                System.out.println("\"" + propData.getName() + "\",");
            }
        }*/

        Reader dictionaryReader = getReader("others/dictionary.txt");
        Scanner scanner = new Scanner(dictionaryReader);

        while (scanner.hasNextLine()) {

            String word = scanner.nextLine();
            if (word.length() < 5 || !StringUtils.isAlphanumeric(word)) continue;

            compactedDictionary.add(word);

        }

        layouts.addAll(instancesJson.getLayout().stream().toList());
        layouts.addAll(restrictedJson.getLayout().stream().toList());
        layouts.addAll(trialsJson.getLayout().stream().toList());
        layouts.addAll(humaroidsJson.getLayout().stream().toList());
        layouts.addAll(constellationsJson.getLayout().stream().toList());
        layouts.addAll(piratesJson.getLayout().stream().toList());

        instances.addAll(instancesJson.getInstances().stream().map(data -> new GameInstance(data, InstanceType.INSTANCE)).toList());
        instances.addAll(restrictedJson.getInstances().stream().map(data -> new GameInstance(data, InstanceType.RESTRICTED)).toList());
        instances.addAll(trialsJson.getInstances().stream().map(data -> new GameInstance(data, InstanceType.TRIALS)).toList());
        instances.addAll(constellationsJson.getInstances().stream().map(data -> new GameInstance(data, InstanceType.CONSTELLATION)).toList());

    }

    @SneakyThrows
    private <T> T getJson(String jsonFile, Class<T> clazz, JsonDeserializer<T> deserializer) {
        return new GsonBuilder().registerTypeAdapter(clazz, deserializer).create().fromJson(getReader(jsonFile), clazz);
    }

    @SneakyThrows
    private <T> T getJson(String jsonFile, Class<T> clazz) {
        return new GsonBuilder().create().fromJson(getReader(jsonFile), clazz);
    }

    @SneakyThrows
    private Reader getReader(String file) {
        return new InputStreamReader(getInputStream(file), "UTF-8");
    }

    @SneakyThrows
    private InputStream getInputStream(String file) {
        return new ClassPathResource("data/" + file).getInputStream();
    }

    @SneakyThrows
    private String getString(String file) {
        return CharStreams.toString(new InputStreamReader(new ClassPathResource(file).getInputStream(), Charsets.UTF_8));
    }

    public static Optional<LayoutData> fetchLayout(String layout) {
        return instance.layouts.stream().filter(layoutData -> layoutData.getName().equals(layout)).findFirst();
    }

    public static String getOtpHtml() {
        return instance.otpHtml;
    }

    public static PropsJson getProps() {
        return instance.propsJson;
    }

    public static BuildsJson getBuilds() {
        return instance.buildsJson;
    }

    public static LotteryJson getLottery() {
        return instance.lotteryJson;
    }

    public static RewardsJson getRewards() {
        return instance.rewardsJson;
    }

    public static TasksJson getTasks() {
        return instance.tasksJson;
    }

    public static ScienceJson getScience() {
        return instance.scienceJson;
    }

    public static FarmLandsJson getFarmLands() {
        return instance.farmLandsJson;
    }

    public static FieldResourcesJson getFieldResources() {
        return instance.fieldResourcesJson;
    }

    public static FortificationJson getFortification() {
        return instance.fortificationJson;
    }

    public static RBPFortificationJson getRBPFortification() {
        return instance.rbpFortificationJson;
    }

    public static CorpsPirateJson getCorpsPirate() {
        return instance.corpsPirateJson;
    }

    public static CorpsShopJson getCorpsShopJson() {
        return instance.corpsShopJson;
    }

    public static CorpsLevelJson getCorpsLevelJson() {
        return instance.corpsLevelJson;
    }

    public static LevelsJson getLevels() {
        return instance.levelsJson;
    }

    public static ChipsJson getChips() {
        return instance.chipsJson;
    }

    public static FlagshipsJson getFlagships() {
        return instance.flagshipsJson;
    }

    public static ShipPartJson getShipParts() {
        return instance.shipPartJson;
    }

    public static ShipBodyJson getShipBodies() {
        return instance.shipBodyJson;
    }

    public static ShipModelsJson getShipModels() {
        return instance.shipModelsJson;
    }

    public static CommandersJson getCommanders() {
        return instance.commandersJson;
    }

    public static InstancesJson getInstances() {
        return instance.instancesJson;
    }

    public static RestrictedJson getRestricted() {
        return instance.restrictedJson;
    }

    public static HumaroidsJson getHumaroids() {
        return instance.humaroidsJson;
    }

    public static TrialsJson getTrials() {
        return instance.trialsJson;
    }

    public static RBPSSJson getRBPss() {
        return instance.rbpssJson;
    }

    public static RBPJson getRBP() {
        return instance.rbpJson;
    }

    public static PiratesJson getPirates() {
        return instance.piratesJson;
    }

    public static GalaxyMapJson getGalaxyMaps() {
        return instance.galaxyMapJson;
    }

    public static GameInstance getGameInstance(int id) {
        return instance.instances.stream().filter(instance -> instance.getData().getId() == id).findFirst().orElse(null);
    }

    public static List<String> getCompactedWords() {
        return instance.compactedDictionary;
    }

    public static ResourceManager getInstance() {
        return instance;
    }

}