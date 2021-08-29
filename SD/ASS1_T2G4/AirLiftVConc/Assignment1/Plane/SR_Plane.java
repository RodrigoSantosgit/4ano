package Plane;

import ActiveEntity.Passenger;
import ActiveEntity.Pilot;
import ActiveEntity.States.PassengerState;
import ActiveEntity.States.PilotState;
import Repository.GeneralRepository;
import java.util.Random;

/**
 * Shared Region Plane
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
*/
public class SR_Plane implements IPlane_Hostess, IPlane_Passenger, IPlane_Pilot{
	
	/* Instantiate */
	
	/**
	 * Logger repository
	*/
	private GeneralRepository generalRepository;
	
	/**
	 * Plane arrived destination flag
	*/
	private boolean arrived;
	
	/**
	 * Plane is empty flag
	*/
	private boolean planeEmpty;
	
	/**
	 * SR_Plane constructor method
	 * @param generalRepository
	*/
    public SR_Plane(GeneralRepository generalRepository) {
    	this.generalRepository = generalRepository;
    	this.arrived = false;
    	this.planeEmpty = false;
    }
	
    /* Methods */
    
    /**
	 * Pilot method to fly to destination airport </p>
	 * Puts Pilot in {@link Assignment1.ActiveEntity.States.PilotState#FLYING_FORWARD} state. </p>
	 * Pilot is put to sleep for random time interval
	 */
    @Override
    public synchronized void flyToDestinationPoint(){
    	Pilot pilot = (Pilot) Thread.currentThread();
    	pilot.setPilotState(PilotState.FLYING_FORWARD);
    	generalRepository.updatePilotState(PilotState.FLYING_FORWARD, false);
    	System.out.print("[PILOT] -> FLYING TO DESTINATION AIRPORT!\n");
        Random ran = new Random();
    	try {
    		Pilot.sleep(ran.nextInt(150));
    	} catch (InterruptedException e) {
    		e.printStackTrace();
    	}
       
    }
     
    /**
	 * Pilot method to announce the arrival at the destination airport </p>
	 * Puts Pilot in {@link Assignment1.ActiveEntity.States.PilotState#DEBOARDING} state. </p>
	 * Pilot waits until all passengers have left the plane
	 */
    @Override
    public synchronized void announceArrival() {
		Pilot pilot = (Pilot) Thread.currentThread();
	    pilot.setPilotState(PilotState.DEBOARDING);
	    generalRepository.updatePilotState(PilotState.DEBOARDING, false);
	    setArrived(true);
	    notifyAll();
	    System.out.print("[PILOT] -> FLIGHT IS OVER, WE HAVE ARRIVED!\n");
	    
	    while(generalRepository.getInFlight()> 0) {
	    	try {
	    		wait();
	    	}
	    	catch(InterruptedException e){}
	    }
	    setArrived(false);
	    planeEmpty=false;
	    
	}
    
    /**
	 * Pilot method to fly back to the departure airport  </p>
	 * Puts Pilot in {@link Assignment1.ActiveEntity.States.PilotState#FLYING_BACK} state. </p>
	 * Pilot is put to sleep for a random time interval
	 */
    @Override
   	public synchronized void flyToDeparturePoint(){
       	Pilot pilot = (Pilot) Thread.currentThread();
       	pilot.setPilotState(PilotState.FLYING_BACK);
       	generalRepository.updatePilotState(PilotState.FLYING_BACK, false);
       	System.out.print("[PILOT] -> FLYING TO DEPARTURE AIRPORT!\n");
       	
        Random ran = new Random();
    	try {
    		Pilot.sleep(ran.nextInt(150));
    	} catch (InterruptedException e) {
    		e.printStackTrace();
    	
   	}
        }
    /**
	 * Passenger method to wait for the flight to end </p>
	 * Puts Passenger in {@link Assignment1.ActiveEntity.States.PassengerState#IN_FLIGHT} state. </p>
	 */
    @Override
    public synchronized void waitForEndOfFlight(){
        Passenger passenger = (Passenger) Thread.currentThread();
        passenger.setPassengerState(PassengerState.IN_FLIGHT);
        generalRepository.updatePassengerState(PassengerState.IN_FLIGHT, passenger.getID(), false);
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
