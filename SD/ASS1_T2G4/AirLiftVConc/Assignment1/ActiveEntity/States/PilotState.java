package ActiveEntity.States;

/**
 * Enum class with possible states for the Hostess class
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public enum PilotState {
	
	/**
	 * transition state (initial / final state) </p>
	 *	Only used to start the simulation
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#informPlaneReadyForBoarding} puts instance in {@link PilotState#READY_FOR_BOARDING} state.
         * 
         * </ul>
	*/
    AT_TRANSFER_GATE("ATRG"),
    
    /**
	 * transition state </p>
	 *	Used to wake up the hostess
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#waitForAllInBoard} puts instance in {@link PilotState#WAITING_FOR_BOARDING} state.
	 * </ul>
	*/
    READY_FOR_BOARDING("RDFB"),
    
    /**
	 * blocking state </p>
	 *	The pilot is waken up by the operation informPlaneReadyToTakeOff of the hostess when
	 *  boarding is complete
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SR_Plane#flyToDestinationPoint} puts instance in {@link PilotState#FLYING_FORWARD} state.
	 * </ul>
	*/
    WAITING_FOR_BOARDING("WTFB"),
    
    /**
	 * independent state with blocking </p>
	 *	The pilot should is made to sleep for a random time interval in the simulation.
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SRDepartureAirport#parkAtTransferGate} puts instance in {@link PilotState#AT_TRANSFER_GATE} state.
	 * </ul>
	*/
    FLYING_BACK("FLBK"),
    
    /**
	 * blocking state </p>
	 *	The pilot is waken up by the operation leaveThePlane of the last passenger to leave the plane
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SR_DestAirport#flyToDeparturePoint} puts instance in {@link PilotState#FLYING_BACK} state.
	 * </ul>
	*/
    DEBOARDING("DRPP"),
    
    /**
	 * independent state with blocking </p>
	 *	The pilot should is made to sleep for a random time interval in the simulation.
	 * @StateTransitions
	 * <ul>
	 * <li>{@link Assignment1.DepartureAirport.SR_Plane#announceArrival} puts instance in {@link PilotState#DEBOARDING} state.
	 * </ul>
	*/
    FLYING_FORWARD("FLWE");
    
	/**
	 * Instance state variable
	 */
    private final String state;
    
    /**
	 * PilotState constructor method
	 * @param state
	 */
    private PilotState (String state){
        this.state=state;
    }
    
    /**
	 * PilotState to string method
	 */
    @Override
    public String toString(){
        return this.state;
    }
}
