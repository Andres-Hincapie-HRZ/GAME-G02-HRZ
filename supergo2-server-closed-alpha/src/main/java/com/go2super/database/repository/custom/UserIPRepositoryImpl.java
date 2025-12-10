// Paquete que contiene la implementación personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importación de entidad UserIP
import com.go2super.database.entity.UserIP; // Entidad de IPs de usuario

// Importaciones de subentidades
import com.go2super.database.entity.sub.UserIPInfo; // Información de IP de usuario

// Importación de clase GameServerReceiver
import com.go2super.server.GameServerReceiver; // Receptor del servidor de juego

// Importaciones de Apache Mina
import org.apache.mina.util.ConcurrentHashSet; // Set concurrente

// Importaciones de MongoDB
import org.bson.types.ObjectId; // Tipo de ID de MongoDB

// Importaciones de Spring Data MongoDB
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.data.mongodb.core.MongoTemplate; // Plantilla para operaciones MongoDB
import org.springframework.data.mongodb.core.query.Criteria; // Clase para criterios de consulta
import org.springframework.data.mongodb.core.query.Query; // Clase para consultas

// Importaciones estándar de Java
import java.util.*; // Utilidades de colecciones
import java.util.function.Function; // Función para mapeo
import java.util.function.Predicate; // Predicado para filtrado
import java.util.stream.Collectors; // Operaciones de stream

// Implementación de la interfaz UserIPRepositoryCustom
public class UserIPRepositoryImpl implements UserIPRepositoryCustom {

    // Inyección de MongoTemplate para operaciones de base de datos
    @Autowired // Inyecta la instancia de MongoTemplate
    MongoTemplate mongoTemplate; // Plantilla para consultas MongoDB

    // Implementación del método para actualizar IP de usuario
    @Override
    public void updateUserIP(Account account, User user, GameServerReceiver serverReceiver) {
        // Busca registro existente de UserIP por accountId
        Criteria criteria = Criteria.where("accountId").is(account.getId().toString());
        Query query = new Query(criteria).restrict(UserIP.class);

        Optional<UserIP> optionalUserIP = Optional.ofNullable(mongoTemplate.findOne(query, UserIP.class));
        if(optionalUserIP.isEmpty()) { // Si no existe registro
            // Crea nuevo registro de UserIP
            UserIP userIP = UserIP.builder()
                    .id(ObjectId.get()) // ID único
                    .email(account.getEmail()) // Email de la cuenta
                    .accountId(account.getId().toString()) // ID de la cuenta
                    .accountName(account.getUsername()) // Nombre de la cuenta
                    .ips(new ArrayList<>()) // Lista vacía de IPs
                    .build();

            // Crea información de IP para este usuario
            UserIPInfo userIPInfo = UserIPInfo.builder()
                    .accountId(account.getId().toString()) // ID de cuenta
                    .ip(serverReceiver.getIp()) // Dirección IP
                    .guid(user.getGuid()) // GUID del usuario
                    .userId(user.getUserId()) // ID del usuario
                    .username(user.getUsername()) // Nombre de usuario
                    .count(1) // Conteo inicial
                    .lastTime(new Date()) // Última vez visto
                    .build();

            userIP.getIps().add(userIPInfo); // Agrega información de IP
            mongoTemplate.save(userIP); // Guarda registro
            return; // Termina método
        }

        UserIP userIP = optionalUserIP.get(); // Obtiene registro existente

        // Busca información de IP existente para esta dirección
        Optional<UserIPInfo> optionalUserIPInfo = userIP.getIps().stream().filter(other -> other.getIp().equals(serverReceiver.getIp())).findFirst();
        if(optionalUserIPInfo.isPresent()) { // Si existe información de IP
            UserIPInfo userIPInfo = optionalUserIPInfo.get();
            userIPInfo.setCount(userIPInfo.getCount() + 1); // Incrementa conteo
            userIPInfo.setLastTime(new Date()); // Actualiza última vez visto
            mongoTemplate.save(userIP); // Guarda cambios
            return; // Termina método
        }

        // Crea nueva información de IP si no existe
        UserIPInfo userIPInfo = UserIPInfo.builder()
                .accountId(account.getId().toString()) // ID de cuenta
                .ip(serverReceiver.getIp()) // Dirección IP
                .count(1) // Conteo inicial
                .lastTime(new Date()) // Última vez visto
                .guid(user.getGuid()) // GUID del usuario
                .userId(user.getUserId()) // ID del usuario
                .username(user.getUsername()) // Nombre de usuario
                .build();

        userIP.getIps().add(userIPInfo); // Agrega nueva información de IP
        mongoTemplate.save(userIP); // Guarda cambios
        return; // Termina método
    }

    // Implementación del método para verificar conflicto de IP
    @Override
    public boolean hasIPConflict(Account account, String ip) {
        // Crea criterio compuesto: ips.ip contiene la IP Y accountId diferente al de la cuenta actual
        Criteria criteria = new Criteria().andOperator(Criteria.where("ips.ip").in(ip), Criteria.where("accountId").ne(account.getId().toString()));
        Query query = new Query(criteria);

        return mongoTemplate.exists(query, UserIP.class); // Retorna true si existe al menos un documento
    }

    // Implementación del método para obtener conflictos de IP
    @Override
    public List<UserIP> getIPConflict(String ip) {
        // Crea criterio para buscar registros que contengan la IP
        Criteria criteria = Criteria.where("ips.ip").in(ip);
        Query query = new Query(criteria);

        List<UserIP> userIPs = mongoTemplate.find(query, UserIP.class); // Obtiene lista de registros
        // Filtra para obtener solo registros únicos por accountId
        userIPs = userIPs.stream().filter(distinctBy(UserIP::getAccountId)).collect(Collectors.toList());

        return userIPs; // Retorna lista filtrada
    }

    // Método auxiliar para filtrar elementos únicos por una propiedad
    public static <T> Predicate<T> distinctBy(Function<? super T, ?> f) {
        Set<Object> objects = new ConcurrentHashSet<>(); // Set concurrente para almacenar valores únicos
        return t -> objects.add(f.apply(t)); // Retorna true si el valor no estaba presente (lo agrega)
    }

}
