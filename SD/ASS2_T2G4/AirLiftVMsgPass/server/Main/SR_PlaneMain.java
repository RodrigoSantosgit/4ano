package server.Main;

import Common.RunParameters;
import client.stubs.DepartureStub;
import client.stubs.GeneralRepositoryStub;
import server.entities.CommunicationProvider;
import server.sharedregions.Plane.SR_Plane;
import Common.ServerCom;
import java.net.SocketTimeoutException;
import server.sharedregions.SR_PlaneProxy;

/**
 * Main class for the Plane Shared memory 
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_PlaneMain {
	
	/**
     * Main method
     * 
     * @param args
     */
	public static void main(String[] args) {
		
		/**
	     * Create communication utilities
	     */
		ServerCom serverCommunications, serverConnections;
		CommunicationProvider provider;
		/**
	     * Create stubs for cross comunication
	     */
	    GeneralRepositoryStub repository = new GeneralRepositoryStub();
		DepartureStub departureAirport = new DepartureStub();
	    
		/**
	     * Create main entity
	     */
	    SR_Plane plane = new SR_Plane(repository, departureAirport);
		
		/**
	     * Create main entity proxy
	     */
		SR_PlaneProxy planeProxy = new SR_PlaneProxy(plane);
		
		/**
	     * Start comms
	     */
	    serverCommunications = new ServerCom(RunParameters.PlanePort);
	    serverCommunications.start();
		
		System.out.println("Plane started");
        
        while (!planeProxy.hasSimEnded()) {
            try {
                serverConnections = serverCommunications.accept();
                System.out.println(serverConnections.toString());
                provider = new CommunicationProvider(planeProxy, serverConnections);
                provider.start();
            } catch (NullPointerException e) {
                // System.err.println("Nothing Connected");
            } catch (RuntimeException e) {
                System.err.println("Error on proxy");
                e.printStackTrace();
            }catch (SocketTimeoutException e) {}
        }
        serverCommunications.end();
        
        repository.closeStub();
        System.out.println("[PLANE] terminating...");
		
	}

}
