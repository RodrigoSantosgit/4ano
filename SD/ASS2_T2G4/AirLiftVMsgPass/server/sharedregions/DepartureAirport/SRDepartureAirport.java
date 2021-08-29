package server.sharedregions.DepartureAirport;

import java.util.LinkedList;
import java.util.Queue;
import Common.States;
import client.stubs.GeneralRepositoryStub;
import server.entities.CommunicationProvider;

/**
 * SRDepartureAirport class 
 * 
 * Shared memory region of Departure Airport,
 * where passengers arrive at random times to check in for the transfer flight 
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class SRDepartureAirport{
	
    /**
     * Logger repository
     */
    private GeneralRepositoryStub generalRepository;
    
    /**
     * Flag for the hostess to indicate that the plane is ready to take off
     */
    private boolean canTakeOff;
    
    /**
     * Variable to wake up hostess and start boarding
     */
    private boolean readyForBoarding;
   
    /**
     * Total number of passengers transported in simulation  
     */
    private int TOTAL;
    
    /**
     * Minimum number of passengers in each flight
     */
    private int MIN;
    
    /**
     * Maximum number of passengers in each flight
     */
    private int MAX;
    
    /**
     * Number of total boarded passengers across all flights
     */
    private int totalBoarded;
    
    /**
     * ID of current Passenger thread to check in
     */
    private int current_passangerToCheck;
    
    /**
     * ID of current Passenger thread to board the plane
     */
    private int  current_passangerToBoard;
    
    /**
     * Variable to signal Hostess that current Passenger showed documents during check in
     */
    private boolean docs_shown;
    
    /**
     * Variable to signal Pilot that plane is ready to take off
     */
    private boolean takeOff;
    
    /**
     * Variable to signal that checked in passenger has boarded the plane
     */
    private boolean boarded;
    
    /**
     * Sequential number of current flight in simulation
     */
    private int flight; 
    
    /**
     * Flight recording array
     */
    private int [] flights;
    
    /**
     * Variable to signal Hostess that Pilot is back and parked at transfer gate in departure airport after flight
     */
    private boolean pilotATG;
    
    /**
     * Passenger waiting queue
     */
    private Queue<Integer> waitingQueue;
    
    /**
     * Current passenger ID called by the hostess
     */
    private int currentPass;
    
    /**
     * Current passengers inf flight
     */
    private int InF;
        
    /**
     * Constructor for Departure Airport shared region
     * 
     * @param max 
     * @param min
     * @param gr
     * @param total
     */
    public SRDepartureAirport ( int max, int min, GeneralRepositoryStub gr,
                                int total){
        this.readyForBoarding = false;
        this.docs_shown = false;
        this.boarded = false;
        this.takeOff = false;
        this.MAX = max;
        this.MIN = min;
        this.TOTAL = total;
        this.generalRepository = gr;
        this.current_passangerToCheck = -1;
        this.currentPass = -1;
        this.current_passangerToBoard = -1;
        this.flight = 1;
        this.pilotATG = false;
        this.waitingQueue = new LinkedList<>();
        this.flights =new int[7];
        this.totalBoarded = 0;
        this.InF = 0;
    }
    
    /**
     * Method to signal hostess that check in can start.
     * Puts pilot in READY_FOR_BOARDING state. 
     */
    public synchronized void informPlaneReadyForBoarding(){
        
        CommunicationProvider pilot = (CommunicationProvider) Thread.currentThread();
        pilot.setEntityState(States.READY_FOR_BOARDING);
        generalRepository.updatePilotState(States.READY_FOR_BOARDING, false, this.flight);
        System.out.printf("[DEP_AIRPORT] PILOT INFORMS READY FOR BOARDING\n");
        this.readyForBoarding = true;
        notifyAll();
    }
    
    /**
     * Method used to make Pilot wait while passengers are boarding. 
     * Puts pilot in WAITING_FOR_BOARDING state.  
     */
    public synchronized void waitForAllInBoard(){
        CommunicationProvider pilot = (CommunicationProvider) Thread.currentThread();
        pilot.setEntityState(States.WAITING_FOR_BOARDING); 
        generalRepository.updatePilotState(States.WAITING_FOR_BOARDING, false, this.flight);
       
        System.out.printf("[DEP_AIRPORT] PILOT WAITING FOR ALL IN BOARD\n");
        while(!takeOff){
            try{
                wait();
            }catch (InterruptedException e) {}
        }
        takeOff=false;
       
        System.out.printf("[DEP_AIRPORT] PILOT IS GOING TO FLY TO DESTINATION\n");
    }
    
    /**
     * Method used to make hostess wait for next flight.
     * Puts hostess in READY_FOR_BOARDING state.
     */
    
    public synchronized void prepareForPassBoarding(){
        CommunicationProvider hostess = (CommunicationProvider) Thread.currentThread();
        while(!readyForBoarding){
            try{
                wait();
            }catch (InterruptedException e) {}
        }
        
        System.out.printf("[DEP_AIRPORT] HOSTESS WAITING FOR PASSENGERS\n");
        hostess.setEntityState(States.WAIT_FOR_PASSENGER);   
        generalRepository.updateHostessState(States.WAIT_FOR_PASSENGER, false, this.currentPass, this.flight, flights);
    }
    
    /**
     * Method used to make hostess check in passengers from waiting queue and check their documents.
     * Puts hostess in CHECK_PASSENGER state.
     * 
     */
    public synchronized void checkDocuments(){
        CommunicationProvider hostess = (CommunicationProvider) Thread.currentThread();
        System.out.printf("[DEP_AIRPORT] HOSTESS GOING TO CHECK DOCS\n");
        
        while( queueEmpty() ){
            try{
                wait();
            }catch (InterruptedException e) {}   
        }
        current_passangerToCheck = removeFromWaitingQueue(true);
        hostess.setEntityState(States.CHECK_PASSENGER);
        generalRepository.updateHostessState(States.CHECK_PASSENGER, false, this.currentPass, this.flight, flights);
       
        System.out.printf("[DEP_AIRPORT] HOSTESS WAITING FOR PASSENGER %d TO SHOW DOCS\n",current_passangerToCheck);
        notifyAll();
    }
    
    /**
     * Method used to make hostess wait to passenger to show documents, remove him from waiting queue and decide of current flight is ready to take off.
     * Puts hostess in WAIT_FOR_PASSENGER state.
     */
    public synchronized void waitForNextPassenger(){
        CommunicationProvider hostess = (CommunicationProvider) Thread.currentThread();
        hostess.setEntityState(States.WAIT_FOR_PASSENGER);
        generalRepository.updateHostessState(States.WAIT_FOR_PASSENGER, false, this.currentPass, this.flight, flights);
        while( !docs_shown  ){
           
            try{
                wait();
            }catch (InterruptedException e) {} 
        }
        System.out.printf("[DEP_AIRPORT] HOSTESS CHECKED DOCS OF PASSENGER %d \n", current_passangerToCheck);
        docs_shown = false;
        
        current_passangerToBoard = current_passangerToCheck;
        notifyAll();
        while(!boarded){
            try{
                wait();
            }catch (InterruptedException e) {} 
        }
        boarded = false;
        System.out.printf("\n[DEP_AIRPORT] InF = %d\n",InF);
        System.out.printf("\n[DEP_AIRPORT] totalBoarded = %d\n",totalBoarded);

        if( InF == MAX || (queueEmpty() && InF >= MIN ) || (queueEmpty() && this.totalBoarded == TOTAL )){
            setCanTakeOff(true);

            pilotATG = false;
            System.out.printf("[DEP_AIRPORT] HOSTESS DECIDES CAN NOW TAKE OFF\n");
            this.flight = flight+1;
        }
        else {
        	setCanTakeOff(false);
            System.out.printf("[DEP_AIRPORT] HOSTESS DECIDES CAN NOT TAKE OFF\n");
        }
        current_passangerToCheck = -1;
        notifyAll();
        
    }
    
    /**
     * Method used to inform Pilot that plane is ready to take off.
     * Puts hostess in READY_TO_FLY state.
     */
    
    public synchronized void informPlaneReadyToTakeOff(){
        CommunicationProvider hostess = (CommunicationProvider) Thread.currentThread();

        setCanTakeOff(false);
        this.takeOff = true;
        this.readyForBoarding=false;
        
        System.out.printf("[DEP_AIRPORT] HOSTESS INFORMS PLANE READY TO TAKE OFF\n");
        hostess.setEntityState(States.READY_TO_FLY);
        generalRepository.updateHostessState(States.READY_TO_FLY, false, this.currentPass, this.flight, flights);
        notifyAll();

    }
    
    /**
    * Method used to make hostess decide wait for pilot to come back and park at transfer gate and proceed to next flight if there is more passengers to be transported
    * Puts hostess in WAIT_FOR_FLIGHT state.
    */
    
    public synchronized void waitForNextFlight(){
        CommunicationProvider hostess = (CommunicationProvider) Thread.currentThread();
        
        System.out.printf("[DEP_AIRPORT] HOSTESS WAITS FOR NEXT FLIGHT\n");
        hostess.setEntityState(States.WAIT_FOR_FLIGHT);
        generalRepository.updateHostessState(States.WAIT_FOR_FLIGHT, false, this.currentPass, this.flight, flights);
        while(!pilotATG){
            try{
                wait();
            }catch (InterruptedException e) {} 
        }
        
        notifyAll();
      
    }
    
    /**
     * Method used to make passenger sleep for a random time simulating a trip to Airport.
     * 
     * @param travelTime 
     */
    
    public synchronized void travelToAirport(int travelTime){ 
        CommunicationProvider passenger = (CommunicationProvider) Thread.currentThread();
        passenger.setEntityState(States.GOING_T0_AIRPORT);
        generalRepository.updatePassengerState(States.GOING_T0_AIRPORT, passenger.getEntityID(), false);
        System.out.printf("[DEP_AIRPORT] PASSENGER %d GOING TO AIRPORT\n",passenger.getEntityID());
        try{
                passenger.sleep(travelTime);
            }catch (InterruptedException e) {} 
        
    }
    
    /**
     * method to add passenger to waiting queue and signal hostess to start check in and wait to passenger's turn to check in.
     * Puts passenger in IN_QUEUE state.
     */
    
    public synchronized void waitInQueue(){ 
        CommunicationProvider passenger = (CommunicationProvider) Thread.currentThread();
        passenger.setEntityState(States.IN_QUEUE);
        try{
            System.out.println("[DEPARTURE] waitInQueue, id do passageiro: ");
            System.out.println(passenger.getEntityID());
            addToWaitingQueue(passenger.getEntityID());

        }catch (NullPointerException e) {
            
        }
        generalRepository.updatePassengerState(States.IN_QUEUE, passenger.getEntityID(), false);
        System.out.printf("[DEP_AIRPORT] PASSENGER %d ENTERED THE QUEUE AND WAITING\n" ,passenger.getEntityID());

        notifyAll();
        
        while ( current_passangerToCheck != passenger.getEntityID() ){
        try{
                wait();
            }catch (InterruptedException e) {} 
        }
        
       
        System.out.printf("[DEP_AIRPORT] PASSENGER %d IS GOING TO SHOW DOCS\n",passenger.getEntityID());
    }
    
    /**
     * Method in which passenger waits for his turn to show documents and then shows it.
     * Maintains passenger in IN_QUEUE state.
     */
    
    public synchronized void showDocuments(){ 
        CommunicationProvider passenger = (CommunicationProvider) Thread.currentThread();
 
        
        while ( current_passangerToCheck != passenger.getEntityID() ){
        try{
                wait();
            }catch (InterruptedException e) {} 
        }
        
        docs_shown = true;
        
        System.out.printf("[DEP_AIRPORT] PASSENGER %d SHOWS DOCS\n", passenger.getEntityID());
        passenger.setEntityState(States.IN_QUEUE);
        generalRepository.updatePassengerState(States.IN_QUEUE, passenger.getEntityID(), false);
        notifyAll();
        
    }
    
    /**
    * Method to make pilot park at transfer gate after flight and signal hostess to proceed to next flight or finish life cycle.
    * Puts pilot in AT_TRANSFER_GATE state.
    */
    
    public synchronized void parkAtTransferGate(){
        CommunicationProvider pilot = (CommunicationProvider) Thread.currentThread();
        System.out.printf("[DEP_AIRPORT] PILOT PARKING AT TRANSFER GATE\n");
        pilot.setEntityState(States.AT_TRANSFER_GATE);
        generalRepository.updatePilotState(States.AT_TRANSFER_GATE, false, this.flight);
        this.pilotATG = true;
        notifyAll();
        
    }
    
    /**
     * Method in which passenger waits to his turn to board the plane and signal hostess when boarded.
     * Puts passenger in IN_FLIGHT state.
     */
    public synchronized void boardThePlane(){
        
        CommunicationProvider passenger = (CommunicationProvider) Thread.currentThread();
         
        while(current_passangerToBoard != passenger.getEntityID()){
            try{
                wait();
            }catch (InterruptedException e) {} 
        }
        System.out.printf("[DEP_AIRPORT] PASSENGER %d BOARDING THE PLANE\n", passenger.getEntityID());
        
       
        
        passenger.setEntityState(States.IN_FLIGHT); 
        generalRepository.updatePassengerState(States.IN_FLIGHT, passenger.getEntityID(), true);
         
        addToFlight(flight, false);
        this.totalBoarded += 1;
        this.boarded = true;
        notifyAll();
    }

	/**
     * Method to check if waiting queue is empty.
     * @return 
     */
    public synchronized boolean queueEmpty() {

        return waitingQueue.isEmpty();
        
    }

    /**
     * Method to get current flight sequential number
     * @return 
     */
    public synchronized int getFlight(){
        return flight-1;
    }
    
    /**
     * Adds a passenger to the waiting queue
     * @param passengerId
     */
    public synchronized void addToWaitingQueue(int passengerId) {
	
        waitingQueue.add(passengerId);
        //this.InQ++;
        generalRepository.addInQ();
            
    }
    
    /**
     * Removes the head passenger of the waiting queue
     
     * @return
     */
    public synchronized int removeFromWaitingQueue(boolean noLog) {
	
        //this.InQ--;
    	generalRepository.removeInQ();
		if (!noLog){
			generalRepository.updateFileLog();
		}
        currentPass = waitingQueue.poll();
        return currentPass;
    }
    
    /**
     * Getter for the canTakeOff variable
     * @return
     */
	public synchronized boolean isCanTakeOff() {
		return canTakeOff;
	}

	/**
	 * Setter for the canTakeOff variable
	 * @param canTakeOff
	 */
	public synchronized void setCanTakeOff(boolean canTakeOff) {
		this.canTakeOff = canTakeOff;
	}
	
	/**
     * Adds 1 to the total of passengers transported in a flight, and to the currently in flight (InF) variable
     * @param flight
     * @param noLog
     */
	private synchronized void addToFlight(int flight, boolean noLog) {
		flights[flight] = flights[flight] +1;
                InF ++;
		generalRepository.addToFlight( noLog);
	}
	
	/**
	 * Getter for the flights array variable
	 * @return flights
	 */
	public synchronized int[] getFlights() {
		return flights;
	}
	/**
	 * Getter for the InF variable
	 * @return InF, number of currently in flight passengers
	 */
    public synchronized int getInFlight(){
        return this.InF;
    }
    
    /**
     * Sets the value for InF variable
     * @param value
     */
    public synchronized void setInFlight(int value){
        this.InF=value;
    }
	
    
}
