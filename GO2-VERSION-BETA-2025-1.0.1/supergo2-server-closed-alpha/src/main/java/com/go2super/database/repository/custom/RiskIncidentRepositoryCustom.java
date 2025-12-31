// Paquete que contiene la interfaz personalizada, parte del módulo de repositorios personalizados de base de datos
package com.go2super.database.repository.custom;

// Importación de entidad Account
import com.go2super.database.entity.Account; // Entidad de cuenta

// Importación de entidad User
import com.go2super.database.entity.User; // Entidad de usuario

// Importaciones de subentidades de incidentes
import com.go2super.database.entity.sub.BadGuidIncident; // Entidad de incidente de GUID malo
import com.go2super.database.entity.sub.PacketFloodIncident; // Entidad de incidente de inundación de paquetes
import com.go2super.database.entity.sub.SameIPIncident; // Entidad de incidente de misma IP

// Importación de clase Packet
import com.go2super.packet.Packet; // Clase de paquete

// Importación de clase GameServerReceiver
import com.go2super.server.GameServerReceiver; // Receptor del servidor de juego

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista
import java.util.Optional; // Para valores opcionales

// Interfaz personalizada para consultas específicas de RiskIncidentRepository
public interface RiskIncidentRepositoryCustom {

    // Método para obtener detecciones de misma IP para una cuenta
    List<SameIPIncident> getSameIPDetections(Account account); // Retorna lista de incidentes de misma IP por account

    // Método para verificar y guardar incidente de misma IP
    Optional<SameIPIncident> checkSameIPAndSave(Account account, User user, GameServerReceiver serverReceiver); // Verifica y guarda incidente de misma IP

    // Método para verificar y guardar incidente de GUID malo
    Optional<BadGuidIncident> checkBadGuidAndSave(User user, GameServerReceiver serverReceiver, Packet packet, int targetGuid); // Verifica y guarda incidente de GUID malo

    // Método para verificar y guardar incidente de inundación de paquetes
    Optional<PacketFloodIncident> checkPacketFloodAndSave(User user, GameServerReceiver serverReceiver, String packetName, double ppt); // Verifica y guarda incidente de inundación

}
