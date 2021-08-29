package DestinationAirport;

import ActiveEntity.Passenger;
import ActiveEntity.States.PassengerState;
import DepartureAirport.SRDepartureAirport;
import Plane.SR_Plane;
import Repository.GeneralRepository;

/**
 * Shared Region Destination Airport 
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_DestAirport implements IDestAirport_Hostess, IDestAirport_Pilot, IDestAirport_Passenger {
	
	/**
	 * Logger repository
	*/
	private GeneralRepository generalRepository;
    
	/**
	 * SR_Plane entity
	*/
	private SR_Plane SR_Plane;
	
	/**
	 * SR_DestAirport constructor method
	 * @param generalRepository
	 * @param plane
	 * @param SRDepartureAirport
	 */
	public SR_DestAirport(GeneralRepository generalRepository, SR_Plane plane, SRDepartureAirport SRDepartureAirport) {
		this.generalRepository = generalRepository;
        this.SR_Plane = plane;
	}
	
	/**
	 * Passenger method to leave the plane </p>
     * 
     * Puts passenger in {@link Assignment1.ActiveEntity.States.PassengerState#AT_DESTINATION} state. </p>
     * Last method of the passenger life-cycle
	 */
	@Override
    public synchronized void leaveThePlane(){
        Passenger passenger = (Passenger) Thread.currentThread();
        passenger.setPassengerState(PassengerState.AT_DESTINATION);
        int flight = generalRepository.getCurrentFlight()-1;
        generalRepository.removeFromFlight(flight, true);
        generalRepository.IncTotalPassTrasported();
        generalRepository.updatePassengerState(PassengerState.AT_DESTINATION, passenger.getID(), false);
        System.out.printf("[PASSENGER] -> LEAVING THE PLANE! \n");
       
        notifyAll();
        
        if(generalRepository.getInFlight() == 0){
            SR_Plane.setPlaneEmpty(true);
        }
   
    }
	
}
