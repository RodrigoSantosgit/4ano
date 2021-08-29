package ActiveEntity.States;

/**
 * Enum class with possible states for the Hostess class
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public enum PassengerState {
	
	/**
	 * independent state with blocking (initial state) </p>
	 *	The passenger is made to sleep for a random time interval in the simulation.
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#waitInQueue} puts instance in {@link PassengerState#IN_QUEUE} state.
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#travelToAirport} keeps instance on the same state.
	 * </ul>
	*/
	GOING_T0_AIRPORT("GTAP"),
	
	/**
	 * double blocking state </p>
	 *	The passenger is waken up first by the operation checkDocuments of the hostess requesting him/ her
	 *  to present the plane ticket and is waken up next by the operation waitForNextPassenger of the 
	 *  hostess after the checking is being made
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#boardThePlane} puts instance in {@link PassengerState#IN_FLIGHT} state.
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#showDocuments} keeps instance on the same state.
	 * </ul>
	*/
	IN_QUEUE("INQE"),
	
	/**
	 * blocking state </p>
	 *	The passenger is waken up by the operation announceArrival of the pilot after parking the plane at
	 *  the arrival gate.
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SR_DestAirport#leaveThePlane} puts instance in {@link PassengerState#AT_DESTINATION} state.
	 * </ul>
	*/
	IN_FLIGHT("INFL"),
	
	/**
	 * transition state (final state) </p>
	 * Final state used to indicate that the passenger has arrived at the destination
	 */
	AT_DESTINATION("ATDS");
	
	/**
	 * Instance state variable
	 */
	private final String state;
	 
	/**
	 * PassengerState constructor method
	 * @param state
	 */
	private PassengerState (String state){
	    this.state=state;
	}
	
	/**
	 * PassengerState to string method
	 */
    @Override
    public String toString(){
        return this.state;
    }
}
