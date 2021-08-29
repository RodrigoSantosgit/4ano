package Repository;

import ActiveEntity.States.HostessState;
import ActiveEntity.States.PassengerState;
import ActiveEntity.States.PilotState;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

/**
 * General Repository Logger class 
 * <p/> 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class GeneralRepository {
	
	/**
	 * Log File Name
	 */
    private String logFilePath = "log.txt";
    
    /**
     * Passenger waiting queue
     */
    private Queue<Integer> waitingQueue; 
    
    /**
     * Flight recording array
     */
    private int [] flights;
    
    /**
     * Current Flight ID
     */
    private int currentFlight;
    
    /**
     * Number of passengers currently in queue
     */
    private int InQ;
    
    /**
     * Number of passengers currently in Flight
     */
    private int InF;
    
    /**
     * Number of passengers already transported
     */
    private int PTAL;
    
    /**
     * Pilot state indicator
     */
	private String pilotState;
	
	/**
	 * Passengers states
	 */
    private String [] passengerState;
    
    /**
     * Hostess state indicator
     */
    private String hostessState;
    
    /**
     * Current passenger ID called by the hostess
     */
    private int currentPass;
    
    /**
     * Flag for the hostess to indicate that the plane is ready to take off
     */
    private boolean canTakeOff;
	
    
    /**
     * GeneralRepository constructor method
     */
	public GeneralRepository() {
		this.currentFlight = 1;
		this.InQ = 0;
		this.InF = 0;
		this.PTAL = 0;
        this.waitingQueue = new LinkedList<>();
        this.passengerState = new String[21];
        this.flights =new int[7];
        
        this.init(); 
	}
	
    /**
     * Initializes the logger, and writes the logging file first few lines
     */
    private void init(){
        try{
            FileWriter fileWriter = new FileWriter(logFilePath);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
         
            for (int p=0; p<passengerState.length; p++){
                this.passengerState[p] = PassengerState.GOING_T0_AIRPORT.toString();
            }
            this.pilotState = PilotState.AT_TRANSFER_GATE.toString();
            this.hostessState = HostessState.WAIT_FOR_FLIGHT.toString();
            bufferedWriter.write("\t\t\tAIRLIFT - Description of the internal state of the problem\n");
            bufferedWriter.write("PT   HT    P00  P01  P02  P03  P04  P05  P06  P07  P08  P09  P10  P11  P12  P13  P14  P15  P16  P17  P18  P19  P20 InQ InF PTAL \n");
            bufferedWriter.write(
                String.format(
                "%s %s  ",
                        this.pilotState, this.hostessState
                ));
            for(int i=0; i<passengerState.length; i++){
                bufferedWriter.write(
                String.format(
                "%s ",
                      passengerState[i]
                ));
            }
            bufferedWriter.write(
                String.format(
                "%2d  %2d  %2d ",
                        InQ, this.InF, this.PTAL
                ));
            bufferedWriter.write("\n");
            bufferedWriter.close();
            fileWriter.close();
        }catch (IOException e) {
            System.err.println(e);
            System.err.println("Error initializing logger");
            e.printStackTrace();
            System.exit(1);
        }
    }
        
    /**
     * Finishes the logger buffer and closes the logging file
     */
    public void finish(){
        try{
            FileWriter fileWriter = new FileWriter(logFilePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.write("\nAirlift sum up. \n");
            for(int i=0; i<flights.length;i++ ){
            	if (flights[i] != 0) {
                	bufferedWriter.write(
                    String.format(
                    "Flight %d transported %d passengers. \n ",
                            i, flights[i]
                    )
	                );
            	}
            }
            
            bufferedWriter.write("\n");
            bufferedWriter.close();
            fileWriter.close();
            
        }catch (IOException e) {
            System.err.println(e);
            System.err.println("Error initiating logger");
            e.printStackTrace();
            System.exit(1);
        }
    }
        
    /**
     * Updates logging files information
     */
    private void updateFileLog() {
        try {
            FileWriter fileWriter = new FileWriter(logFilePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
          
            bufferedWriter.write(
                String.format(
                "%s %s ",
                        this.pilotState, this.hostessState
                )
            );
            for (int q=0; q < this.passengerState.length; q++) {
                bufferedWriter.write( String.format(
                "%s ", passengerState[q])
                    );
            }
            bufferedWriter.write(
                String.format(
                " %2d  %2d  %2d ",
                        this.InQ, this.InF, this.PTAL
                )
            );
            bufferedWriter.write("\n");
            bufferedWriter.close();
            fileWriter.close();
            
        } catch (IOException e) {
                System.err.println("Error updating file log");
                System.exit(2);
        }
    }
         
    /**
     * Updates p1ilot state and writes, if needed, the change in the logging file
     * @param newPilotState
     * @param noLog
     */
    public synchronized void updatePilotState(PilotState newPilotState, boolean noLog){
    	try {
            FileWriter fileWriter = new FileWriter(logFilePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            
            if(newPilotState.toString().equals("RDFB")&& !pilotState.equals("RDFB") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: boarding started. \n",
                        this.currentFlight
                ));
            }
            if(newPilotState.toString().equals("DRPP")&& !pilotState.equals("DRPP") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: arrived. \n",
                        this.currentFlight-1
                ));
            }
            if(newPilotState.toString().equals("FLBK")&& !pilotState.equals("FLBK") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: returning. \n",
                        this.currentFlight-1
                ));
            }
            
            bufferedWriter.close();
            fileWriter.close();
        }catch (IOException e) {
            System.err.println("Error updating file log");
            System.exit(2);
        }
            
        this.pilotState=newPilotState.toString();
		if (!noLog){
			this.updateFileLog();
		}
    }
        
    /**
     * Updates hostess state and writes, if needed, the changes in the logging file
     * @param newHostessState
     * @param noLog
     */
    public synchronized void updateHostessState(HostessState newHostessState, boolean noLog){
	
        try {
            FileWriter fileWriter = new FileWriter(logFilePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            
            if(newHostessState.toString().equals("CKPS")&& !hostessState.equals("CKPS") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: passenger %d checked. \n",
                    this.currentFlight, currentPass
                ));
            }
            if(newHostessState.toString().equals("RDTF")&& !hostessState.equals("RDTF") ){
                bufferedWriter.write(
                String.format(
                 "\nFlight %d: departed with %d passengers. \n",
                    this.currentFlight-1, flights[currentFlight-1]
                ));
            }
                
            bufferedWriter.close();
            fileWriter.close();
            
            }catch (IOException e) {
                System.err.println("Error updating file log");
                System.exit(2);
            }
        
        
        this.hostessState=newHostessState.toString();
		if (!noLog){
			this.updateFileLog();
		}
    }
        
    /**
     * Updates passenger state and writes, if needed, the changes in the logging file
     * @param newPassengerState
     * @param ID
     * @param noLog
     */
    public synchronized void updatePassengerState(PassengerState newPassengerState, int ID, boolean noLog){
        if(newPassengerState.toString().equals(passengerState[ID-1])){
            noLog=true;
        }
        this.passengerState[ID-1]=newPassengerState.toString();
		if (!noLog){
			this.updateFileLog();
		}
    }
    
    /**
     * Adds a passenger to the waiting queue
     * @param passengerId
     * @param noLog
     */
    public synchronized void addToWaitingQueue(int passengerId, boolean noLog) {
	
        waitingQueue.add(passengerId);
        this.InQ++;
            
    }
    
    /**
     * Removes the head passenger of the waiting queue
     * @param noLog
     * @return
     */
    public synchronized int removeFromWaitingQueue(boolean noLog) {
	
        this.InQ--;
		if (!noLog){
			this.updateFileLog();
		}
        currentPass = waitingQueue.poll();
        return currentPass;
    }
        
   /**
    * Adds 1 to the total of passengers transported in a flight, and to the currently in flight (InF) variable
    * @param flight
    * @param noLog
    */
    public synchronized void addToFlight ( int flight, boolean noLog){
        flights[flight] = flights[flight] +1;
        InF++;
        if (!noLog){
        	this.updateFileLog();
        }
    }
    
    /**
     * Removes 1 to the currently in flight (InF) variable
     * @param flight
     * @param noLog
     */
    public synchronized void removeFromFlight ( int flight, boolean noLog){
       
        InF--;
        if(!noLog){
        	this.updateFileLog();
        }
    }
    
    /**
     * Increments number of total passengers transported
     */
    public synchronized void IncTotalPassTrasported (){
        this.PTAL++;  
    }
    
    /**
     * Getter for the PTAL variable
     * @return 
     */
    public synchronized int totalPassTransported(){
        return PTAL;
    }
   
    /**
     * Getter for the InF variable
     * @return
     */
    public synchronized int getInFlight() {
        return InF;
    }
    
    /**
     * Getter for the InQ variable
     * @return
     */
    public synchronized int getInQueue() {
    	return InQ;
    }
    
    /**
     * Returns number of passengers transported in a given flight
     * @param flight
     * @return
     */
    public synchronized int getPassengersBoarded(int flight) {
    	return this.flights[flight];
    }
    
    /**
     * Getter for the currentFlight variable
     * @return
     */
    public synchronized int getCurrentFlight() {
            return currentFlight;
    }
    
    /**
     * Setter for the currentFlight variable
     * @param currentFlight
     */
    public synchronized void setCurrentFlight(int currentFlight) {       
            this.currentFlight = currentFlight;   
    }

    /**
     * Getter for the canTakeOff variable
     * @return
     */
	public boolean isCanTakeOff() {
		return canTakeOff;
	}

	/**
	 * Setter for the canTakeOff variable
	 * @param canTakeOff
	 */
	public void setCanTakeOff(boolean canTakeOff) {
		this.canTakeOff = canTakeOff;
	}

}
