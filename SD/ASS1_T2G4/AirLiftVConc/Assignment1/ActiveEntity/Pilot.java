package ActiveEntity;

import DepartureAirport.IDepartureAirport_Pilot;
import Plane.IPlane_Pilot;
import ActiveEntity.States.PilotState;
import Repository.GeneralRepository;

/**
 * Passenger entity data-type
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
*/
public class Pilot extends Thread{
	
	
	/**
	 * IDepartureAirport_Pilot entity
	*/
	private final IDepartureAirport_Pilot iDepartureAirport;
	
	/**
	 * IPlane_Pilot entity
	*/
	private final IPlane_Pilot iPlane;
    
    
	/**
	 * GeneralRepository entity
	*/
    private GeneralRepository generalRepository;
    
    /**
	 * Pilot current state
	*/
    private PilotState currentState;
	
    /**
     * Pilot constructor method
     * @param idep
     * @param ip
     * @param generalRepository
    */
	public Pilot(IDepartureAirport_Pilot idep, IPlane_Pilot ip,
             GeneralRepository generalRepository ) {
     
            this.iPlane = ip;
            this.iDepartureAirport = idep;
            this.currentState = PilotState.AT_TRANSFER_GATE;
            this.generalRepository = generalRepository;

	}
    
	/**
	 * Sets pilot current state to the pretended state
	 * @param pilotState
	*/
	public void setPilotState(PilotState pilotState) {
		this.currentState=pilotState;
	}
        
    /**
    * Pilot life-cycle
    */
	@Override
	public void run() {
        while(generalRepository.totalPassTransported() != 21) { 
            if (currentState == PilotState.AT_TRANSFER_GATE){
                
                iDepartureAirport.informPlaneReadyForBoarding();
                
                iDepartureAirport.waitForAllInBoard();
                
                iPlane.flyToDestinationPoint();
                
                iPlane.announceArrival();
                
                iPlane.flyToDeparturePoint();
                
                iDepartureAirport.parkAtTransferGate();
                
            }
                
        }
        System.out.printf("[PILOT] ---> FINISHED SIMULATION \n");
	}
	
}
