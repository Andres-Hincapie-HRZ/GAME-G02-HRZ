fuser -k 9090/tcp
java -Xms92G -Xmx92G --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED -jar supergo2-server.jar