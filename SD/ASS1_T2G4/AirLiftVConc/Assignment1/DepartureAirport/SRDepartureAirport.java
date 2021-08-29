package DepartureAirport;

import ActiveEntity.*;
import ActiveEntity.States.*;
import Plane.SR_Plane;
import Repository.GeneralRepository;

/**
 * SRDepartureAirport class 
 * <p/>
 * Shared memory region of Departure Airport,
 * where passengers arrive at random times to check in for the transfer flight 
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class SRDepartureAirport implements IDepartureAirport_Pilot,
                                           IDepartureAirport_Hostess,
                                           IDepartureAirport_Passenger  {
	
    /**
     * Logger repository
     */
    private GeneralRepository generalRepository;
    
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
     * Variable to signal Hostess that Pilot is back and parked at transfer gate in departure airport after flight
     */
    private boolean pilotATG;
        
    /**
     * Constructor for Departure Airport shared region
     * 
     * @param max 
     * @param min
     * @param gr
     * @param total
     * @param plane 
     */
    public SRDepartureAirport ( int max, int min, GeneralRepository gr,
                                int total, SR_Plane plane){
        this.readyForBoarding = false;
        this.docs_shown = false;
        this.boarded = false;
        this.takeOff = false;
        this.MAX = max;
        this.MIN = min;
        this.TOTAL = total;
        this.generalRepository = gr;
        this.current_passangerToCheck = -1;
        this.current_passangerToBoard = -1;
        this.flight = generalRepository.getCurrentFlight();
        this.pilotATG = false;
    }
    
    /**
     * Method to signal hostess that check in can start.
     * Puts pilot in {@link Assignment1.ActiveEntity.States.PilotState#READY_FOR_BOARDING} state. 
     */
    @Override
    public synchronized void informPlaneReadyForBoarding(){
        Pilot pilot = (Pilot) Thread.currentThread();
        pilot.setPilotState(PilotState.READY_FOR_BOARDING);
        generalRepository.updatePilotState(PilotState.READY_FOR_BOARDING, false);
        System.out.printf("[DEP_AIRPORT] PILOT INFORMS READY FOR BOARDING\n");
        this.readyForBoarding = true;
        
        notifyAll();
    }
    
    /**
     * Method used to make Pilot wait while passengers are boarding. 
     * Puts pilot in {@link Assignment1.ActiveEntity.States.PilotState#WAITING_FOR_BOARDING} state.  
     */
    @Override
    public synchronized void waitForAllInBoard(){
        Pilot pilot = (Pilot) Thread.currentThread();
        pilot.setPilotState(PilotState.WAITING_FOR_BOARDING); 
        generalRepository.updatePilotState(PilotState.WAITING_FOR_BOARDING, false);
       
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
     * Puts hostess in {@link Assignment1.ActiveEntity.States.HostessState#READY_FOR_BOARDING} state.
     */
    @Override
    public synchronized void prepareForPassBoarding(){
        Hostess hostess = (Hostess) Thread.currentThread();
        while(!readyForBoarding){
            try{
                wait();
            }catch (InterruptedException e) {}
        }
        
        System.out.printf("[DEP_AIRPORT] HOSTESS WAITING FOR PASSENGERS\n");
        hostess.setHostessState(HostessState.WAIT_FOR_PASSENGER);   
        generalRepository.updateHostessState(HostessState.WAIT_FOR_PASSENGER, false);
    }
    
    /**
     * Method used to make hostess check in passengers from waiting queue and check their documents.
     * Puts hostess in {@link Assignment1.ActiveEntity.States.HostessState#CHECK_PASSENGER} state.
     * 
     */
    @Override
    public synchronized void checkDocuments(){
        Hostess hostess = (Hostess) Thread.currentThread();
        
        while( queueEmpty() ){
            try{
                wait();
            }catch (InterruptedException e) {}   
        }
        current_passangerToCheck = generalRepository.removeFromWaitingQueue(true);
        hostess.setHostessState(HostessState.CHECK_PASSENGER);
        generalRepository.updateHostessState(HostessState.CHECK_PASSENGER, false);
       
        System.out.printf("[DEP_AIRPORT] HOSTESS WAITING FOR PASSENGER %d TO SHOW DOCS\n",current_passangerToCheck);
        notifyAll();
    }
    
    /**
     * Method used to make hostess wait to passenger to show documents, remove him from waiting queue and decide of current flight is ready to take off.
     * Puts hostess in {@link Assignment1.ActiveEntity.States.HostessState#WAIT_FOR_PASSENGER} state.
     */
    @Override
    public synchronized void waitForNextPassenger(){
        Hostess hostess = (Hostess) Thread.currentThread();
        hostess.setHostessState(HostessState.WAIT_FOR_PASSENGER);
        generalRepository.updateHostessState(HostessState.WAIT_FOR_PASSENGER, false);
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

        if( generalRepository.getInFlight() == MAX || (queueEmpty() && generalRepository.getInFlight() >= MIN ) || (queueEmpty() && generalRepository.totalPassTransported()+generalRepository.getInFlight() == TOTAL )){
            generalRepository.setCanTakeOff(true);

            pilotATG = false;
            System.out.printf("[DEP_AIRPORT] HOSTESS DECIDES CAN NOW TAKE OFF\n");
            generalRepository.setCurrentFlight(flight+1);
            this.flight = generalRepository.getCurrentFlight();
        }
        else {
        	generalRepository.setCanTakeOff(false);
            System.out.printf("[DEP_AIRPORT] HOSTESS DECIDES CAN NOT TAKE OFF\n");
        }
        current_passangerToCheck = -1;
        notifyAll();
        
    }
    
    /**
     * Method used to inform Pilot that plane is ready to take off.
     * Puts hostess in {@link Assignment1.ActiveEntity.States.HostessState#READY_TO_FLY} state.
     */
    @Override
    public synchronized void informPlaneReadyToTakeOff(){
        Hostess hostess = (Hostess) Thread.currentThread();

        generalRepository.setCanTakeOff(false);
        this.takeOff = true;
        this.readyForBoarding=false;
        
        System.out.printf("[DEP_AIRPORT] HOSTESS INFORMS PLANE READY TO TAKE OFF\n");
        hostess.setHostessState(HostessState.READY_TO_FLY);
        generalRepository.updateHostessState(HostessState.READY_TO_FLY, false);
        notifyAll();

    }
    
    /**
    * Method used to make hostess decide wait for pilot to come back and park at transfer gate and proceed to next flight if there is more passengers to be transported
    * Puts hostess in {@link Assignment1.ActiveEntity.States.HostessState#WAIT_FOR_FLIGHT} state.
    */
    @Override
    public synchronized void waitForNextFlight(){
        Hostess hostess = (Hostess) Thread.currentThread();
        
        System.out.printf("[DEP_AIRPORT] HOSTESS WAITS FOR NEXT FLIGHT\n");
        hostess.setHostessState(HostessState.WAIT_FOR_FLIGHT);
        generalRepository.updateHostessState(HostessState.WAIT_FOR_FLIGHT, false);
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
    @Override
    public synchronized void travelToAirport(int travelTime){ 
        Passenger passenger = (Passenger) Thread.currentThread();
        passenger.setPassengerState(PassengerState.GOING_T0_AIRPORT);
        generalRepository.updatePassengerState(PassengerState.GOING_T0_AIRPORT, passenger.getID(), false);
        System.out.printf("[DEP_AIRPORT] PASSENGER %d GOING TO AIRPORT\n",passenger.getID());
        try{
                passenger.sleep(travelTime);
            }catch (InterruptedException e) {} 
        
    }
    
    /**
     * method to add passenger to waiting queue and signal hostess to start check in and wait to passenger's turn to check in.
     * Puts passenger in {@link Assignment1.ActiveEntity.States.PassengerState#IN_QUEUE} state.
     */
    @Override
    public synchronized void waitInQueue(){ 
        Passenger passenger = (Passenger) Thread.currentThread();
        passenger.setPassengerState(PassengerState.IN_QUEUE);
        try{
            generalRepository.addToWaitingQueue(passenger.getID(), false);

        }catch (NullPointerException e) {
            
        }
        generalRepository.updatePassengerState(PassengerState.IN_QUEUE, passenger.getID(), false);
        System.out.printf("[DEP_AIRPORT] PASSENGER %d ENTERED THE QUEUE AND WAITING\n" ,passenger.getID());

        notifyAll();
        
        while ( current_passangerToCheck != passenger.getID() ){
        try{
                wait();
            }catch (InterruptedException e) {} 
        }
        
       
        System.out.printf("[DEP_AIRPORT] PASSENGER %d IS GOING TO SHOW DOCS\n",passenger.getID());
    }
    
    /**
     * Method in which passenger waits for his turn to show documents and then shows it.
     * Maintains passenger in {@link Assignment1.ActiveEntity.States.PassengerState#IN_QUEUE} state.
     */
    @Override
    public synchronized void showDocuments(){ 
        Passenger passenger = (Passenger) Thread.currentThread();
 
        
        while ( current_passangerToCheck != passenger.getID() ){
        try{
                wait();
            }catch (InterruptedException e) {} 
        }
        
        docs_shown = true;
        
        System.out.printf("[DEP_AIRPORT] PASSENGER %d SHOWS DOCS\n", passenger.getID());
        passenger.setPassengerState(PassengerState.IN_QUEUE);
        generalRepository.updatePassengerState(PassengerState.IN_QUEUE, passenger.getID(), false);
        notifyAll();
        
    }
    
    /**
    * Method to make pilot park at transfer gate after flight and signal hostess to proceed to next flight or finish life cycle.
    * Puts pilot in {@link Assignment1.ActiveEntity.States.PilotState#AT_TRANSFER_GATE} state.
    */
    @Override
    public synchronized void parkAtTransferGate(){
        Pilot pilot = (Pilot) Thread.currentThread();
        System.out.printf("[DEP_AIRPORT] PILOT PARKING AT TRANSFER GATE\n");
        pilot.setPilotState(PilotState.AT_TRANSFER_GATE);
        generalRepository.updatePilotState(PilotState.AT_TRANSFER_GATE, false);
        this.pilotATG = true;
        notifyAll();
        
    }
    
    /**
     * Method in which passenger waits to his turn to board the plane and signal hostess when boarded.
     * Puts passenger in {@link Assignment1.ActiveEntity.States.PassengerState#IN_FLIGHT} state.
     */
    @Override
    public synchronized void boardThePlane(){
        
        Passenger passenger = (Passenger) Thread.currentThread();
         
        while(current_passangerToBoard != passenger.getID()){
            try{
                wait();
            }catch (InterruptedException e) {} 
        }
        System.out.printf("[DEP_AIRPORT] PASSENGER %d BOARDING THE PLANE\n", passenger.getID());
        
       
        
        passenger.setPassengerState(PassengerState.IN_FLIGHT); 
        generalRepository.updatePassengerState(PassengerState.IN_FLIGHT, passenger.getID(), true);
         
        generalRepository.addToFlight (flight, false);
        
        this.boarded = true;
        notifyAll();
    }
    
    /**
     * Method to check if waiting queue is empty.
     * @return 
     */
    synchronized boolean queueEmpty() {

        return generalRepository.getInQueue()==0;
        
    }

    /**
     * Method to get current flight sequential number
     * @return 
     */
    public int getFlight(){
        return flight-1;
    }
}
