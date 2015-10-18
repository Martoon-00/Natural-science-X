package ru.ifmo.server;


import com.sun.jersey.api.container.grizzly2.GrizzlyServerFactory;
import com.sun.jersey.api.core.PackagesResourceConfig;
import com.sun.jersey.api.core.ResourceConfig;
import org.glassfish.grizzly.http.server.HttpServer;

import javax.ws.rs.core.UriBuilder;
import java.io.IOException;
import java.net.URI;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Server {

    public final URI BASE_URI;

    public static void main(String[] args) throws IOException {
        if (args.length == 0) {
            System.out.println("Missing first argument (port)");
            return;
        }
        int port = Integer.parseInt(args[0]);

        Logger.getLogger("").setLevel(Level.OFF);

        final Server server = new Server(port);
        HttpServer httpServer = server.startServer();
        System.out.println(String.format("Server launched at %s", server.BASE_URI));

        System.in.read();
        httpServer.stop();
    }

    public Server(int port) {
        BASE_URI = UriBuilder.fromUri("http://localhost/").port(port).build();
    }

    protected HttpServer startServer() throws IOException {
        ResourceConfig rc = new PackagesResourceConfig("ru.ifmo.server.resource");
        return GrizzlyServerFactory.createHttpServer(BASE_URI, rc);
    }

}