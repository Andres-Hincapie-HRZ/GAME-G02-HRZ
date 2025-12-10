// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Clase que maneja las colecciones de miembros y reclutas de una corporación
public class CorpMembers {

    private List<CorpMember> members = new ArrayList<>(); // Lista de miembros activos
    private List<CorpMember> recruits = new ArrayList<>(); // Lista de reclutas

    // Método para obtener la lista de miembros
    public List<CorpMember> getMembers() {
        return members; // Retorna lista de miembros
    }

    // Método para obtener la lista de reclutas
    public List<CorpMember> getRecruits(){
        return recruits; // Retorna lista de reclutas
    }

    // Método para agregar un miembro a la corporación
    public void addMember(CorpMember member) {
        if(members == null) // Si la lista es null
            members = new ArrayList<>(); // Inicializa nueva lista

        members.add(member); // Agrega el miembro
    }

    // Método para remover un miembro por GUID
    public void removeMember(int guid){
        CorpMember member = getMember(guid); // Obtiene el miembro
        members.remove(member); // Remueve de la lista
    }

    // Método para agregar un recluta
    public void addRecruit(CorpMember recruit) {
        if(recruits == null) // Si la lista es null
            members = new ArrayList<>(); // Inicializa nueva lista (error: debería ser recruits)

        recruits.add(recruit); // Agrega el recluta
    }

    // Método para remover un recluta por GUID
    public void removeRecruit(int guid){
        CorpMember recruit = getRecruit(guid); // Obtiene el recluta
        recruits.remove(recruit); // Remueve de la lista
    }

    // Método para obtener un recluta por GUID
    public CorpMember getRecruit(int guid){
        for(CorpMember recruit : recruits) // Itera sobre reclutas
            if(recruit.getGuid() == guid) // Si coincide GUID
                return recruit; // Retorna el recluta

        return null; // Retorna null si no se encuentra
    }

    // Método para obtener un miembro por GUID
    public CorpMember getMember(int guid) {
        for(CorpMember member : members) // Itera sobre miembros
            if(member.getGuid() == guid) // Si coincide GUID
                return member; // Retorna el miembro

        return null; // Retorna null si no se encuentra
    }

    // Método para obtener el líder de la corporación (rango 1 = colonel)
    public CorpMember getLeader() {
        for(CorpMember member: members) // Itera sobre miembros
            if(member.getRank() ==  1) // Si es rango 1 (líder)
                return member; // Retorna el líder

        return null; // Retorna null si no hay líder
    }

}
