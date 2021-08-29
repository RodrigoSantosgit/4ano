package client.entities;

import Common.Message;
import Common.States;

import client.stubs.DepartureStub;
import client.stubs.DestinationStub;
import client.stubs.PlaneStub;

/**
 * Pilot entity data-type
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
*/
public class Pilot extends Thread{
	
	/**
	 * IDepartureAirport_Pilot entity
	*/
	private final DepartureStub iDepartureAirport;
	
    /**
	 * IDestinationAirport_Pilot entity
	*/
	private final DestinationStub iDestinationAirport;
	
        
	/**
	 * IPlane_Pilot entity
	*/
	private final PlaneStub iPlane;
	
	
	/** 
	 * Pilot current state
	*/
    private States currentState;
	
    /**
     * Pilot constructor method
     * @param idep
     * @param ip
     * @param destination
    */
	public Pilot(DepartureStub idep, PlaneStub ip, DestinationStub destination) {
     
            this.iPlane = ip;
            this.iDepartureAirport = idep;
            this.currentState = States.AT_TRANSFER_GATE;
            this.iDestinationAirport = destination;

	}
    
	/**
	 * Sets pilot current state to the pretended state
	 * @param pilotState
	*/
	public void setPilotState(States pilotState) {
		this.currentState=pilotState;
	}
    
	/**
	 * Getter for the Pilot State
	 * @return Pilot current State
	 */
	public States getPilotState() {
            return this.currentState;
	}
        
    /**
    * Pilot life-cycle
    */
	@Override
	public void run() {
            
        while(iDestinationAirport.getPTAL() != 21) { 
            
            if (currentState == States.AT_TRANSFER_GATE){
                
                System.out.println("before informPlaneReadyForBoarding");
                iDepartureAirport.informPlaneReadyForBoarding();
                System.out.println("before waitForAllInBoard");
                iDepartureAirport.waitForAllInBoard();
                System.out.println("before flyToDestinationPoint");
                iPlane.flyToDestinationPoint();
                System.out.println("before announceArrival");
                iPlane.announceArrival();
                System.out.println("before flyToDeparturePoint");
                iPlane.flyToDeparturePoint();
                System.out.println("before parkAtTransferGate");
                iDepartureAirport.parkAtTransferGate();
                
            }
                
        }
        System.out.printf("[PILOT] ---> FINISHED SIMULATION \n");
	}
	
}
