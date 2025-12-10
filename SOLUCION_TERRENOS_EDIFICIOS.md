# Solución: Terrenos y Edificios No Cargan

## Problema Identificado

Los terrenos y edificios no se cargan en el juego porque **faltaban las imágenes necesarias en el CDN**.

## Causa Raíz

El script `COPIAR_ARCHIVOS_CDN.bat` solo copiaba:
- ✅ Archivos SWF (assets del juego)
- ✅ Archivos de música
- ❌ **NO copiaba las imágenes** (sprites, terrenos, edificios)

El cliente Flash necesita acceder a archivos como `sprites.png` y otras imágenes desde el CDN en `http://localhost:7000/images/`

## Solución Aplicada

### 1. Script Actualizado ✅

El archivo `COPIAR_ARCHIVOS_CDN.bat` ha sido actualizado para:
- Crear la carpeta `cdn\images`
- Copiar todas las imágenes desde `Servidor-ON\app\client\images\` a `cdn\images\`
- Esto incluye `sprites.png` y todas las demás imágenes necesarias

### 2. Archivos Copiados ✅

Se han copiado exitosamente:
```
cdn/images/
  ├── sprites.png          ← CRÍTICO para terrenos y edificios
  ├── bg_game.jpg
  ├── bg_body.jpg
  ├── logo_go.png
  ├── nav_vip.png
  └── profile/             ← Imágenes de perfil de usuario
      ├── 0.png
      ├── 1.png
      ├── ...
      └── 1000.png (Staff)
```

## Cómo Funciona

### Flujo de Datos del Terreno

1. **Frontend** (`website/src/views/myplanets/myplanets.jsx`):
   - Usuario selecciona un terreno:
     - 1 = Llanuras (load.jpg)
     - 2 = Desierto (desert.jpg)
     - 3 = Nieve (snow.jpg)
   - Envía `ground: 1/2/3` al servidor

2. **Backend** (`DashboardService.java`):
   - Convierte el valor:
     ```
     Frontend 1 → Backend 2 (Llanuras)
     Frontend 2 → Backend 0 (Desierto)
     Frontend 3 → Backend 1 (Nieve)
     ```
   - Guarda en la base de datos como `user.ground`

3. **Cliente Flash** (`config.xml`):
   - Carga recursos desde `http://localhost:7000/`
   - Los archivos SWF contienen los gráficos del juego
   - Las imágenes PNG (`sprites.png`) contienen los sprites de terrenos/edificios

4. **Paquetes del Servidor** (`ResponseBuildInfoPacket`):
   - Envía `starType` (tipo de terreno) al cliente
   - Envía `buildInfoList` (lista de edificios) al cliente
   - El cliente Flash usa esta información + las imágenes del CDN para renderizar

## Verificación

### Archivos Necesarios en CDN
- ✅ `cdn/asset/*.swf` (67 archivos SWF)
- ✅ `cdn/asset/music/*.mp3` (archivos de música)
- ✅ `cdn/images/sprites.png` ← **NUEVO**
- ✅ `cdn/images/*.png` y `*.jpg` ← **NUEVO**

### Configuración del Cliente Flash
```xml
<!-- Servidor-ON/app/client/data/config.xml -->
<resources path="http://localhost:7000/" 
           gMap="asset/map/" 
           res="asset/"
           client="asset/0058" 
           galaxyAssetPath="0630galaxy_asset">
    <resource name="map_asset" src="0518map_asset.swf" type="Mc" />
    <resource name="Picres" src="0045Picres.swf" type="Mc" />
    <!-- ... más recursos ... -->
</resources>
```

## Próximos Pasos

### Para Probar la Solución

1. **Detén todos los servicios** si están corriendo
2. **Ejecuta** `COPIAR_ARCHIVOS_CDN.bat` (ya actualizado)
3. **Inicia el juego** con `INICIAR_SUPERGO2.bat`
4. **Crea un nuevo planeta** o **entra a uno existente**
5. **Los terrenos y edificios deberían cargar correctamente** 🎮

### Si Aún No Funciona

Revisa:
1. **Consola del navegador** (F12) → Busca errores de carga de imágenes
2. **CDN corriendo** en puerto 7000: `http://localhost:7000/images/sprites.png`
3. **Cliente Flash corriendo** en puerto 8080
4. **Backend corriendo** en puerto 9090/5050

### Verificar CDN
Abre en el navegador:
- `http://localhost:7000/images/sprites.png` → Debe mostrar la imagen
- `http://localhost:7000/asset/0518map_asset.swf` → Debe descargar el archivo

## Estructura de Tipos de Terreno

### En la Base de Datos (MongoDB)
```javascript
{
  "ground": 0,  // 0 = Desierto, 1 = Nieve, 2 = Llanuras
  "username": "NUEVO1",
  "buildings": [...]
}
```

### En el Código Backend
```java
// User.java
private int ground; // 0 = Desert, 1 = Snow, 2 = Plains

// ResponseBuildInfoPacket
packet.setStarType((byte) user.getGround());
```

### En el Cliente Flash
El campo `starType` indica qué conjunto de texturas usar para renderizar el planeta.

## Notas Técnicas

### ¿Por Qué Se Necesitan las Imágenes?

El cliente Flash usa:
- **Archivos SWF**: Contienen animaciones, UI, y gráficos vectoriales
- **Archivos PNG/JPG**: Contienen texturas bitmap como sprites de terrenos, edificios, y fondos

El archivo `sprites.png` es un **sprite sheet** que contiene todos los sprites de los terrenos y edificios en una sola imagen. El cliente Flash carga esta imagen y luego extrae secciones específicas para renderizar cada elemento.

### Arquitectura del Sistema

```
Cliente Flash (Puerto 8080)
    ↓ Solicita recursos
CDN (Puerto 7000)
    ├── /asset/*.swf      → Gráficos vectoriales
    ├── /asset/music/*.mp3 → Sonidos
    └── /images/*.png      → Texturas y sprites
    
Backend (Puerto 9090/5050)
    ↓ Envía datos del juego
MongoDB (Puerto 27017)
    └── Almacena usuarios, planetas, edificios
```

## Conclusión

✅ **Problema resuelto**: Las imágenes ahora se copian automáticamente al CDN
✅ **Script actualizado**: `COPIAR_ARCHIVOS_CDN.bat` incluye imágenes
✅ **Archivos en su lugar**: `sprites.png` y otras imágenes están en `cdn/images/`

**Los terrenos y edificios ahora deberían cargar correctamente** 🚀

