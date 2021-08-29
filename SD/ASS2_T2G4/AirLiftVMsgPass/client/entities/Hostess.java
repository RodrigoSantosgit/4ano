package client.entities;

import Common.States;
import client.stubs.DepartureStub;
import client.stubs.DestinationStub;

/**
 * Hostess entity data-type
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class Hostess extends Thread{
    
    /**
	 * Departure Airport Stub entity
	*/
    private final DepartureStub iDepartureAirport;
    
    /**
	 * Departure Airport Stub entity
	*/
    private final DestinationStub iDestAirport;
    
    /**
	 * Hostess current state
	*/
    private States currentState;

    /**
     * Hostess constructor method
     * @param idep
     * @param iDestAirport
     */
    public Hostess(DepartureStub idep, DestinationStub iDestAirport) {
            this.iDepartureAirport = idep;
            this.iDestAirport = iDestAirport;
            this.currentState = States.WAIT_FOR_FLIGHT;
            
    }

    /**
	 * Sets hostess current state to the pretended state
	 * @param hostessState
	*/
    public void setHostessState(States hostessState) {
            this.currentState=hostessState;
    }
    
    /**
     * Getter for the hostess current State
     * @return Hostess current State
     */
    public States getHostessState() {
            return this.currentState;
    }

    /**
	 * Hostess life-cycle
	*/
    @Override
    public void run() {

        while(iDestAirport.getPTAL() != 21) {

            if (this.currentState == States.WAIT_FOR_FLIGHT) {
                System.out.println("before prepareForPassBoarding");
                this.iDepartureAirport.prepareForPassBoarding();
            }

            if (this.currentState== States.WAIT_FOR_PASSENGER) {
            	while(!canTakeOff() ){
                    System.out.println("before checkDocuments");
                    this.iDepartureAirport.checkDocuments();
                    System.out.println("before waitForNextPassenger");
                    this.iDepartureAirport.waitForNextPassenger();
                }
                System.out.println("before informPlaneReadyToTakeOff");
                this.iDepartureAirport.informPlaneReadyToTakeOff();        
            }

            if (this.currentState== States.READY_TO_FLY) {
                System.out.println("before waitForNextFlight");
                this.iDepartureAirport.waitForNextFlight();
            }

        } 
        
        System.out.printf("[HOSTESS] ---> finished simulation\n");

    }
    
    /**
     * Checks if flight can take off
     * @return
     */
    private boolean canTakeOff() {
    	return iDepartureAirport.isCanTakeOff();
    }

}
