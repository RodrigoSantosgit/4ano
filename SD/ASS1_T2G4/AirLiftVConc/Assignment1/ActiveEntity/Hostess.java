package ActiveEntity;

import ActiveEntity.States.HostessState;
import DepartureAirport.IDepartureAirport_Hostess;
import Repository.GeneralRepository;

/**
 * Hostess entity data-type
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class Hostess extends Thread{
    
    /**
	 * IDepartureAirport_Hostess entity
	*/
    private final IDepartureAirport_Hostess iDepartureAirport;
    
    /**
	 * GeneralRepository entity
	*/
    private final GeneralRepository generalRepository;
    
    /**
	 * Hostess current state
	*/
    private HostessState currentState;

    /**
     * Hostess constructor method
     * @param ip
     * @param idest
     * @param idep
     * @param generalRepository
     * @param SRDepartureAirport
     */
    public Hostess(IDepartureAirport_Hostess idep, GeneralRepository generalRepository) {
            this.iDepartureAirport = idep;
            this.generalRepository = generalRepository;
            this.currentState = HostessState.WAIT_FOR_FLIGHT;
    }

    /**
	 * Sets hostess current state to the pretended state
	 * @param passengerState
	*/
    public void setHostessState(HostessState hostessState) {
            this.currentState=hostessState;
    }

    /**
	 * Hostess life-cycle
	*/
    @Override
    public void run() {

        while(generalRepository.totalPassTransported() != 21) {

            if (this.currentState == HostessState.WAIT_FOR_FLIGHT) {
                this.iDepartureAirport.prepareForPassBoarding();
            }

            if (this.currentState== HostessState.WAIT_FOR_PASSENGER) {
            	while(!canTakeOff() ){
                    this.iDepartureAirport.checkDocuments();
                    this.iDepartureAirport.waitForNextPassenger();
                }
                this.iDepartureAirport.informPlaneReadyToTakeOff();        
            }

            if (this.currentState== HostessState.READY_TO_FLY) {
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
    	return generalRepository.isCanTakeOff();
    }

}
