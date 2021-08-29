
package ActiveEntity;

import ActiveEntity.States.PassengerState;
import DepartureAirport.IDepartureAirport_Passenger;
import DestinationAirport.IDestAirport_Passenger;
import Plane.IPlane_Passenger;
import java.util.Random;

/**
 * Passenger entity data-type
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class Passenger extends Thread{
	
	/**
	 * IDestAirport_Passenger entity
	*/
	private final IDestAirport_Passenger iDestAirport;
	
	/**
	 * IDepartureAirport_Passenger entity
	*/
	private final IDepartureAirport_Passenger iDepartureAirport;
	
	/**
	 * IPlane_Passenger entity
	*/
	private final IPlane_Passenger iPlane;
	
	/**
	 * Passenger current state
	*/
	private PassengerState currentState;
	
	/**
	 * Passenger id
	*/
	private int id;
	
  
  	/**
	 * Passenger constructor method
	 * @param iplane_passenger
	 * @param idestairport_passenger
	 * @param idepairport_passenger
	 * @param id
	*/
	public Passenger(IPlane_Passenger iplane_passenger, IDestAirport_Passenger idestairport_passenger, IDepartureAirport_Passenger idepairport_passenger, int id) {
		this.iDestAirport = idestairport_passenger;
		this.iPlane = iplane_passenger;
		this.iDepartureAirport = idepairport_passenger;
		this.currentState = PassengerState.GOING_T0_AIRPORT;
		this.id = id;
	}
	
	/**
	 * Getter for the Passenger current state
	 * @return
	 */
	public PassengerState getCurrentState() {
		return this.currentState;
	}
	
	/**
	 * Sets passenger current state to the pretended state
	 * @param passengerState
	*/
	public void setPassengerState(PassengerState passengerState) {
		this.currentState=passengerState;
	}
	
	/**
	 * Passenger life-cycle
	*/
	@Override
	public void run() {

		int travelTime = randomTravelTime();
		
		this.iDepartureAirport.travelToAirport(travelTime);
		
		this.iDepartureAirport.waitInQueue();
		
		this.iDepartureAirport.showDocuments();
		
		this.iDepartureAirport.boardThePlane();
		
		this.iPlane.waitForEndOfFlight();
		
		this.iDestAirport.leaveThePlane();
                
        System.out.printf("[Passenger] ---> end of life cycle\n");
		
	}
	
	/**
	 * Returns a random integer value used to simulate travel time
	*/
	private int randomTravelTime() {
        Random ran = new Random();
		return ran.nextInt(500)+ 100;
	}
  
	/**
	 * Returns the passenger ID
	*/
    public int getID(){
    	return this.id;
    }
	
}