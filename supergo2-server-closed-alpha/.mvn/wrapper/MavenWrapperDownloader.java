/*
 * Copyright 2007-present the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import java.net.*;  // Importa clases para manejo de URLs y conexiones de red
import java.io.*;  // Importa clases para entrada/salida de archivos
import java.nio.channels.*;  // Importa clases para canales de E/S no bloqueantes
import java.util.Properties;  // Importa clase para manejar propiedades de configuración

public class MavenWrapperDownloader {  // Clase principal que descarga el wrapper de Maven

    private static final String WRAPPER_VERSION = "0.5.6";  // Versión del wrapper de Maven
    /**
     * URL por defecto para descargar el maven-wrapper.jar, si no se proporciona 'downloadUrl'.
     */
    private static final String DEFAULT_DOWNLOAD_URL = "https://repo.maven.apache.org/maven2/io/takari/maven-wrapper/"
        + WRAPPER_VERSION + "/maven-wrapper-" + WRAPPER_VERSION + ".jar";  // Construye la URL completa con la versión

    /**
     * Ruta al archivo maven-wrapper.properties, que podría contener una propiedad downloadUrl para
     * usar en lugar de la URL por defecto.
     */
    private static final String MAVEN_WRAPPER_PROPERTIES_PATH =
            ".mvn/wrapper/maven-wrapper.properties";  // Ruta relativa al archivo de propiedades

    /**
     * Ruta donde se guardará el maven-wrapper.jar.
     */
    private static final String MAVEN_WRAPPER_JAR_PATH =
            ".mvn/wrapper/maven-wrapper.jar";  // Ruta relativa donde se guarda el JAR descargado

    /**
     * Nombre de la propiedad que se debe usar para anular la URL de descarga por defecto del wrapper.
     */
    private static final String PROPERTY_NAME_WRAPPER_URL = "wrapperUrl";  // Nombre de la propiedad para URL personalizada

    public static void main(String args[]) {  // Método principal que inicia la descarga
        BotLogger.log("- Downloader started");  // Registra que el descargador ha iniciado
        File baseDirectory = new File(args[0]);  // Crea un objeto File para el directorio base pasado como argumento
        BotLogger.log("- Using base directory: " + baseDirectory.getAbsolutePath());  // Registra el directorio base usado

        // Si el archivo maven-wrapper.properties existe, lo lee y verifica si contiene un parámetro
        // wrapperUrl personalizado.
        File mavenWrapperPropertyFile = new File(baseDirectory, MAVEN_WRAPPER_PROPERTIES_PATH);  // Archivo de propiedades
        String url = DEFAULT_DOWNLOAD_URL;  // Inicializa la URL con la por defecto
        if(mavenWrapperPropertyFile.exists()) {  // Si el archivo de propiedades existe
            FileInputStream mavenWrapperPropertyFileInputStream = null;  // Flujo de entrada para el archivo
            try {
                mavenWrapperPropertyFileInputStream = new FileInputStream(mavenWrapperPropertyFile);  // Abre el archivo
                Properties mavenWrapperProperties = new Properties();  // Crea objeto Properties
                mavenWrapperProperties.load(mavenWrapperPropertyFileInputStream);  // Carga las propiedades del archivo
                url = mavenWrapperProperties.getProperty(PROPERTY_NAME_WRAPPER_URL, url);  // Obtiene la URL personalizada o usa la por defecto
            } catch (IOException e) {
                BotLogger.log("- ERROR loading '" + MAVEN_WRAPPER_PROPERTIES_PATH + "'");  // Registra error al cargar el archivo
            } finally {
                try {
                    if(mavenWrapperPropertyFileInputStream != null) {
                        mavenWrapperPropertyFileInputStream.close();  // Cierra el flujo de entrada
                    }
                } catch (IOException e) {
                    // Ignore ...  // Ignora errores al cerrar
                }
            }
        }
        BotLogger.log("- Downloading from: " + url);  // Registra la URL desde la que se descarga

        File outputFile = new File(baseDirectory.getAbsolutePath(), MAVEN_WRAPPER_JAR_PATH);  // Archivo de salida para el JAR
        if(!outputFile.getParentFile().exists()) {  // Si el directorio padre no existe
            if(!outputFile.getParentFile().mkdirs()) {  // Intenta crear los directorios
                BotLogger.log(
                        "- ERROR creating output directory '" + outputFile.getParentFile().getAbsolutePath() + "'");  // Registra error al crear directorio
            }
        }
        BotLogger.log("- Downloading to: " + outputFile.getAbsolutePath());  // Registra la ruta de destino
        try {
            downloadFileFromURL(url, outputFile);  // Descarga el archivo desde la URL
            BotLogger.log("Done");  // Registra que la descarga terminó
            System.exit(0);  // Sale con código 0 (éxito)
        } catch (Throwable e) {
            BotLogger.log("- Error downloading");  // Registra error en la descarga
            e.printStackTrace();  // Imprime el stack trace del error
            System.exit(1);  // Sale con código 1 (error)
        }
    }

    private static void downloadFileFromURL(String urlString, File destination) throws Exception {  // Método para descargar archivo desde URL
        if (System.getenv("MVNW_USERNAME") != null && System.getenv("MVNW_PASSWORD") != null) {  // Si hay variables de entorno para usuario y contraseña
            String username = System.getenv("MVNW_USERNAME");  // Obtiene el nombre de usuario
            char[] password = System.getenv("MVNW_PASSWORD").toCharArray();  // Obtiene la contraseña como arreglo de caracteres
            Authenticator.setDefault(new Authenticator() {  // Establece el autenticador por defecto
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);  // Retorna la autenticación con usuario y contraseña
                }
            });
        }
        URL website = new URL(urlString);  // Crea objeto URL con la cadena proporcionada
        ReadableByteChannel rbc;  // Canal de lectura de bytes
        rbc = Channels.newChannel(website.openStream());  // Abre un canal de lectura desde el stream de la URL
        FileOutputStream fos = new FileOutputStream(destination);  // Flujo de salida para escribir en el archivo destino
        fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);  // Transfiere datos desde el canal de lectura al canal de escritura
        fos.close();  // Cierra el flujo de salida
        rbc.close();  // Cierra el canal de lectura
    }

}
