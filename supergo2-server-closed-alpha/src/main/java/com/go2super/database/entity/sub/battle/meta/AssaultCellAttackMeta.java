// Paquete que contiene la clase, parte del módulo de base de datos para entidades de batalla
package com.go2super.database.entity.sub.battle.meta;

// Importaciones necesarias para tipos de datos y servicios relacionados con cálculos de batalla
import com.go2super.obj.game.IntegerArray; // Clase para manejar arreglos de enteros
import com.go2super.service.battle.calculator.*; // Importa todas las clases del paquete calculator para reducciones y acciones
import lombok.Getter; // Anotación para generar getters automáticamente
import lombok.Setter; // Anotación para generar setters automáticamente
import lombok.ToString; // Anotación para generar método toString automáticamente
import org.springframework.data.annotation.Transient; // Anotación para campos no persistentes en la base de datos

// Importaciones estándar de Java para listas y arreglos
import java.util.ArrayList; // Para listas dinámicas
import java.util.Arrays; // Para operaciones con arreglos
import java.util.List; // Interfaz para listas

// Anotaciones Lombok para generar código boilerplate
@ToString // Genera toString() basado en campos
@Setter // Genera setters para todos los campos
@Getter // Genera getters para todos los campos
public class AssaultCellAttackMeta { // Clase que representa metadatos de ataque de asalto en una celda de batalla

    // Campos públicos para reducciones en el atacante (fuente)
    public int sourceReduceSupply; // Reducción en suministro del atacante
    public int sourceReduceStorage; // Reducción en almacenamiento del atacante

    public int sourceReduceHp; // Reducción en puntos de vida del atacante
    public int sourceReduceShipNum; // Reducción en número de naves del atacante

    // Campo para reducción en salud del objetivo
    public int targetReduceHealth; // Reducción en salud del objetivo (defensor)

    // Arreglos para partes del atacante: ID, número y tasa (probablemente para daños en componentes)
    public int[] sourcePartId = new int[7]; // IDs de las partes del atacante (7 posiciones)
    public int[] sourcePartNum = new int[7]; // Números de las partes del atacante
    public int[] sourcePartRate = new int[7]; // Tasas de daño o algo relacionado con las partes

    // Animación de uso de habilidad del comandante atacante
    public int sourceSkill; // ID o tipo de habilidad usada por el comandante atacante

    // Animación de uso de habilidad del comandante defensor
    public int targetSkill; // ID o tipo de habilidad usada por el comandante defensor

    // Animaciones de disparos entre atacante y defensor
    // Valores de 0 a 7 representan diferentes combinaciones de hits normales, críticos y dobles
    public int targetBlast; // Tipo de animación de impacto en el objetivo

    // Campos privados para uso interno (IDs de equipos, usuarios, etc.)
    private int fromShipTeamId; // ID del equipo de naves atacante
    private int toFortId; // ID del fuerte defensor

    private int fromUserGuid; // GUID del usuario atacante
    private int toUserGuid; // GUID del usuario defensor

    private int fromAmount; // Cantidad o monto relacionado con el atacante
    private int toAmount; // Cantidad o monto relacionado con el defensor

    private int fromId; // ID genérico del atacante
    private int toId; // ID genérico del defensor

    private boolean attack; // Bandera que indica si es un ataque

    // Campos para utilidad de matriz (posicionamiento en batalla)
    private int attackerDirection; // Dirección del atacante
    private int attackerSegmentedPosIndex; // Índice de posición segmentada del atacante
    private int attackerPosIndex; // Índice de posición del atacante
    private int attackerPos; // Posición del atacante

    // Campos para utilidad de reproducción (playback) de la batalla
    private ShipReduction reflectionReduction; // Reducción por reflexión (daño reflejado)

    // Listas de reducciones y derribos para fuertes y naves
    private List<FortReduction> fortReductions; // Lista de reducciones en fuertes
    private List<ShipShootdowns> shipShootdowns; // Lista de derribos de naves

    // Lista de usos de módulos (probablemente habilidades o equipos)
    private List<ModuleUsage> moduleUsages; // Usos de módulos en la batalla

    // Lista de acciones de paquetes de ataque de naves, no persistente en DB
    @Transient
    private List<ShipAttackPacketAction> shipAttackPacketActions = new ArrayList<>(); // Acciones de ataque de naves

    // Constructor que inicializa los arreglos de partes con -1 (valor por defecto)
    public AssaultCellAttackMeta() {
        Arrays.fill(sourcePartId, -1); // Llena el arreglo de IDs de partes con -1
        Arrays.fill(sourcePartNum, -1); // Llena el arreglo de números de partes con -1
        Arrays.fill(sourcePartRate, -1); // Llena el arreglo de tasas de partes con -1
    }

    // Métodos para obtener buffers de IntegerArray de los arreglos de partes
    public IntegerArray sourcePartIdBuffer() { // Retorna un IntegerArray del arreglo sourcePartId
        return new IntegerArray(sourcePartId);
    }

    public IntegerArray sourcePartNumBuffer() { // Retorna un IntegerArray del arreglo sourcePartNum
        return new IntegerArray(sourcePartNum);
    }

    public IntegerArray sourcePartRateBuffer() { // Retorna un IntegerArray del arreglo sourcePartRate
        return new IntegerArray(sourcePartRate);
    }

}
