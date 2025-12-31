// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.User; // Entidad User
import com.go2super.database.repository.UserRepository; // Repositorio para User
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.Collection; // Interfaz Collection
import java.util.List; // Interfaz List
import java.util.Optional; // Clase Optional
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class UserCache {

    // Campo estático final para el caché de usuarios, usando una lista thread-safe
    private static final CopyOnWriteArrayList<User> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de usuarios
    private UserRepository userRepository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void UserCache(UserRepository userRepository) {

        this.userRepository = userRepository;

        init();

    }

    // Método para inicializar el caché cargando todos los usuarios del repositorio
    public void init() {
        cache.addAll(userRepository.findAll());
    }

    // Método para obtener todos los usuarios del caché
    public List<User> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una lista de usuarios en el repositorio y añadirlos al caché
    public void saveAll(List<User> values) {
        values = userRepository.saveAll(values);
        for(User value : values) {
            value.setToSave(false);
            if(!cache.contains(value)) cache.add(value);
        }
    }

    // Método para guardar un usuario en el repositorio y añadirlo al caché si no existe
    public void save(User value) {
        value = userRepository.save(value);
        value.setToSave(false);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar un usuario (alias para remove)
    public void delete(User user) {
        remove(user);
    }

    // Método para eliminar un usuario del repositorio y del caché
    public void remove(User user) {
        userRepository.delete(user);
        cache.remove(user);
    }

    // Método para encontrar usuarios con construcción de naves
    public List<User> findByShipBuilding() {
        return cache.stream().filter(user -> user.getShips().getFactory() != null && !user.getShips().getFactory().isEmpty()).collect(Collectors.toList());
    }

    // Método para encontrar usuarios con mejora de tecnología
    public List<User> findByTechUpgrading() {
        return cache.stream().filter(user -> user.getTechs().getUpgrade() != null).collect(Collectors.toList());
    }

    // Método para encontrar un usuario por ID
    public Optional<User> findById(String id) {
        return cache.stream().filter(user -> user.getId().toString().equals(id)).findFirst();
    }

    // Método para encontrar un usuario por nombre de usuario
    public Optional<User> findByUsername(String username) {
        return cache.stream().filter(user -> user.getUsername().equals(username)).findFirst();
    }

    // Método para encontrar un usuario por ID de usuario
    public User findByUserId(long userId) {
        return cache.stream().filter(user -> user.getUserId() == userId).findFirst().orElse(null);
    }

    // Método para encontrar usuarios por ID de cuenta
    public List<User> findByAccountId(String accountId) {
        return cache.stream().filter(user -> user.getAccountId().equals(accountId)).collect(Collectors.toList());
    }

    // Método para encontrar un usuario por GUID
    public User findByGuid(int guid) {
        User result = cache.stream().filter(user -> user.getGuid() == guid).findFirst().orElse(null);
        return result;
    }

    // Método para encontrar usuarios marcados para guardar
    public List<User> findToSave() {
        return cache.stream().filter(user -> user.isToSave()).collect(Collectors.toList());
    }

    // Método para encontrar usuarios por colección de GUIDs
    public List<User> findByGuid(Collection<Integer> guids) {
        List<User> result = cache.stream().filter(user -> guids.contains(user.getGuid())).collect(Collectors.toList());
        return result;
    }

}
