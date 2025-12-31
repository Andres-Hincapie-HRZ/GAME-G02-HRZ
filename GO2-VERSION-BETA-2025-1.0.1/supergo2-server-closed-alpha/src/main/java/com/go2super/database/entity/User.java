// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity;

// Importaciones de subentidades relacionadas con el usuario
import com.go2super.database.entity.sub.*;

// Importaciones de objetos de modelo
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.obj.type.BonusType;
import com.go2super.obj.utility.WideString;

// Importaciones de paquetes personalizados
import com.go2super.packet.custom.CustomWarnPacket;
import com.go2super.packet.props.ResponseTimeQueuePacket;
import com.go2super.resources.ResourceManager;
import com.go2super.resources.data.FarmLandData;
import com.go2super.resources.json.RewardsJson;

// Importaciones de servicios
import com.go2super.service.*;

// Importaciones de utilidades
import com.go2super.socket.util.DateUtil;

// Importaciones de Lombok
import lombok.*;

// Importaciones de Apache Commons
import org.apache.commons.lang3.tuple.Pair;

// Importaciones de MongoDB
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

// Importaciones de JPA
import javax.persistence.Column;
import javax.persistence.Id;

// Importaciones estándar de Java
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

// Anotación que indica que esta clase es un documento MongoDB en la colección "game_users"
@Document(collection = "game_users")
// Anotaciones Lombok para generar código boilerplate
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa un usuario en el juego
public class User {

    // Campo ID único de MongoDB
    @Id // Anotación JPA para ID
    private ObjectId id; // ID único del usuario

    private String accountId; // ID de la cuenta asociada

    // Campos únicos para GUID, userId y username
    @Column(unique = true) private int guid; // GUID único del usuario
    @Column(unique = true) private long userId; // ID único del usuario
    @Column(unique = true) private String username; // Nombre de usuario único

    // Campo para el tipo de terreno del planeta (comentarios sobre valores posibles)
    // 0 = Desert (Desierto)
    // 1 = Snow (Nieve)
    // 2 = Plains (Llanuras)
    private int ground; // Tipo de terreno del planeta
    private int icon = 1; // Ícono del usuario (por defecto 1)
    private int gMapId; // ID del mapa galáctico

    private int consortiaId; // ID de la corporación
    private int consortiaJob; // Trabajo en la corporación
    private int consortiaUnionLevel; // Nivel de unión en corporación

    private int gameServerId; // ID del servidor de juego
    private int card1; // Carta 1
    private int cardCredit; // Crédito de cartas
    private int card2; // Carta 2
    private int card3; // Carta 3
    private int cardUnion; // Unión de cartas
    private int chargeFlag; // Bandera de carga
    private int shipSpeedCredit; // Crédito de velocidad de naves
    private int lotteryStatus; // Estado de lotería

    // Campos obsoletos (deprecated)
    @Deprecated private int consortiaThrow; // Obsoleto
    @Deprecated private int consortiaUnion; // Obsoleto
    @Deprecated private int consortiaShop; // Obsoleto

    private int tollGate; // Puerta de peaje
    private short year; // Año
    private int month; // Mes
    private int day; // Día
    private int noviceGuide; // Guía para novatos
    private int warScore; // Puntaje de guerra

    private boolean notDisturb; // No molestar

    private Date lastRecruit; // Último reclutamiento
    private Date lastDayUpdate; // Última actualización diaria

    private double userMaxPpt; // Máximo PPT del usuario
    private boolean toSave; // Bandera para guardar

    // Campos complejos mapeados con nombres personalizados en DB
    @Field(name = "game_flag") private UserFlag flag; // Bandera del usuario
    @Field(name = "game_stats") private UserStats stats; // Estadísticas del usuario
    @Field(name = "game_ships") private UserShips ships; // Naves del usuario
    @Field(name = "game_user_techs") private UserTechs techs = UserTechs.builder()
            .techs(new ArrayList<>())
            .build(); // Tecnologías del usuario

    @Field(name = "game_tasks") private UserTasks tasks = UserTasks.builder()
            .currentMain(UserTask.builder().taskId(0).type(0).level(-1).build())
            .currentSide(new ArrayList<>())
            .completed(new ArrayList<>())
            .build(); // Tareas del usuario

    @Field(name = "game_territories") private UserTerritories territories = UserTerritories.builder()
            .territories(new ArrayList<>())
            .build(); // Territorios del usuario

    @Field(name = "game_bionic_chips") private UserChips chips = UserChips.builder()
            .chips(new ArrayList<>())
            .build(); // Chips biónicos del usuario

    @Field(name = "game_rewards") private UserRewards rewards = UserRewards.builder()
            .level(-1)
            .build(); // Recompensas del usuario

    @Field(name = "game_metrics") private UserMetrics metrics = UserMetrics.builder().build(); // Métricas del usuario
    @Field(name = "game_upgrades") private UserShipUpgrades shipUpgrades; // Mejoras de naves del usuario
    @Field(name = "game_resources") private UserResources resources; // Recursos del usuario
    @Field(name = "game_buildings") private UserBuildings buildings; // Edificios del usuario
    @Field(name = "game_resource_storage") private UserStorage storage; // Almacenamiento de recursos
    @Field(name = "game_user_emails") private UserEmailStorage userEmailStorage; // Almacenamiento de emails
    @Field(name = "game_user_inventory") private UserInventory inventory; // Inventario del usuario
    @Field(name = "game_corp_inventory") private CorpInventory corpInventory; // Inventario de corporación
    @Field(name = "game_user_friends") private List<Integer> friends; // Lista de amigos (GUIDs)
    @Field(name = "game_block_users") private List<Integer> blockUsers; // Lista de usuarios bloqueados

    // Método para actualizar el usuario (refresca edificios, recursos, estadísticas, emails y tareas)
    public void update() {
        getBuildings().refresh(); // Refresca edificios
        UserService.getInstance().updateResources(this); // Actualiza recursos
        UserService.getInstance().updateStats(this); // Actualiza estadísticas
        UserService.getInstance().updateShips(this); // Actualiza naves
        UserService.getInstance().updateEmails(this); // Actualiza emails
        TaskService.getInstance().updateTasks(this); // Actualiza tareas
    }

    // Método para marcar el usuario para guardar
    public void save() {
        toSave = true; // Establece bandera de guardado
    }

    // Método para obtener el usuario logueado en el juego
    public Optional<LoggedGameUser> getLoggedGameUser() {
        return LoginService.getInstance().getGame(this); // Obtiene usuario logueado
    }

    // Método para verificar si el usuario está online
    public boolean isOnline() {
        return getLoggedGameUser().isPresent(); // Verifica presencia del usuario logueado
    }

    // Método para agregar un amigo
    public void addFriend(int guid) {
        if(!getFriendsIds().contains(guid)) // Si no está en la lista
            getFriendsIds().add(guid); // Agrega el GUID
    }

    // Método para remover un amigo
    public void removeFriend(int guid) {
        if(getFriendsIds().contains(guid)) // Si está en la lista
            getFriendsIds().remove((Integer) guid); // Remueve el GUID
    }

    // Método para verificar si es amigo
    public boolean isFriend(int guid) {
        return getFriendsIds().contains(guid); // Verifica si el GUID está en amigos
    }

    // Método para obtener lista de amigos (inicializa si es null)
    public List<Integer> getFriendsIds() {
        if(friends == null) // Si la lista es null
            friends = new ArrayList<>(); // Inicializa nueva lista
        return friends; // Retorna la lista
    }

    // Método para encontrar amigos (retorna lista de objetos User)
    public List<User> findFriends() {
        List<User> friends = new ArrayList<>(); // Lista resultado
        for(int friendId : getFriendsIds()) { // Itera sobre GUIDs de amigos
            if(friendId == guid) // Salta si es el propio usuario
                continue;
            User friend = UserService.getInstance().getUserCache().findByGuid(friendId); // Busca usuario por GUID
            if(friend == null) // Si no se encuentra
                continue; // Salta
            friends.add(friend); // Agrega a la lista
        }
        return friends; // Retorna lista de amigos
    }

    // Método para obtener el nivel de vista de un solicitante (0-1 basado en amistad/corporación)
    public int getViewFlag(int requester) {
        if(requester == guid || isFriend(requester)) return 1; // Si es el mismo o amigo, retorna 1
        User user = UserService.getInstance().getUserCache().findByGuid(requester); // Busca solicitante
        if(user == null) return 0; // Si no existe, retorna 0
        Corp corp = user.getCorp(); // Obtiene corporación del solicitante
        Corp hereCorp = getCorp(); // Obtiene corporación propia
        if(corp == null || hereCorp == null) return 0; // Si alguna es null, retorna 0
        return corp.getCorpId() == hereCorp.getCorpId() ? 1 : 0; // Retorna 1 si misma corporación, 0 si no
    }

    // Método para obtener el ranking de poder de ataque
    public int getRanking() {
        return RankService.getInstance().getAttackPower(this); // Delega al servicio de rankings
    }

    // Método para obtener el nivel de la ciudad (nivel del centro cívico)
    public int getCityLevel() {
        return getBuildings().getBuildings("build:civicCenter").get(0).getLevelId(); // Obtiene nivel del edificio
    }

    // Método para obtener el nivel de la estación espacial
    public int getSpaceStationLevel() {
        return getBuildings().getBuildings("build:spaceStation").get(0).getLevelId(); // Obtiene nivel del edificio
    }

    // Método para obtener la liga actual (siempre retorna 0)
    public int getCurrentLeague() {
        return 0; // Valor fijo
    }

    // Método para obtener la instancia actual (siempre retorna 0)
    public int getCurrentInstance() {
        return 0; // Valor fijo
    }

    // Método para obtener la cara estelar (basado en permisos y bonos)
    public int getStarFace() {
        Optional<Account> optionalAccount = AccountService.getInstance().getAccountCache().findById(accountId); // Busca cuenta
        if(optionalAccount.isPresent()) { // Si existe
            Account account = optionalAccount.get();
            if(account.getUserRank().hasPermission("permission.i.g.c")) // Si tiene permiso especial
                return 20; // Retorna 20
        }
        List<BonusType> types = stats.getAllBonuses(); // Obtiene bonos
        if(types.contains(BonusType.PLANET_APPEARANCE)) { // Si tiene bono de apariencia planetaria
            if(types.contains(BonusType.LUXURIOUS_GOLD_RESOURCE_PRODUCTION)) // Bono de producción de oro lujoso
                return 10; // Retorna 10
            else if(types.contains(BonusType.METALLIC_METAL_RESOURCE_PRODUCTION)) // Bono de producción metálica
                return 11; // Retorna 11
            else if(types.contains(BonusType.GASEOUS_HE3_RESOURCE_PRODUCTION)) // Bono de producción de He3 gaseoso
                return 12; // Retorna 12
            else if(types.contains(BonusType.ORDINARY_PLANET)) // Planeta ordinario
                return 13; // Retorna 13
            else if(types.contains(BonusType.CHRISTMAS_RESOURCE_PRODUCTION)) // Producción navideña
                return 14; // Retorna 14
            else if(types.contains(BonusType.GF_RESOURCE_PRODUCTION)) // Producción GF
                return 15; // Retorna 15
            else if(types.contains(BonusType.HALLOWEEN_RESOURCE_PRODUCTION)) // Producción de Halloween
                return 16; // Retorna 16
        }
        return 9; // Valor por defecto
    }

    // Método para obtener el tipo estelar (basado en tierras agrícolas adyacentes)
    public int getStarType() {
        Optional<Account> optionalAccount = AccountService.getInstance().getAccountCache().findById(accountId); // Busca cuenta
        if(optionalAccount.isPresent()) { // Si existe
            Account account = optionalAccount.get();
            if(account.getUserRank().hasPermission("permission.i.g.c")) // Si tiene permiso especial
                return 6; // Retorna 6
        }
        List<FarmLandData> farmLands = getPlanet().getAdjacentFarmLands(); // Obtiene tierras agrícolas adyacentes
        if(farmLands.size() <= 2) // Si 2 o menos
            return 4; // Retorna 4
        if(farmLands.size() <= 8) // Si 8 o menos
            return 5; // Retorna 5
        return 6; // Sino, retorna 6
    }

    // Método para obtener el ranking de poder de ataque
    public int getAttackPowerRank() {
        return RankService.getInstance().getAttackPowerRank(this); // Delega al servicio
    }

    // Método para obtener el ranking de derribos
    public int getShootdownsRank() {
        return RankService.getInstance().getShootdownsRank(this); // Delega al servicio
    }

    // Método para obtener el tiempo restante para el próximo reclutamiento
    public int getNextRecruit() {
        if(stats.getNextInvitation() == null || DateUtil.remains(stats.getNextInvitation()) <= 0) // Si no hay próxima invitación o ya pasó
            return 0; // Retorna 0
        return Math.toIntExact(DateUtil.remains(stats.getNextInvitation())); // Retorna tiempo restante en segundos
    }

    // Método para obtener comandante por habilidad
    public Commander getCommanderBySkill(int skillId) {
        return CommanderService.getInstance().getCommanderCache().findBySkillAndUserId(skillId, getPlanet().getUserId()); // Busca por habilidad y usuario
    }

    // Método para obtener comandante por ID
    public Commander getCommander(int commanderId) {
        return CommanderService.getInstance().getCommanderCache().findByCommanderIdAndUserId(commanderId, getPlanet().getUserId()); // Busca por ID y usuario
    }

    // Método para obtener la corporación del usuario
    public Corp getCorp() {
        return CorpService.getInstance().getCorpCache().findByGuid(guid); // Busca corporación por GUID
    }

    // Método para obtener giros disponibles (diarios)
    public int getSpins() {
        if(getLastDayUpdate() != null) // Si hay actualización diaria
            if(DateUtil.currentDay(getLastDayUpdate())) // Si es el mismo día
                return resources.getFreeSpins(); // Retorna giros gratuitos
        resetNewDay(); // Sino, resetea el día
        return resources.getFreeSpins(); // Retorna giros gratuitos
    }

    // Método para obtener el máximo de giros (basado en bono MVP)
    public int getMaxSpins() {
        boolean mvp = stats.hasBonus(BonusType.MVP_DAILY_DRAWS_BONUS); // Verifica bono MVP
        return mvp ? 3 : 1; // Retorna 3 si MVP, 1 si no
    }

    // Método para obtener entradas de incursión (diarias)
    public Pair<Integer, Integer> getRaidEntries() {
        if(getLastDayUpdate() != null) // Si hay actualización diaria
            if(DateUtil.currentDay(getLastDayUpdate())) // Si es el mismo día
                return Pair.of(stats.getRaidAttemptsEntries(), stats.getRaidInterceptEntries()); // Retorna entradas actuales
        resetNewDay(); // Sino, resetea el día
        return Pair.of(stats.getRaidAttemptsEntries(), stats.getRaidInterceptEntries()); // Retorna entradas reseteadas
    }

    // Método para obtener entradas restringidas usadas (diarias)
    public int getRestrictedUsedEntries() {
        if(getLastDayUpdate() != null) // Si hay actualización diaria
            if(DateUtil.currentDay(getLastDayUpdate())) // Si es el mismo día
                return stats.getRestrictedUsedEntries(); // Retorna entradas usadas
        resetNewDay(); // Sino, resetea el día
        return stats.getRestrictedUsedEntries(); // Retorna entradas reseteadas
    }

    // Método para obtener prueba (trial) disponible (diaria)
    public int getTrial() {
        if(getLastDayUpdate() != null) // Si hay actualización diaria
            if(DateUtil.currentDay(getLastDayUpdate())) // Si es el mismo día
                return stats.getTrial(); // Retorna trial actual
        resetNewDay(); // Sino, resetea el día
        return stats.getTrial(); // Retorna trial reseteado
    }

    // Método para obtener puntos de habilidad (SP) disponibles (diarios)
    public int getSp() {
        if(getLastDayUpdate() != null) // Si hay actualización diaria
            if (DateUtil.currentDay(getLastDayUpdate())) // Si es el mismo día
                return stats.getSp(); // Retorna SP actual
        resetNewDay(); // Sino, resetea el día
        return stats.getSp(); // Retorna SP reseteado
    }

    // Método para resetear valores diarios
    public void resetNewDay() {
        setLastDayUpdate(DateUtil.now()); // Establece fecha de actualización
        UserRewards userRewards = getRewards(); // Obtiene recompensas
        RewardsJson rewardsJson = ResourceManager.getRewards(); // Obtiene configuración de recompensas
        if(userRewards == null) { // Si no hay recompensas
            setRewards(UserRewards.builder() // Crea nuevas recompensas
                    .level(-1)
                    .build());
            userRewards = getRewards(); // Asigna
        }
        userRewards.setLevel(0); // Resetea nivel a 0
        userRewards.setUntil(DateUtil.now(rewardsJson.getReward(0).getTime())); // Establece tiempo hasta recompensa
        resources.setFreeSpins(getMaxSpins()); // Resetea giros gratuitos
        stats.setSp(stats.getMaxSp()); // Resetea SP al máximo
        stats.setTrial(0); // Resetea trial a 0
        stats.setRestrictedUsedEntries(0); // Resetea entradas restringidas
        stats.setRaidAttemptsEntries(0); // Resetea entradas de intentos de incursión
        stats.setRaidInterceptEntries(0); // Resetea entradas de intercepción
        stats.setCollectedPoints(false); // Marca puntos como no recolectados
    }

    // Método para obtener colas de tiempo como paquete de respuesta
    public ResponseTimeQueuePacket getQueuesAsPacket() {
        return UserService.getInstance().getUserQueues(this); // Delega al servicio
    }

    // Método para contar naves totales (en flota + almacenadas)
    public int totalShips() {
        return countFleetShips() + ships.countStoredShips(); // Suma naves en flota y almacenadas
    }

    // Método para contar naves en flotas
    public int countFleetShips() {
        int ships = 0; // Contador
        for(Fleet fleet : getFleets()) // Itera sobre flotas
            ships += fleet.ships(); // Suma naves de cada flota
        return ships; // Retorna total
    }

    // Método para enviar mensaje al usuario
    public void sendMessage(String content) {
        Optional<LoggedGameUser> optionalOnline = LoginService.getInstance().getGame(guid); // Obtiene usuario online
        if(optionalOnline.isEmpty()) return; // Si no está online, retorna
        optionalOnline.get().getSmartServer().sendMessage(content); // Envía mensaje
    }

    // Método para enviar advertencia al usuario
    public void sendWarning(String content) {
        Optional<LoggedGameUser> optionalOnline = LoginService.getInstance().getGame(guid); // Obtiene usuario online
        if(optionalOnline.isEmpty()) return; // Si no está online, retorna
        LoggedGameUser online = optionalOnline.get(); // Obtiene usuario
        CustomWarnPacket response = new CustomWarnPacket(); // Crea paquete de advertencia
        response.setSeqId(0); // ID de secuencia
        response.setSrcUserId(0); // ID de usuario fuente
        response.setObjUserId(0); // ID de usuario objetivo
        response.setGuid(0); // GUID
        response.setObjGuid(0); // GUID objetivo
        response.setChannelType((short) 0); // Tipo de canal
        response.setSpecialType((short) 0); // Tipo especial
        response.setPropsId(0); // ID de propiedades
        response.setName(WideString.of(getUsername(), 32)); // Nombre del usuario
        response.setToName(WideString.of(getUsername(), 32)); // Nombre destino
        response.setBuffer(WideString.of(content, 1024)); // Contenido de la advertencia
        online.getSmartServer().send(response); // Envía paquete
    }

    // Método para obtener flotas del usuario
    public List<Fleet> getFleets() {
        return PacketService.getInstance().getFleetCache().findAllByGuid(this.getGuid()); // Busca flotas por GUID
    }

    // Método para obtener flotas en transmisión
    public List<Fleet> getFleetsInTransmission() {
        return PacketService.getInstance().getFleetCache().getInTransmissionFleets(this.getGuid()); // Busca flotas en transmisión
    }

    // Método para obtener comandantes del usuario
    public List<Commander> getCommanders() {
        return CommanderService.getInstance().getCommanders(this); // Delega al servicio
    }

    // Método para obtener ID de galaxia
    public int getGalaxyId() {
        return getPlanet().getPosition().galaxyId(); // Obtiene ID de galaxia del planeta
    }

    // Método para obtener métricas del usuario (inicializa si null)
    public UserMetrics getMetrics() {
        if(metrics == null) // Si es null
            metrics = UserMetrics.builder().build(); // Inicializa
        return metrics; // Retorna métricas
    }

    // Método para obtener el planeta del usuario
    public UserPlanet getPlanet() {
        return GalaxyService.getInstance().getUserPlanet(this); // Delega al servicio de galaxia
    }

    // Método para obtener la cuenta asociada
    public Account getAccount() {
        return AccountService.getInstance().getAccountCache().findById(accountId).orElseGet(null); // Busca cuenta por ID
    }

    //
    // Inicializadores por defecto
    // - Agregar inicializadores por defecto
    // añadidos post-producción
    //

}
