package Main;

import ActiveEntity.Hostess;
import ActiveEntity.Passenger;
import ActiveEntity.Pilot;
import DepartureAirport.SRDepartureAirport;
import DestinationAirport.SR_DestAirport;
import Plane.SR_Plane;
import Repository.GeneralRepository;
import java.util.Random;

/**
 * AirLift Main class 
 * <p/>
 * Main function launches all threads
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class AirLift {
	
	/**
	 * Minimum number of passengers required to take off per flight
	 */
	private static int MIN_PASSENGER;
	
	/**
	 * Maximum number of passengers allowed to take off per flight
	 */
	private static int MAX_PASSENGER;
	
	/**
	 * Total number of passengers
	 */
	private static int TOTAL_PASSENGERS;
	
	// Shared Regions and Active Entities
	
	/**
	 * SR_Plane entity
	*/
	private static SR_Plane sr_plane;
	
	/**
	 * SRDepartureAirport entity
	*/
	private static SRDepartureAirport sr_dep;
	
	/**
	 * SR_DestAirport entity
	*/
	private static SR_DestAirport sr_dest;
	
	/**
	 * Logger repository
	*/
	private static GeneralRepository generalRepository;
	
	/**
	 * Hostess entity
	*/
	private static Hostess hostess;
	
	/**
	 * Pilot entity
	*/
	private static Pilot pilot;
	
	/**
	 * Passenger entities
	*/
	private static Passenger[] passengers;
	
	/**
	 * Main method
	 * 
	 * @param args runtime arguments
	 * @throws InterruptedException
	 */
	public static void main ( String args[] ) throws InterruptedException {
		
		MAX_PASSENGER = 10;
		MIN_PASSENGER = 5;
		TOTAL_PASSENGERS = 21;
		
		generalRepository = new GeneralRepository();
                
		sr_plane = new SR_Plane(generalRepository);
		sr_dest = new SR_DestAirport(generalRepository, sr_plane, sr_dep);
		sr_dep = new SRDepartureAirport(MAX_PASSENGER, MIN_PASSENGER, generalRepository, TOTAL_PASSENGERS, sr_plane);
		
		
		hostess = new Hostess(sr_dep, generalRepository);
		pilot = new Pilot(sr_dep, sr_plane, generalRepository);
		passengers = new Passenger[TOTAL_PASSENGERS];
		
        int ids = 1;
		for (int i=0; i< TOTAL_PASSENGERS; i++) {
			passengers[i] = new Passenger(sr_plane, sr_dest, sr_dep, ids);
            ids++;
		}
		
	    /* THREADS START */
	    hostess.start();
	    pilot.start();
        Random ran = new Random();
	    for (int i=0; i< TOTAL_PASSENGERS; i++) {
			passengers[i].start();
            int time = ran.nextInt(500) + 250;
			passengers[i].sleep(time);
		}
	    
	    /* THREADS JOIN */
	    try{
	    	hostess.join();
	    } catch (InterruptedException e) {
	    	System.err.println("Something happened with a Hostess thread");
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    
	    try{
	    	pilot.join();
	    } catch (InterruptedException e) {
	    	System.err.println("Something happened with a Pilot thread");
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    
	    for (Passenger p: passengers) {
	        try {
	             p.join();
	        } catch (InterruptedException e) {
	             System.err.println("Something happened with a Passenger thread");
	        } catch (Exception e) {
	             e.printStackTrace();
	        }
	    }
	    
	    // Finish Logger instance and exit the program cleanly
	    generalRepository.finish();
	    System.exit(0);
        
	}
    
}