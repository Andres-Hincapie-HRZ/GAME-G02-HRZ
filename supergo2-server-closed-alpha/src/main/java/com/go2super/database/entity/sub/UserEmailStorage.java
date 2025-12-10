// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.Collections; // Utilidades para colecciones
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que maneja el almacenamiento de emails de un usuario
public class UserEmailStorage {

    private List<Email> userEmails = new ArrayList<>(); // Lista de emails del usuario

    // Método para obtener la lista de emails
    public List<Email> getUserEmails(){
        return userEmails; // Retorna la lista de emails
    }

    // Método para agregar un email
    public void addEmail(Email email){
        if(userEmails == null) // Si la lista es null
            userEmails = new ArrayList<>(); // Inicializa nueva lista

        userEmails.add(email); // Agrega el email
    }

    // Método para obtener email por ID automático
    public Email getEmail(int id) {
        /* Código comentado: obtener por índice en lista ordenada
        List<Email> emails = getSortedEmails();
        if(emails.size() <= id) return null;
        return emails.get(id);*/

        for(Email email : getSortedEmails()) // Itera sobre emails ordenados
            if(email.getAutoId() == id) return email; // Si coincide ID automático, retorna

        return null; // Retorna null si no encuentra
    }

    // Método para obtener siguiente ID automático disponible (versión pública)
    public int nextAutoId() {
        return nextAutoId(0); // Llama a versión privada empezando desde 0
    }

    // Método privado recursivo para encontrar siguiente ID automático disponible
    private int nextAutoId(int autoId) {
        for(Email email : getSortedEmails()) // Itera sobre emails ordenados
            if(email.getAutoId() == autoId) // Si el ID ya existe
                return nextAutoId(++autoId); // Incrementa y busca recursivamente
        return autoId; // Retorna el ID disponible encontrado
    }

    // Método para obtener ID automático de un email específico
    public int getAutoId(Email email) {
        return getSortedEmails().indexOf(email); // Retorna índice en lista ordenada
    }

    // Método para obtener emails ordenados
    public List<Email> getSortedEmails() {
        List<Email> emails = new ArrayList<>(userEmails); // Copia la lista
        Collections.sort(emails); // Ordena la lista (Email debe implementar Comparable)
        return emails; // Retorna lista ordenada
    }

}
