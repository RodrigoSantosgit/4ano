package ActiveEntity.States;

/**
 * Enum class with possible states for the Hostess class
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public enum HostessState {
	 
	/**
	 * blocking state (initial / final state) </p>
	 *	The hostess is waken up by the operation informPlaneReadyForBoarding of the pilot after 
	 *	parking the plane at the departure gate.
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#prepareForPassBoarding} puts instance in {@link HostessState#WAIT_FOR_PASSENGER} state.
	 * </ul>
	*/
	WAIT_FOR_FLIGHT("WTFL"),
	
	/**
	 * blocking state </p>
	 *  The hostess is waken up by the operation waitInQueue of the passenger while he / she waits 
	 *  to have his / her documents checked
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#checkDocuments} puts instance in {@link HostessState#CHECK_PASSENGER} state.
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#informPlaneReadyToTakeOff} puts instance in {@link HostessState#READY_TO_FLY} state.
	 * </ul>
	*/
	WAIT_FOR_PASSENGER("WTPS"),
	
	/**
	 * transition state </p>
	 *  Used when informing the pilot that the plane is ready to take off 
	 * @StateTransitions 
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#waitForNextFlight} puts instance in {@link HostessState#WAIT_FOR_FLIGHT} state.
	 * </ul>
	*/
	READY_TO_FLY("RDTF"),
	
	/**
	 * blocking state </p>
	 *  The hostess is waken up by the operation showDocuments of the passenger when he / she 
	 *  hands his / her plane ticket to be checked.
	 * @StateTransitions 
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#waitForNextPassenger} puts instance in {@link HostessState#WAIT_FOR_PASSENGER} state.
	 * </ul>
	*/
	CHECK_PASSENGER("CKPS");
	
	/**
	 * Instance state variable
	 */
	private final String state;
	
	/**
	 * HostessState constructor method
	 * @param state
	 */
	private HostessState (String state){
	    this.state=state;
	}
	
	/**
	 * HostessState to string method
	 */
	@Override
	public String toString(){
	    return this.state;
	}
}
