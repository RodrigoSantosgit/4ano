package server.Main;

import server.sharedregions.DestinationAirport.SR_DestAirport;
import Common.RunParameters;
import client.stubs.DepartureStub;
import client.stubs.GeneralRepositoryStub;
import client.stubs.PlaneStub;
import server.entities.CommunicationProvider;
import Common.ServerCom;
import java.net.SocketTimeoutException;
import server.sharedregions.SR_DestinationAirportProxy;

/**
 * Main class for the Destination Airport Shared memory 
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_DestinationAirportMain {

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
                PlaneStub plane = new PlaneStub();
	    
		/**
	     * Create main entity
	     */
	    SR_DestAirport destAirport = new SR_DestAirport(repository, departureAirport, plane);
		
		/**
	     * Create main entity proxy
	     */
		SR_DestinationAirportProxy destAirpProxy = new SR_DestinationAirportProxy(destAirport);
		
		/**
	     * Start comms
	     */
	    serverCommunications = new ServerCom(RunParameters.DestinationPort);
	    serverCommunications.start();
		
		System.out.println("DestinationAirport started");
        
        while (!destAirpProxy.hasSimEnded()) {
            try {
                
                serverConnections = serverCommunications.accept();
                System.out.println(serverConnections.toString());
                provider = new CommunicationProvider(destAirpProxy, serverConnections);
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
        System.out.println("[DEST_AIRPORT] terminating...");
		
	}
	
}
