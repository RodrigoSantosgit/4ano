package server.sharedregions.Repository;


import Common.States;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

/**
 * General Repository Logger class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class GeneralRepository {
	
	/**
	 * Log File Name
	 */
    private String logFilePath = "log.txt"; 
    
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
     * GeneralRepository constructor method
     */
	public GeneralRepository() {
		this.InQ = 0;
		this.InF = 0;
		this.PTAL = 0;
        this.passengerState = new String[21];
        
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
                this.passengerState[p] = States.GOING_T0_AIRPORT.toString();
            }
            this.pilotState = States.AT_TRANSFER_GATE.toString();
            this.hostessState = States.WAIT_FOR_FLIGHT.toString();
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
    public void finish(int [] flights){
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
    public void updateFileLog() {
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
    public synchronized void updatePilotState(States newPilotState, boolean noLog, int currentFlight){
    	try {
            
            FileWriter fileWriter = new FileWriter(logFilePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            
            if(newPilotState.toString().equals("RDFB")&& !pilotState.equals("RDFB") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: boarding started. \n",
                        currentFlight
                ));
            }
            if(newPilotState.toString().equals("DRPP")&& !pilotState.equals("DRPP") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: arrived. \n",
                        currentFlight-1
                ));
            }
            if(newPilotState.toString().equals("FLBK")&& !pilotState.equals("FLBK") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: returning. \n",
                        currentFlight-1
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
    public synchronized void updateHostessState(States newHostessState, boolean noLog, int currentPass, int currentFlight, int[] flights){
	
        try {
            FileWriter fileWriter = new FileWriter(logFilePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            
            if(newHostessState.toString().equals("CKPS")&& !hostessState.equals("CKPS") ){
                bufferedWriter.write(
                String.format(
                "\nFlight %d: passenger %d checked. \n",
                    currentFlight, currentPass
                ));
            }
            if(newHostessState.toString().equals("RDTF")&& !hostessState.equals("RDTF") ){
                bufferedWriter.write(
                String.format(
                 "\nFlight %d: departed with %d passengers. \n",
                    currentFlight-1, flights[currentFlight-1]
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
    public synchronized void updatePassengerState(States newPassengerState, int ID, boolean noLog){
        if(newPassengerState.toString().equals(passengerState[ID])){
            noLog=true;
        }
        this.passengerState[ID]=newPassengerState.toString();
		if (!noLog){
			this.updateFileLog();
		}
    }
 
    /**
     * Increment InQ variable by 1 unit
     */
    public synchronized void addInQ() {
    	
    	this.InQ++;
    	
    }

    /**
     * Decrement InQ variable by 1 unit
     */
    public synchronized void removeInQ() {
    	
    	this.InQ--;
    	
    }
  
   /**
    * Adds 1 to the currently in flight (InF) variable
    
    * @param noLog
    */
    public synchronized void addToFlight ( boolean noLog){
        InF++;
        if (!noLog){
        	this.updateFileLog();
        }
    }
    
    /**
     * Removes 1 to the currently in flight (InF) variable
     
     * @param noLog
     */
    public synchronized void removeFromFlight ( boolean noLog){
       
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
    /*public synchronized int getInFlight() {
        return InF;
    }*/
    
    /**
     * Getter for the InQ variable
     * @return
     */
    public synchronized int getInQueue() {
    	return InQ;
    }

}
