// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de objeto de juego Prop
import com.go2super.obj.game.Prop; // Representa un item/propiedad en el juego

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.ToString; // Genera toString

// Importación de Apache Commons para pares de valores
import org.apache.commons.lang3.tuple.Pair; // Para retornar múltiples valores

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista
import java.util.stream.Collectors; // Operaciones de stream

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@ToString // Genera toString
// Clase que representa el inventario personal de un usuario
public class UserInventory {

    private int maximumStacks; // Número máximo de stacks permitidos
    private int stackPrice; // Precio por stack

    private List<Prop> propList; // Lista de props en el inventario

    // Método para obtener un prop por ID (tipo de almacenamiento por defecto 0)
    public Prop getProp(int propId) {
        return getProp(propId, 0); // Llama al método sobrecargado con storageType 0
    }

    // Método para obtener un prop por ID y tipo de almacenamiento
    public Prop getProp(int propId, int storageType) {
        for(Prop prop : propList) // Itera sobre la lista de props
            if(prop.getPropId() == propId && prop.getStorageType() == storageType) // Si coincide ID y tipo
                return prop; // Retorna el prop encontrado
        return null; // Retorna null si no se encuentra
    }

    // Método para remover un prop (cantidad 1, sin lock)
    public boolean removeOneProp(Prop prop, boolean lock) {
        return removeProp(prop, 1, lock); // Llama al método general con cantidad 1
    }

    // Método para remover un prop con cantidad específica
    public boolean removeProp(Prop prop, int num, boolean lock) {
        return removeProp(prop.getPropId(), num, prop.getStorageType(), lock); // Delega con parámetros del prop
    }

    // Método para remover prop retornando par de booleanos (éxito, estaba lockeado)
    public Pair<Boolean, Boolean> removeProp(Prop prop, int num) {
        boolean propLock = prop.getPropLockNum() > 0; // Verifica si tiene props lockeados
        return propLock ? Pair.of(removeProp(prop, num, true), true) : Pair.of(removeProp(prop, num, false), false); // Retorna par según estado
    }

    // Método principal para remover props
    public boolean removeProp(int propId, int num, int storageType, boolean lock) {
        Prop prop = getProp(propId, storageType); // Obtiene el prop
        if(prop == null) return false; // Si no existe, retorna false

        int propNum = lock ? prop.getPropLockNum() : prop.getPropNum(); // Obtiene cantidad según lock
        if(num > propNum) return false; // Si se intenta remover más de lo disponible, retorna false

        if(lock) prop.setPropLockNum(propNum - num); // Si es lock, reduce cantidad lockeada
        else prop.setPropNum(propNum - num); // Sino, reduce cantidad normal

        if(prop.getPropNum() == 0 && prop.getPropLockNum() == 0) // Si no quedan props
            propList.remove(prop); // Remueve de la lista

        return true; // Retorna true si se removió exitosamente
    }

    // Método para verificar si tiene suficiente cantidad de un prop
    public boolean hasProp(int propId, int num, int storageType, boolean lock) {
        Prop prop = getProp(propId, storageType); // Obtiene el prop
        if(prop == null) return false; // Si no existe, retorna false

        int propNum = lock ? prop.getPropLockNum() : prop.getPropNum(); // Obtiene cantidad según lock
        if(num > propNum) return false; // Si no tiene suficiente, retorna false

        return true; // Retorna true si tiene suficiente
    }

    // Método para agregar prop con objeto Prop
    public boolean addProp(Prop prop, int num, boolean lock) {
        return addProp(prop.getPropId(), num, prop.getStorageType(), lock); // Delega con parámetros del prop
    }

    // Método principal para agregar props
    public boolean addProp(int propId, int num, int storageType, boolean lock) {
        Prop prop = getProp(propId, storageType); // Busca prop existente

        if(prop == null) { // Si no existe
            if(countStacks(storageType) + 1 > maximumStacks) // Si excede stacks máximos
                return false; // Retorna false

            propList.add(new Prop(propId, lock ? 0 : num, lock ? num : 0, storageType, 0)); // Agrega nuevo prop
            return true; // Retorna true
        }

        int newNum = Math.min(9999, lock ? prop.getPropLockNum() + num : prop.getPropNum() + num); // Calcula nueva cantidad (máximo 9999)

        if(lock) prop.setPropLockNum(newNum); // Si es lock, actualiza cantidad lockeada
        else prop.setPropNum(newNum); // Sino, actualiza cantidad normal

        return true; // Retorna true si se agregó exitosamente
    }

    // Método para contar stacks por tipo de almacenamiento
    public long countStacks(int storageType) {
        long result = 0; // Contador de stacks
        List<Prop> props = propList.stream().filter(prop -> prop.getStorageType() == storageType).collect(Collectors.toList()); // Filtra por tipo

        for(Prop prop : props) { // Itera sobre props filtrados
            if (prop.getPropNum() > 0) // Si tiene cantidad normal
                result++; // Incrementa contador
            if (prop.getPropLockNum() > 0) // Si tiene cantidad lockeada
                result++; // Incrementa contador
        }

        return result; // Retorna número de stacks
    }

    // Método de debug para agregar prop (solo para desarrollo)
    public UserInventory debugAddProp(int propId, int propNum, int storageType) {
        propList.add(new Prop(propId, propNum, 0, storageType, 0)); // Agrega prop sin lock
        return this; // Retorna this para encadenamiento
    }

    // Método de debug para agregar prop con parámetros completos
    public UserInventory debugAddProp(int propId, int propNum, int propLockNum, int storageType, int reserve) {
        propList.add(new Prop(propId, propNum, propLockNum, storageType, reserve)); // Agrega prop con todos los parámetros
        return this; // Retorna this para encadenamiento
    }

}
