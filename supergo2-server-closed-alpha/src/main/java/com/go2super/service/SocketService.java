package com.go2super.service;

import com.go2super.server.GameLogin;
import com.go2super.server.GameServer;
import org.springframework.stereotype.Service;

@Service
public class SocketService {

    private static SocketService instance;

    private Thread loginThread;
    private Thread gameThread;

    public SocketService() {
        instance = this;
    }

    public void setup() {

        GameLogin login = new GameLogin(5050);
        GameServer game = new GameServer(90);

        loginThread = new Thread(login);
        gameThread = new Thread(game);

        loginThread.setName("game-login-thread");
        gameThread.setName("game-server-thread");

        loginThread.start();
        gameThread.start();

    }

    public Thread getLoginThread() {
        return loginThread;
    }

    public Thread getGameThread() {
        return gameThread;
    }

    public static SocketService getInstance() {
        return instance;
    }

}
