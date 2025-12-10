// Declaración del paquete donde se encuentra esta clase
package com.go2super.database.cache;

// Importaciones necesarias para entidades, repositorios, utilidades y anotaciones de Spring
import com.go2super.database.entity.Corp; // Entidad Corp
import com.go2super.database.repository.CorpRepository; // Repositorio para Corp
import com.go2super.utility.GlueList; // Utilidad para listas
import org.springframework.beans.factory.annotation.Autowired; // Anotación para inyección de dependencias
import org.springframework.stereotype.Component; // Anotación para marcar como componente de Spring

import java.util.Collection; // Interfaz Collection
import java.util.List; // Interfaz List
import java.util.concurrent.CopyOnWriteArrayList; // Lista thread-safe
import java.util.stream.Collectors; // Utilidad para streams

// Anotación que marca esta clase como un componente de Spring
@Component
public class CorpCache {

    // Campo estático final para el caché de corporaciones, usando una lista thread-safe
    private static final CopyOnWriteArrayList<Corp> cache = new CopyOnWriteArrayList<>();

    // Campo para el repositorio de corporaciones
    private CorpRepository repository;

    // Constructor con inyección de dependencias para el repositorio
    @Autowired
    public void CorpCache(CorpRepository repository) {

        this.repository = repository;

        init();

    }

    // Método para inicializar el caché cargando todas las corporaciones del repositorio
    public void init() {
        cache.addAll(repository.findAll());
    }

    // Método para obtener todas las corporaciones del caché
    public List<Corp> findAll() {
        return new GlueList<>(cache);
    }

    // Método para guardar una corporación en el repositorio y añadirla al caché si no existe
    public void save(Corp value) {
        value = repository.save(value);
        if(!cache.contains(value)) {
            cache.add(value);
        }
    }

    // Método para eliminar una corporación (alias para remove)
    public void delete(Corp value) {
        remove(value);
    }

    // Método para eliminar una corporación del repositorio y del caché
    public void remove(Corp value) {
        repository.delete(value);
        cache.remove(value);
    }

    // Método para encontrar corporaciones por ID de bloque
    public List<Corp> findByBlocId(String blocId) {
        return cache.stream().filter(value -> blocId.equals(value.getBlocId())).collect(Collectors.toList());
    }

    // Método para encontrar corporaciones por colección de IDs de corporación
    public List<Corp> findByCorpId(Collection<Integer> corpIds) {
        return cache.stream().filter(value -> corpIds.contains(value.getCorpId())).collect(Collectors.toList());
    }

    // Método para encontrar una corporación por ID de corporación
    public Corp findByCorpId(int corpId) {
        return cache.stream().filter(value -> value.getCorpId() == corpId).findFirst().orElse(null);
    }

    // Método para encontrar una corporación por acrónimo
    public Corp findByAcronym(String acronym) {
        return cache.stream().filter(value -> acronym.equals(value.getAcronym())).findFirst().orElse(null);
    }

    // Método para encontrar una corporación por GUID
    public Corp findByGuid(int guid) {
        return cache.stream().filter(value -> value.getMembers() != null && value.getMembers().getMember(guid) != null).findFirst().orElse(null);
    }

    // Método para encontrar corporaciones con mejoras de corporación
    public List<Corp> findByCorpUpgrade() {
        return cache.stream().filter(value -> value.getCorpUpgrade() != null).collect(Collectors.toList());
    }

    // Método para encontrar una corporación por nombre
    public Corp findByName(String name) {
        return cache.stream().filter(value -> name.equals(value.getName())).findFirst().orElse(null);
    }

    // Método para encontrar corporaciones con reclutas por GUID
    public List<Corp> findRecruitsByGuid(int guid) {
        return cache.stream().filter(value -> value.getMembers() != null && value.getMembers().getRecruits() != null && value.getMembers().getRecruit(guid) != null).collect(Collectors.toList());
    }

    // Método para encontrar corporaciones que empiecen con un nombre dado
    public List<Corp> findByStartWithName(String name) {
        return cache.stream().filter(value -> value.getName() != null && value.getName().startsWith(name)).collect(Collectors.toList());
    }

    // Método para contar el número de corporaciones en el caché
    public long count() {
        return cache.size();
    }

}
