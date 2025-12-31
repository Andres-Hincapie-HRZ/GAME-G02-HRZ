// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de entidad UserIP
import com.go2super.database.entity.UserIP; // Entidad de IPs de usuario

// Importaciones de subentidades de incidentes
import com.go2super.database.entity.sub.*; // Todas las subentidades

// Importación de clase Packet
import com.go2super.packet.Packet; // Clase de paquete

// Importación de clase GameServerReceiver
import com.go2super.server.GameServerReceiver; // Receptor del servidor de juego

// Importación de servicio AccountService
import com.go2super.service.AccountService; // Servicio de cuentas

// Importación de servicio RiskService
import com.go2super.service.RiskService; // Servicio de riesgos

// Importación de utilidad IPLocation
import com.go2super.socket.util.IPLocation; // Utilidad para localización de IP

// Importación de DTO IPLookupDTO
import com.go2super.socket.util.dto.IPLookupDTO; // DTO para búsqueda de IP

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.*; // Utilidades de colecciones

// Implementación de la interfaz RiskIncidentRepositoryCustom
public class RiskIncidentRepositoryImpl implements RiskIncidentRepositoryCustom {

    // Lista de proveedores de ISP permitidos (whitelist)
    private static final List<String> ISP_WHITELIST = Arrays.asList(
            "CloudMosa Inc.", // Puffin
            "Cogent Communications", // Puffin
            "Starhub Internet Pte Ltd" // Puffin
    );

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para obtener detecciones de misma IP
    @Override
    public List<SameIPIncident> getSameIPDetections(Account account) {
        // Crea criterio para buscar por nombre de usuario en el campo anidado users.accountName
        Criteria criteria = Criteria.where("users.accountName").is(account.getUsername());
        // Crea consulta con restricción a SameIPIncident
        Query query = new Query(criteria).restrict(SameIPIncident.class);
        // Ejecuta la consulta y retorna lista
        return mongoTemplate.find(query, SameIPIncident.class);
    }

    // Implementación del método para verificar y guardar incidente de misma IP
    @Override
    public Optional<SameIPIncident> checkSameIPAndSave(Account account, User user, GameServerReceiver serverReceiver) {
        // Registra esta IP en el servicio de riesgos
        RiskService.getInstance().getUserIPRepository().updateUserIP(account, user, serverReceiver);

        // Variables para información de IP
        String IP = serverReceiver.getIp(); // Dirección IP
        String ISP = "Unknown"; // Proveedor de servicios de internet
        String COUNTRY = "Unknown"; // País

        // Intenta obtener información de localización de IP
        Optional<IPLookupDTO> optionalIpLookupDTO = IPLocation.getLocation(IP);

        isp : if(optionalIpLookupDTO.isPresent()) { // Si se encontró información
            String isp = optionalIpLookupDTO.get().getIsp(); // Obtiene ISP
            if(isp == null) break isp; // Si no hay ISP, salta

            if(ISP_WHITELIST.contains(isp)) return Optional.empty(); // Si está en whitelist, no crear incidente

            ISP = isp; // Asigna ISP
            COUNTRY = optionalIpLookupDTO.get().getCountry(); // Asigna país
        }

        if(ISP == null) ISP = "Unknown"; // Valor por defecto
        if(COUNTRY == null) COUNTRY = "Unknown"; // Valor por defecto

        // Busca incidente existente para esta IP
        Criteria criteria = Criteria.where("ip").is(IP);
        Query query = new Query(criteria).restrict(SameIPIncident.class);

        Optional<SameIPIncident> optionalSameIPIncident = Optional.ofNullable(mongoTemplate.findOne(query, SameIPIncident.class));

        if(optionalSameIPIncident.isPresent()) { // Si existe incidente
            SameIPIncident sameIPIncident = optionalSameIPIncident.get();

            if(sameIPIncident.getUsers() == null) // Si no hay lista de usuarios
                sameIPIncident.setUsers(new ArrayList<>()); // Inicializa lista

            // Busca usuario existente en el incidente
            Optional<UserSameIPIncidentInfo> optionalUser = sameIPIncident.getUsers().stream().filter(other -> other.getGuid() == user.getGuid()).findFirst();

            if(optionalUser.isPresent()) { // Si el usuario ya está en el incidente
                UserSameIPIncidentInfo userSameIPIncidentInfo = optionalUser.get();
                userSameIPIncidentInfo.setCount(userSameIPIncidentInfo.getCount() + 1); // Incrementa contador
                userSameIPIncidentInfo.setCountry(COUNTRY); // Actualiza país
                userSameIPIncidentInfo.setIsp(ISP); // Actualiza ISP
            } else { // Si es un nuevo usuario en el incidente
                sameIPIncident.getUsers().add(UserSameIPIncidentInfo.builder()
                        .userId(user.getUserId())
                        .accountId(serverReceiver.getAccountId())
                        .discord(serverReceiver.getDiscordId())
                        .accountName(serverReceiver.getAccountName())
                        .email(serverReceiver.getAccountEmail())
                        .username(user.getUsername())
                        .guid(user.getGuid())
                        .userId(user.getUserId())
                        .ip(serverReceiver.getIp())
                        .country(COUNTRY)
                        .isp(ISP)
                        .count(1) // Primer conteo
                        .timestamp(new Date()) // Timestamp actual
                        .build());
            }

            mongoTemplate.save(sameIPIncident); // Guarda el incidente actualizado
            return Optional.of(sameIPIncident); // Retorna el incidente
        }

        // Crea nuevo incidente si no existe
        SameIPIncident sameIPIncident = SameIPIncident.builder()
                .id(ObjectId.get()) // ID único
                .ip(serverReceiver.getIp()) // IP del incidente
                .creation(new Date()) // Fecha de creación
                .creator("Medusa") // Creador del sistema
                .ignore(false) // No ignorar por defecto
                .users(new ArrayList<>()) // Lista vacía de usuarios
                .build();

        String ip = serverReceiver.getIp();
        // Verifica si hay conflicto de IP (múltiples cuentas)
        boolean conflict = RiskService.getInstance().getUserIPRepository().hasIPConflict(account, serverReceiver.getIp());

        if(conflict) { // Si hay conflicto
            // Obtiene todas las IPs conflictivas
            List<UserIP> conflicts = RiskService.getInstance().getUserIPRepository().getIPConflict(serverReceiver.getIp());

            for(UserIP userIP : conflicts) { // Para cada IP conflictiva
                // Busca la información específica de IP
                Optional<UserIPInfo> optionalUserIPInfo = userIP.getIps().stream().filter(other -> other.getIp().equals(ip)).findFirst();
                if(optionalUserIPInfo.isEmpty()) continue; // Si no encuentra, continúa

                UserIPInfo userIPInfo = optionalUserIPInfo.get();

                // Crea información de incidente para este usuario
                UserSameIPIncidentInfo incidentInfo = UserSameIPIncidentInfo.builder()
                        .userId(userIPInfo.getUserId())
                        .guid(userIPInfo.getGuid())
                        .accountId(userIPInfo.getAccountId())
                        .username(userIPInfo.getUsername())
                        .ip(ip)
                        .country(COUNTRY)
                        .isp(ISP)
                        .count(1)
                        .timestamp(new Date())
                        .build();

                // Obtiene información adicional de la cuenta si existe
                Optional<Account> optionalAccount = AccountService.getInstance().getAccountCache().findById(userIPInfo.getAccountId());
                if(optionalAccount.isPresent()) {
                    Account userAccount = optionalAccount.get();
                    if(userAccount.getDiscordHook() != null && userAccount.getDiscordHook().getDiscordId() != null)
                        incidentInfo.setDiscord(userAccount.getDiscordHook().getDiscordId());
                    incidentInfo.setEmail(userAccount.getEmail());
                    incidentInfo.setAccountName(userAccount.getUsername());
                }

                sameIPIncident.getUsers().add(incidentInfo); // Agrega al incidente
            }

            mongoTemplate.save(sameIPIncident); // Guarda el incidente
            return Optional.of(sameIPIncident); // Retorna el incidente
        }

        return Optional.empty(); // No hay conflicto, retorna vacío
    }

    // Implementación del método para verificar y guardar incidente de GUID malo
    @Override
    public Optional<BadGuidIncident> checkBadGuidAndSave(User user, GameServerReceiver serverReceiver, Packet packet, int targetGuid) {
        // Busca incidente existente para este GUID
        Criteria criteria = Criteria.where("guid").is(user.getGuid());
        Query query = new Query(criteria).restrict(BadGuidIncident.class);

        Optional<BadGuidIncident> optionalBadGuidIncident = Optional.ofNullable(mongoTemplate.findOne(query, BadGuidIncident.class));
        if(optionalBadGuidIncident.isPresent()) { // Si existe incidente
            BadGuidIncident badGuidIncident = optionalBadGuidIncident.get();

            if(badGuidIncident.getLastDetections() == null) // Si no hay lista de detecciones
                badGuidIncident.setLastDetections(new ArrayList<>()); // Inicializa lista

            badGuidIncident.getLastDetections().add(packet.getClass().getSimpleName()); // Agrega detección actual
            badGuidIncident.setLastDetection(new Date()); // Actualiza última detección
            badGuidIncident.setTotalCount(badGuidIncident.getTotalCount() + 1); // Incrementa contador total

            mongoTemplate.save(badGuidIncident); // Guarda incidente
            return Optional.of(badGuidIncident); // Retorna incidente
        }

        // Crea nuevo incidente si no existe
        BadGuidIncident badGuidIncident = BadGuidIncident.builder()
                .id(ObjectId.get()) // ID único
                .accountId(serverReceiver.getAccountId()) // ID de cuenta
                .discord(serverReceiver.getDiscordId()) // ID de Discord
                .accountName(serverReceiver.getAccountName()) // Nombre de cuenta
                .email(serverReceiver.getAccountEmail()) // Email
                .guid(user.getGuid()) // GUID del usuario
                .userId(user.getUserId()) // ID del usuario
                .targetGuid(targetGuid) // GUID objetivo
                .creation(new Date()) // Fecha de creación
                .creator("Medusa") // Creador del sistema
                .ignore(false) // No ignorar por defecto
                .totalCount(1) // Conteo inicial
                .lastDetections(Arrays.asList(packet.getClass().getSimpleName())) // Lista de detecciones
                .lastDetection(new Date()) // Última detección
                .build();

        mongoTemplate.save(badGuidIncident); // Guarda incidente
        return Optional.ofNullable(badGuidIncident); // Retorna incidente
    }

    // Implementación del método para verificar y guardar incidente de inundación de paquetes
    @Override
    public Optional<PacketFloodIncident> checkPacketFloodAndSave(User user, GameServerReceiver serverReceiver, String packetName, double ppt) {
        // Busca incidente existente para este GUID
        Criteria criteria = Criteria.where("guid").is(user.getGuid());
        Query query = new Query(criteria).restrict(PacketFloodIncident.class);

        Optional<PacketFloodIncident> optionalPacketFloodIncident = Optional.ofNullable(mongoTemplate.findOne(query, PacketFloodIncident.class));
        if(optionalPacketFloodIncident.isPresent()) { // Si existe incidente
            PacketFloodIncident floodIncident = optionalPacketFloodIncident.get();

            floodIncident.setTotalReports(floodIncident.getTotalReports() + 1); // Incrementa reportes totales
            floodIncident.setPpt((floodIncident.getPpt() + ppt) / floodIncident.getTotalReports()); // Actualiza PPT promedio
            floodIncident.setLastDetection(new Date()); // Actualiza última detección

            if(floodIncident.getLastPackets() == null) // Si no hay lista de paquetes
                floodIncident.setLastPackets(new LinkedList<>()); // Inicializa lista

            if(floodIncident.getLastPackets().size() + 1 > 100) // Si excede límite
                floodIncident.getLastPackets().removeLast(); // Remueve el más antiguo

            floodIncident.getLastPackets().addFirst(packetName); // Agrega paquete actual al inicio
            mongoTemplate.save(floodIncident); // Guarda incidente
            return Optional.of(floodIncident); // Retorna incidente
        }

        // Crea lista de paquetes para nuevo incidente
        LinkedList<String> lastPackets = new LinkedList<>();
        lastPackets.addFirst(packetName); // Agrega paquete actual

        // Crea nuevo incidente si no existe
        PacketFloodIncident floodIncident = PacketFloodIncident.builder()
                .id(ObjectId.get()) // ID único
                .accountId(serverReceiver.getAccountId()) // ID de cuenta
                .discord(serverReceiver.getDiscordId()) // ID de Discord
                .accountName(serverReceiver.getAccountName()) // Nombre de cuenta
                .email(serverReceiver.getAccountEmail()) // Email
                .username(user.getUsername()) // Nombre de usuario
                .guid(user.getGuid()) // GUID del usuario
                .userId(user.getUserId()) // ID del usuario
                .creation(new Date()) // Fecha de creación
                .creator("Medusa") // Creador del sistema
                .ignore(false) // No ignorar por defecto
                .totalReports(1) // Reportes iniciales
                .lastDetection(new Date()) // Última detección
                .lastPackets(lastPackets) // Lista de paquetes
                .ppt(ppt / 1) // PPT inicial
                .build();

        mongoTemplate.save(floodIncident); // Guarda incidente
        return Optional.ofNullable(floodIncident); // Retorna incidente
    }

}
