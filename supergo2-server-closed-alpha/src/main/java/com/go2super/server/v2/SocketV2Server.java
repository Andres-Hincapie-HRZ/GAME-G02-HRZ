package com.go2super.server.v2;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.SneakyThrows;

public class SocketV2Server {

    public static void main(String...args) {
        SocketV2Server server = new SocketV2Server();
        server.start();
    }

    @SneakyThrows
    public void start() {

        Configuration config = new Configuration();
        config.setHostname("localhost");
        config.setPort(9092);

        final SocketIOServer server = new SocketIOServer(config);
        server.addEventListener("chatevent", Object.class, new DataListener<Object>() {
            @Override
            public void onData(SocketIOClient client, Object data, AckRequest ackRequest) {
                // broadcast messages to all clients
                System.out.println("DATA: " + data);
                server.getBroadcastOperations().sendEvent("chatevent", data);

            }
        });

        server.start();
        Thread.sleep(Integer.MAX_VALUE);
        server.stop();

    }

}
