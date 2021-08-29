package server.sharedregions.DestinationAirport;

import Common.Message;
import Common.States;
import client.stubs.DepartureStub;
import client.stubs.GeneralRepositoryStub;
import client.stubs.PlaneStub;
import server.entities.CommunicationProvider;

/**
 * Shared Region Destination Airport 
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_DestAirport{
	
	/**
	 * Logger repository
	*/
	private GeneralRepositoryStub generalRepository;
        
	/**
	 * DepartureStub for communication
	 */
    private DepartureStub SRDepartureAirport;
    
    /**
     * PlaneStub for communication
     */
    private PlaneStub plane;
	
	/**
     * Number of passengers already transported
     */
    private static int PTAL = 0;
	
	/**
	 * SR_DestAirport constructor method
	 * @param generalRepository
	 * @param dep
	 * @param plane
	 */
	public SR_DestAirport(GeneralRepositoryStub generalRepository, DepartureStub dep, PlaneStub plane) {
		this.generalRepository = generalRepository;
        this.setPTAL(0);
        this.SRDepartureAirport = dep;
        this.plane = plane;
	}

	/**
	 * Passenger method to leave the plane 
     * 
     * Puts passenger in AT_DESTINATION state. 
     * Last method of the passenger life-cycle
	 */
	
    public synchronized void leaveThePlane(){
    	try{
       
        CommunicationProvider passenger = (CommunicationProvider) Thread.currentThread();
        passenger.setEntityState(States.AT_DESTINATION);
        int flight = this.SRDepartureAirport.getFlight();
        System.out.printf("\n____[SR_DEST] flight is %d \n",flight);
        this.setPTAL(this.getPTAL() + 1);
        generalRepository.removeFromFlight( true);
        int inf = SRDepartureAirport.getInFlight()-1;
        System.out.printf("\n __[xxxSR_DEST] in flight : %d \n",inf);
        SRDepartureAirport.setInFlight( inf);
        generalRepository.IncTotalPassTrasported();
        
        generalRepository.updatePassengerState(States.AT_DESTINATION, passenger.getEntityID(), false);
        System.out.printf("[PASSENGER %d] -> LEAVING THE PLANE! \n",passenger.getEntityID() );
       
        //notifyAll();
        System.out.printf("\n___INF IS: %d ", inf);
        if(inf == 0){
            System.out.println("setting plane empty from destination");
            plane.setPlaneEmpty(true);
            System.out.println("after setting plane empty from destination");
        }else{ notifyAll();} //apagar?
        
        }catch (Exception e){
            e.printStackTrace(System.out);
        }
        
       
        
    }

	/**
	 * Getter for the PTAL variable
	 * @return PTAL
	 */
	public synchronized int getPTAL() {
		return PTAL;
	}
	
	/**
	 * Setter for the PTAL variable
	 * @param i
	 */
	private synchronized void setPTAL(int i) {
		PTAL = i;
	}
	
}
