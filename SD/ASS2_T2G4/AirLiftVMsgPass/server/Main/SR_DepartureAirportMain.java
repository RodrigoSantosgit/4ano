package server.Main;

import server.sharedregions.DepartureAirport.SRDepartureAirport;
import Common.RunParameters;
import client.stubs.GeneralRepositoryStub;
import server.entities.CommunicationProvider;
import Common.ServerCom;
import java.net.SocketTimeoutException;
import server.sharedregions.SR_DepartureAiportProxy;

/**
 * Main class for the Departure Airport Shared memory
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_DepartureAirportMain {
	
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
	    
		/**
	     * Create main entity
	     */
	    SRDepartureAirport departureAirport = new SRDepartureAirport(10, 5, repository, 21);
		
		/**
	     * Create main entity proxy
	     */
		SR_DepartureAiportProxy depAirpProxy = new SR_DepartureAiportProxy(departureAirport);
		
		/**
	     * Start comunications
	     */
	    serverCommunications = new ServerCom(RunParameters.DeparturePort);
	    serverCommunications.start();
		
		System.out.println("DepartureAirport started");
        
        while (!depAirpProxy.hasSimEnded()) {
            try {
                serverConnections = serverCommunications.accept();
                provider = new CommunicationProvider(depAirpProxy, serverConnections);
                provider.start();
            } catch (NullPointerException e) {
                // System.err.println("Nothing Connected");
            } catch (RuntimeException e) {
                System.err.println("Error on proxy");
                e.printStackTrace();
            }catch (SocketTimeoutException e) {}
            
        }
        
        serverCommunications.end();
        repository.finish(departureAirport.getFlights());
        repository.closeStub();
        repository.closeStub();
        System.out.println("[DEP_AIRPORT] terminating...");
		
	}	
	
}