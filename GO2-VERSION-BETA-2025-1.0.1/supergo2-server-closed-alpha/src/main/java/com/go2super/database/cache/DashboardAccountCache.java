// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.DashboardAccount; // Entidad DashboardAccount
import com.go2super.database.repository.DashboardAccountRepository; // Repositorio para DashboardAccount
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.List; // Interfaz List
import java.util.Optional; // Clase Optional
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe

// Anotación que marca esta clase como un componente de Spring
@Component
public class DashboardAccountCache {

    // Campo estático final para el caché de cuentas del dashboard, usando una lista thread-safe
    private static final CopyOnWriteArrayList<DashboardAccount> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de cuentas del dashboard
    private DashboardAccountRepository repository;

    // Constructor con inyección de dependencias para el repositorio (nombre incorrecto del método)
    @Autowired
    public void AccountCache(DashboardAccountRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todas las cuentas del dashboard del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todas las cuentas del dashboard del caché
    public List<DashboardAccount> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una cuenta del dashboard en el repositorio y añadirla al caché si no existe
    public void save(DashboardAccount value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar una cuenta del dashboard (alias para remove)
    public void delete(DashboardAccount value) {
        remove(value);
    }

    // Método para eliminar una cuenta del dashboard del repositorio y del caché
    public void remove(DashboardAccount value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar una cuenta del dashboard por ID
    public Optional<DashboardAccount> findById(String id) {
        return cache.stream().filter(account -> id.equals(account.getId().toString())).findFirst();
    }

    // Método para encontrar una cuenta del dashboard por email
    public Optional<DashboardAccount> findByEmail(String email) {
        return cache.stream().filter(account -> email.equals(account.getEmail())).findFirst();
    }

    // Método para contar el número de cuentas del dashboard en el caché
    public long count() {
        return cache.size();
    }

}
