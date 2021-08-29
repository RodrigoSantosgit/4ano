package server.Main;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import Common.RunParameters;
import server.entities.CommunicationProvider;
import server.sharedregions.Repository.GeneralRepository;
import Common.ServerCom;
import server.sharedregions.GeneralRepositoryProxy;

/**
 * Repository server launcher
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class GeneralRepositoryMain {

    /**
     * Repository main
     * 
     * @param args
     */
    public static void main(String[] args) {

        ServerCom serverCom, serverConn;
        CommunicationProvider provider;
        String logFile = RunParameters.logFile;

        // check if file exists, if not create
        Path path = Paths.get(logFile);
        if (Files.notExists(path)) {
            logFile = "logs.txt";
        }

        // create repository
        GeneralRepository repository = new GeneralRepository();
        GeneralRepositoryProxy repositoryProxy = new GeneralRepositoryProxy(repository);

        // start the repository server
        serverCom = new ServerCom(RunParameters.GeneralRepositoryPort);
        serverCom.start();

        System.out.println("Repository started, timeout set to 10 seconds");
        while (!repositoryProxy.hasSimEnded()) {
            try {
                
                serverConn = serverCom.accept();
                provider = new CommunicationProvider(repositoryProxy, serverConn);
                provider.start();
            } catch (NullPointerException e) {
                System.err.println("Nothing Connected");
            } catch (Exception e) {
                System.err.printf("%s [REPOSITORYMAIN] unknown error\n", Thread.currentThread().getName());
                e.printStackTrace();
            }
        }
        serverCom.end();

        System.out.println("[GENERAL REPOSITORY] terminating...");
    }
}