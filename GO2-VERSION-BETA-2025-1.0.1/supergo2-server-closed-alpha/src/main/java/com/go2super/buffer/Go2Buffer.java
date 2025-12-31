package com.go2super.buffer; // Declaración del paquete donde se encuentra la clase

import com.go2super.obj.utility.SmartString; // Importación de la clase SmartString para manejo de strings inteligentes
import com.go2super.socket.util.BufferUtil; // Importación de utilidades para buffers
import lombok.Data; // Importación de la anotación @Data de Lombok para generar getters y setters automáticamente
import org.apache.mina.core.buffer.IoBuffer; // Importación del buffer IoBuffer de Apache MINA

import java.nio.ByteBuffer; // Importación de ByteBuffer de Java NIO
import java.nio.ByteOrder; // Importación de ByteOrder para orden de bytes
import java.nio.charset.StandardCharsets; // Importación de StandardCharsets para codificación de caracteres

@Data // Anotación de Lombok que genera automáticamente getters, setters, toString, equals y hashCode
public class Go2Buffer { // Declaración de la clase Go2Buffer

    public static boolean WEIRD_LOG = true; // Variable estática para habilitar logs extraños (probablemente para debugging)
    private IoBuffer buffer; // Buffer interno de tipo IoBuffer

    private String packetName; // Nombre del paquete (posiblemente para identificación)

    private int size; // Tamaño del buffer
    private int type; // Tipo del mensaje o paquete

    private int calculatedSize = 0; // Tamaño calculado acumulado

    public Go2Buffer(int allocate) { // Constructor que asigna un buffer de tamaño especificado
        this.size = allocate; // Asigna el tamaño
        this.buffer = IoBuffer.allocate(allocate); // Asigna el buffer IoBuffer
        this.buffer.order(ByteOrder.LITTLE_ENDIAN); // Establece el orden de bytes a little-endian
    }

    public Go2Buffer(IoBuffer ioBuffer, boolean fetchHeader) { // Constructor que toma un IoBuffer existente y opcionalmente obtiene el header

        this.buffer = ioBuffer; // Asigna el buffer proporcionado
        this.buffer.order(ByteOrder.LITTLE_ENDIAN); // Establece orden little-endian

        if(!fetchHeader) // Si no se debe obtener el header, retorna
            return;

        this.size = getMsgSize(); // Obtiene el tamaño del mensaje
        this.type = getMsgType(); // Obtiene el tipo del mensaje

    }

    public Go2Buffer(ByteBuffer byteBuffer, boolean fetchHeader) { // Constructor que toma un ByteBuffer y opcionalmente obtiene el header

        this.buffer = IoBuffer.wrap(byteBuffer); // Envuelve el ByteBuffer en un IoBuffer
        this.buffer.order(ByteOrder.LITTLE_ENDIAN); // Establece orden little-endian

        if(!fetchHeader) // Si no se debe obtener el header, retorna
            return;

        this.size = getMsgSize(); // Obtiene el tamaño del mensaje
        this.type = getMsgType(); // Obtiene el tipo del mensaje

    }

    public int position() { // Método que retorna la posición actual del buffer
        return this.getBuffer().position(); // Retorna la posición del buffer interno
    }

    public int limit() { // Método que retorna el límite del buffer (tamaño)
        return size(); // Llama al método size()
    }

    public int size() { // Método que retorna el tamaño del buffer
        return this.getBuffer().limit(); // Retorna el límite del buffer interno
    }

    public Go2Buffer setId(int id) { // Método para establecer el ID del paquete, agregando tamaño y tipo
        this.type = id; // Asigna el tipo
        return addShort(this.size).addShort(id); // Agrega el tamaño y el ID como shorts, retorna this para chaining
    }

    public Go2Buffer addByte(byte number) { // Método para agregar un byte al buffer
        this.buffer.put(number); // Pone el byte en el buffer
        this.calculatedSize++; // Incrementa el tamaño calculado
        return this; // Retorna this para chaining
    }

    public Go2Buffer addInt(int number) { // Método para agregar un int al buffer
        this.buffer.putInt(number); // Pone el int en el buffer
        this.calculatedSize += 4; // Incrementa el tamaño calculado en 4 bytes
        return this; // Retorna this
    }

    public Go2Buffer addUnsignInt(int number) { // Método para agregar un int sin signo al buffer
        buffer.putUnsignedInt(number); // Pone el int sin signo
        this.calculatedSize += 4; // Incrementa en 4
        return this; // Retorna this
    }

    public Go2Buffer addUnsignChar(int number) { // Método para agregar un char sin signo
        buffer.put(buffer.position(), (byte) number); // Pone el byte en la posición actual
        buffer.position(buffer.position() + 1); // Avanza la posición en 1
        this.calculatedSize++; // Incrementa tamaño
        return this; // Retorna this
    }

    public Go2Buffer addChar(char number) { // Método para agregar un char
        buffer.put(buffer.position(), (byte) number); // Pone el byte del char
        buffer.position(buffer.position() + 1); // Avanza posición
        this.calculatedSize++; // Incrementa
        return this; // Retorna
    }

    public Go2Buffer addChar(int number) { // Sobrecarga para agregar char desde int
        char c = (char) number; // Convierte int a char
        buffer.put(buffer.position(), (byte) c); // Pone el byte
        buffer.position(buffer.position() + 1); // Avanza
        this.calculatedSize++; // Incrementa
        return this; // Retorna
    }

    public Go2Buffer addShort(int number) { // Método para agregar un short
        // buffer.putShort((short) number); // Código comentado, probablemente por endianness
        int _loc3_ = buffer.position(); // Guarda la posición actual
        buffer.put(_loc3_, (byte) (number & 0x00FF)); // Pone el byte bajo
        buffer.put(_loc3_ + 1, (byte) (number >> 8)); // Pone el byte alto
        buffer.position(buffer.position() + 2); // Avanza posición en 2
        this.calculatedSize += 2; // Incrementa en 2
        return this; // Retorna
    }

    public Go2Buffer addLong(long number) { // Método para agregar un long
        this.buffer.putLong(number); // Pone el long
        this.calculatedSize += 8; // Incrementa en 8
        return this; // Retorna
    }

    public int getChar() { // Método para obtener un char (byte)
        return this.buffer.get(); // Obtiene un byte del buffer
    }

    public String getMultiByte(int length, String charSet) { // Método para obtener una cadena multibyte (comentado)

        /*final Charset cs = Charset.forName(charSet); // Código comentado para obtener charset
        int limit = buffer.limit(); // Guarda límite
        final IoBuffer strBuf = buffer; // Buffer para string
        strBuf.limit(strBuf.position() + length); // Establece límite temporal
        final String string = cs.decode(strBuf).toString(); // Decodifica
        buffer.limit(limit); // Restaura límite*/
        return "";// string; // Retorna cadena vacía
    }

    public Go2Buffer addWideChar(String str, int limit) { // Método para agregar una cadena wide char
        int _loc4_ = 0; // Índice
        while(_loc4_ < str.length() && _loc4_ < limit){ // Bucle mientras no exceda longitud o límite
            addShort(str.charAt(_loc4_)); // Agrega cada char como short
            _loc4_++; // Incrementa índice
        }
        this.pushByte((limit - str.length()) * 2); // Agrega padding de bytes cero
        return this; // Retorna
    }

    public Go2Buffer pushByte(int value) { // Método para agregar bytes cero (padding)
        if(value <= 0) { // Si valor <=0, retorna
            return this;
        }
        int _loc3_ = buffer.position(); // Posición actual
        int _loc4_ = 0; // Índice
        while(_loc4_ < value) { // Bucle para agregar bytes cero
            this.calculatedSize++; // Incrementa tamaño
            buffer.put(_loc3_ + _loc4_, (byte) 0); // Pone byte cero
            _loc4_++; // Incrementa
        }
        buffer.position(buffer.position() + value); // Avanza posición
        return this; // Retorna
    }

    public Go2Buffer addString(SmartString str) { // Método para agregar SmartString
        return addString(str.getValue(), str.getSize()); // Llama al otro addString
    }

    public Go2Buffer addString(String str, int limit) { // Método para agregar string con límite
        byte[] bytes = str.getBytes(); // Convierte string a bytes
        int length = bytes.length; // Longitud
        buffer.put(bytes); // Pone los bytes
        this.calculatedSize += bytes.length; // Incrementa tamaño
        if(length < limit) { // Si longitud < límite, agrega padding
            for(int i = length; i < limit; i++) {
                buffer.put((byte) 0); // Pone byte cero
                this.calculatedSize++; // Incrementa
            }
        }
        return this; // Retorna
    }

    public int getShort() { // Método para obtener un short
        return this.buffer.getShort(); // Obtiene short del buffer
    }

    public Go2Buffer addUnsignShort(int number) { // Método para agregar short sin signo
        int _loc3_ = buffer.position(); // Posición
        buffer.put(_loc3_, (byte) (number & 255)); // Byte bajo
        buffer.put(_loc3_ + 1, (byte) (number >> 8 & 255)); // Byte alto
        buffer.position(buffer.position() + 2); // Avanza
        this.calculatedSize += 2; // Incrementa
        return this; // Retorna
    }

    public int getUnsignShort() { // Método para obtener short sin signo
        int _loc2_ = buffer.get(); // Obtiene byte
        int _loc3_ = buffer.get(); // Obtiene siguiente byte
        if(_loc2_ < 0) { // Si negativo, ajusta
            _loc2_ = _loc2_ + 256;
        }
        if(_loc3_ < 0) { // Ajusta
            _loc3_ = _loc3_ + 256;
        }
        return (_loc3_ & 255) << 8 | _loc2_ & 255; // Combina bytes
    }

    public int getInt() { // Método para obtener un int
        // BotLogger.log("BUFFER"); // Log comentado
        return this.buffer.getInt(); // Obtiene int
    }

    public long getInt64() { // Método para obtener long (int64)
        return this.buffer.getLong(); // Obtiene long
    }

    public int getMsgSize() { // Método para obtener el tamaño del mensaje
        if(this.buffer.limit() <= 2) // Si límite <=2, retorna 0
            return 0;
        return getUnsignShort(); // Obtiene short sin signo
    }

    public int getMsgType() { // Método para obtener el tipo del mensaje
        if(this.buffer.limit() - this.buffer.position() < 2) // Si no hay espacio para 2 bytes, retorna 0
            return 0;
        return getUnsignShort(); // Obtiene short sin signo
    }

    public int getUnsignChar() { // Método para obtener char sin signo
        int _loc2_ = buffer.get(); // Obtiene byte
        if(_loc2_ < 0) { // Ajusta si negativo
            _loc2_ = _loc2_ + 256;
        }
        return _loc2_; // Retorna
    }

    public String getWideChar(int limit) { // Método para obtener cadena wide char
        int _loc3_ = 0; // Variable temporal
        String _loc4_ = ""; // Cadena resultante
        int _loc5_ = 0; // Índice
        while(_loc5_ < limit) { // Bucle hasta límite
            _loc3_ = this.getShort(); // Obtiene short
            if(_loc3_ == 0) // Si es cero, termina
            {
                break;
            }
            _loc4_ = _loc4_ + fromCharCode(_loc3_); // Agrega char
            _loc5_++; // Incrementa
        }
        _loc5_++; // Incrementa extra
        while(_loc5_ < limit) // Salta los restantes
        {
            this.getShort(); // Obtiene pero ignora
            _loc5_++; // Incrementa
        }
        return _loc4_; // Retorna cadena
    }

    public String getString(int limit) { // Método para obtener string
        boolean finish = false; // Bandera de fin
        byte[] bytes = new byte[limit]; // Array de bytes
        for(int i = 0; i < limit; i++) { // Bucle para obtener bytes
            byte get = buffer.get(); // Obtiene byte
            if(get == 0) { // Si es cero, marca fin
                // BotLogger.log(get); // Log comentado
                finish = true;
                continue; // Continúa
            }
            bytes[i] = get; // Asigna byte
        }
        // BufferUtil.printBytes(bytes); // Impresión comentada
        return new String(bytes, StandardCharsets.UTF_8); // Retorna string
    }

    public Go2Buffer callByte(int param2) { // Método alias para getByte
        return getByte(param2); // Llama a getByte
    }

    public Go2Buffer getByte(int param2) { // Método para saltar bytes
        int _loc3_ = 0; // Índice
        while(_loc3_ < param2) { // Bucle para saltar
            buffer.get(); // Obtiene pero ignora
            _loc3_++; // Incrementa
        }
        return this; // Retorna
    }

    public Go2Buffer debug() { // Método para debug, imprime bytes
        BufferUtil.printBytes(buffer.array()); // Imprime array de bytes
        return this; // Retorna
    }

    public static String fromCharCode(int... codePoints) { // Método estático para crear string desde code points
        return new String(codePoints, 0, codePoints.length); // Crea string
    }

} // Fin de la clase
