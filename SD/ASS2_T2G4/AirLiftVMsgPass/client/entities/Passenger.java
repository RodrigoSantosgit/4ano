package client.entities;

import Common.Message;
import Common.States;

import client.stubs.DepartureStub;
import client.stubs.DestinationStub;
import client.stubs.PlaneStub;
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
	private final DestinationStub iDestAirport;
	
	/**
	 * IDepartureAirport_Passenger entity
	*/
	private final DepartureStub iDepartureAirport;
	
	/**
	 * IPlane_Passenger entity
	*/
	private final PlaneStub iPlane;
	
	/**
	 * Passenger current state
	*/
	private States currentState;
	
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
	public Passenger(PlaneStub iplane_passenger, DestinationStub idestairport_passenger, DepartureStub idepairport_passenger, int id) {
		this.iDestAirport = idestairport_passenger;
		this.iPlane = iplane_passenger;
		this.iDepartureAirport = idepairport_passenger;
		this.currentState = States.GOING_T0_AIRPORT;
		this.id = id;
	}
	
	/**
	 * Getter for the Passenger current state
	 * @return Passenger current State
	 */
	public States getCurrentState() {
		return this.currentState;
	}
        
	
	/**
	 * Sets passenger current state to the pretended state
	 * @param passengerState
	*/
	public void setPassengerState(States passengerState) {
		this.currentState=passengerState;
	}
	
	/**
	 * Passenger life-cycle
	*/
	@Override
	public void run() {

		int travelTime = randomTravelTime();
		System.out.println("before travelToAirport");
		this.iDepartureAirport.travelToAirport(travelTime);
		System.out.println("before waitInQueue");
		this.iDepartureAirport.waitInQueue();
		System.out.println("before showDocuments");
		this.iDepartureAirport.showDocuments();
		System.out.println("before boardThePlane");
		this.iDepartureAirport.boardThePlane();
		System.out.println("before waitForEndOfFlight");
		this.iPlane.waitForEndOfFlight();
		System.out.println("before leaveThePlane");
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