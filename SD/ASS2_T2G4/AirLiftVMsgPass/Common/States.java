package Common;

/**
 * States class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public enum States {
	
    /**
	 * blocking state (initial / final state)
	 *	The hostess is waken up by the operation informPlaneReadyForBoarding of the pilot after 
	 *	parking the plane at the departure gate.
	 * StateTransitions:
	 * <ul>
	 * <li> SRDepartureAirport#prepareForPassBoarding puts instance in WAIT_FOR_PASSENGER state.
	 * </ul>
	*/
	WAIT_FOR_FLIGHT("WTFL"),
	
	/**
	 * blocking state 
	 *  The hostess is waken up by the operation waitInQueue of the passenger while he / she waits 
	 *  to have his / her documents checked
	 * StateTransitions:
	 * <ul>
	 * <li>SRDepartureAirport#checkDocuments puts instance in CHECK_PASSENGER state.
	 * <li>SRDepartureAirport#informPlaneReadyToTakeOff puts instance in READY_TO_FLY state.
	 * </ul>
	*/
	WAIT_FOR_PASSENGER("WTPS"),
	
	/**
	 * transition state 
	 *  Used when informing the pilot that the plane is ready to take off 
	 * StateTransitions:
	 * <ul>
	 * <li>SRDepartureAirport#waitForNextFlight puts instance in WAIT_FOR_FLIGHT state.
	 * </ul>
	*/
	READY_TO_FLY("RDTF"),
	
	/**
	 * blocking state
	 *  The hostess is waken up by the operation showDocuments of the passenger when he / she 
	 *  hands his / her plane ticket to be checked.
	 * StateTransitions: 
	 * <ul>
	 * <li>SRDepartureAirport#waitForNextPassenger puts instance in WAIT_FOR_PASSENGER state.
	 * </ul>
	*/
	CHECK_PASSENGER("CKPS"),
	
    /**
	 * independent state with blocking (initial state)
	 *	The passenger is made to sleep for a random time interval in the simulation.
	 * StateTransitions:
	 * <ul>
	 * <li>SRDepartureAirport#waitInQueue puts instance in IN_QUEUE state.
	 * <li>SRDepartureAirport#travelToAirport keeps instance on the same state.
	 * </ul>
	*/
	GOING_T0_AIRPORT("GTAP"),
	
	/**
	 * double blocking state 
	 *	The passenger is waken up first by the operation checkDocuments of the hostess requesting him/ her
	 *  to present the plane ticket and is waken up next by the operation waitForNextPassenger of the 
	 *  hostess after the checking is being made
	 * StateTransitions
	 * <ul>
	 * <li>SRDepartureAirport#boardThePlane puts instance in IN_FLIGHT state.
	 * <li>SRDepartureAirport#showDocuments keeps instance on the same state.
	 * </ul>
	*/
	IN_QUEUE("INQE"),
	
	/**
	 * blocking state 
	 *	The passenger is waken up by the operation announceArrival of the pilot after parking the plane at
	 *  the arrival gate.
	 * StateTransitions
	 * <ul>
	 * <li>SR_DestAirport#leaveThePlane puts instance in AT_DESTINATION state.
	 * </ul>
	*/
	IN_FLIGHT("INFL"),
	
	/**
	 * transition state (final state) 
	 * Final state used to indicate that the passenger has arrived at the destination
	 */
	AT_DESTINATION("ATDS"),
        
    /**
	 * transition state (initial / final state) 
	 *	Only used to start the simulation
	 * StateTransitions
	 * <ul>
	 * <li>SRDepartureAirport#informPlaneReadyForBoarding puts instance in READY_FOR_BOARDING state.
     * 
     * </ul>
	*/
    AT_TRANSFER_GATE("ATRG"),
    
    /**
	 * transition state 
	 *	Used to wake up the hostess
	 * StateTransitions
	 * <ul>
	 * <li>SRDepartureAirport#waitForAllInBoard puts instance in WAITING_FOR_BOARDING state.
	 * </ul>
	*/
    READY_FOR_BOARDING("RDFB"),
    
    /**
	 * blocking state 
	 *	The pilot is waken up by the operation informPlaneReadyToTakeOff of the hostess when
	 *  boarding is complete
	 * StateTransitions
	 * <ul>
	 * <li>SR_Plane#flyToDestinationPoint puts instance in FLYING_FORWARD state.
	 * </ul>
	*/
    WAITING_FOR_BOARDING("WTFB"),
    
    /**
	 * independent state with blocking
	 *	The pilot should is made to sleep for a random time interval in the simulation.
	 * StateTransitions
	 * <ul>
	 * <li>SRDepartureAirport#parkAtTransferGate puts instance in AT_TRANSFER_GATE state.
	 * </ul>
	*/
    FLYING_BACK("FLBK"),
    
    /**
	 * blocking state
	 *	The pilot is waken up by the operation leaveThePlane of the last passenger to leave the plane
	 * StateTransitions
	 * <ul>
	 * <li>SR_DestAirport#flyToDeparturePoint puts instance in FLYING_BACK state.
	 * </ul>
	*/
    DEBOARDING("DRPP"),
    
    /**
	 * independent state with blocking 
	 *	The pilot should is made to sleep for a random time interval in the simulation.
	 * StateTransitions
	 * <ul>
	 * <li>SR_Plane#announceArrival puts instance in DEBOARDING state.
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
    private States (String state){
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
