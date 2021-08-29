package server.sharedregions.Plane;

import Common.States;
import client.entities.Pilot;
import client.stubs.DepartureStub;
import client.stubs.GeneralRepositoryStub;
import server.entities.CommunicationProvider;

import java.util.Random;

/**
 * Shared Region Plane
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
*/
public class SR_Plane {
	
	/* Instantiate */
	
	/**
	 * Logger repository
	*/
	private GeneralRepositoryStub generalRepository;
	
	/**
	 * Plane arrived destination flag
	*/
	private boolean arrived;
	
	/**
	 * Plane is empty flag
	*/
	private boolean planeEmpty;
        
	/**
	 * DepartureStub for communication
	 */
	private DepartureStub dep;
	
	/**
     * Sequential number of current flight in simulation
     */
    private int flight;
	
	/**
	 * SR_Plane constructor method
	 * @param generalRepository
	 * @param dep
	*/
    public SR_Plane(GeneralRepositoryStub generalRepository, DepartureStub dep) {
    	this.generalRepository = generalRepository;
    	this.arrived = false;
    	this.planeEmpty = false;
    	this.flight = 0;
        this.dep = dep;
    }
	
    /* Methods */
    
    /**
	 * Pilot method to fly to destination airport 
	 * Puts Pilot in FLYING_FORWARD state. 
	 * Pilot is put to sleep for random time interval
	 */
    
    public synchronized void flyToDestinationPoint(){
    	CommunicationProvider pilot = (CommunicationProvider) Thread.currentThread();
    	pilot.setEntityState(States.FLYING_FORWARD);
    	generalRepository.updatePilotState(States.FLYING_FORWARD, false, this.flight +1 );
    	System.out.print("[PILOT] -> FLYING TO DESTINATION AIRPORT!\n");
        Random ran = new Random();
    	try {
    		Pilot.sleep(ran.nextInt(150));
    	} catch (InterruptedException e) {
    		e.printStackTrace();
    	}
       
    }
     
    /**
	 * Pilot method to announce the arrival at the destination airport 
	 * Puts Pilot in DEBOARDING state. 
	 * Pilot waits until all passengers have left the plane
	 */
    
    public synchronized void announceArrival() {
    	CommunicationProvider pilot = (CommunicationProvider) Thread.currentThread();
	    pilot.setEntityState(States.DEBOARDING);
	    generalRepository.updatePilotState(States.DEBOARDING, false, this.flight +1 );
	    setArrived(true);
	    notifyAll();
	    System.out.print("[PILOT] -> FLIGHT IS OVER, WE HAVE ARRIVED!\n");
	    
	    while(dep.getInFlight()> 0) {
                
	    	try {
	    		wait();
	    	}
	    	catch(InterruptedException e){}
	    }
	    setArrived(false);
	    planeEmpty=false;
	    
	}
    
    /**
	 * Pilot method to fly back to the departure airport  
	 * Puts Pilot in FLYING_BACK state. 
	 * Pilot is put to sleep for a random time interval
	 */
    
   	public synchronized void flyToDeparturePoint(){
   		CommunicationProvider pilot = (CommunicationProvider) Thread.currentThread();
       	pilot.setEntityState(States.FLYING_BACK);
       	generalRepository.updatePilotState(States.FLYING_BACK, false, this.flight +1 );
       	System.out.print("[PILOT] -> FLYING TO DEPARTURE AIRPORT!\n");
       	
        Random ran = new Random();
    	try {
    		Pilot.sleep(ran.nextInt(150));
    	} catch (InterruptedException e) {
    		e.printStackTrace();
    	
   	}
        }
    /**
	 * Passenger method to wait for the flight to end 
	 * Puts Passenger in IN_FLIGHT state.
	 */
    
    public synchronized void waitForEndOfFlight(){
    	CommunicationProvider passenger = (CommunicationProvider) Thread.currentThread();
        passenger.setEntityState(States.IN_FLIGHT);
        generalRepository.updatePassengerState(States.IN_FLIGHT, passenger.getEntityID(), false);
        System.out.printf("[Passenger] -> Waiting for end of flight!\n");
       
        while(!arrived )
        {
        	try {
        		wait();
        	}
        	catch (InterruptedException e) {}
        }           
    }
 
    /**
     * arrived flag getter
     * @return boolean arrived flag
     */
    public boolean isArrived() {
    	return arrived;
	}

    /**
     * arrived flag setter
     * @param arrived
     */
	public synchronized void setArrived(boolean arrived) {
		this.arrived = arrived;
	}
    
	/**
	 * planeEmpty flag setter
	 * @param set
	 */
    public synchronized void setPlaneEmpty(boolean set){
        System.out.println("----Setting plane empty ");
    	planeEmpty=set;
        notifyAll();
    }
    
    /**
     * planeEmpty flag getter
     * @return planeEmpty flag
     */
    public boolean getPlaneEmpty(){
    	return planeEmpty;
    }

}
