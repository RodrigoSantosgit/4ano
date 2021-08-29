package client.stubs;

import Common.Message;
import Common.MessageType;
import Common.RunParameters;
import Common.States;
import Common.ClientCom;

/**
 * GeneralRepositoryStub class 
 * 
 * General Repository Stub - implements an interface for the clients to interact with
 * the general repository from a safe distance
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class GeneralRepositoryStub {
    
	/**
	 * Constructor for the GeneralRepositoryStub class
	 */
	public GeneralRepositoryStub() {
		 
	}

    /**
     * Updates Pilot state and writes, if needed, the changes in the logging file
     * @param newState
     * @param noLog
     * @param currentFlight
     */
    public void updatePilotState(States newState, boolean noLog, int currentFlight){
      
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_PILOT_STATE);
        pkt.setBool1(noLog);
        pkt.setInt1(currentFlight);
        pkt.setState(newState);
        
        clientCom.writeObject(pkt);
       
        pkt = (Message) clientCom.readObject();
        
        clientCom.close();
                
    }
        
    /**
     * Updates hostess state and writes, if needed, the changes in the logging file
     * @param newState
     * @param noLog
     * @param currentPass
     * @param currentFlight
     * @param flights
     */
    public void updateHostessState(States newState, boolean noLog , int currentPass, int currentFlight, int[] flights){
	ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_HOSTESS_STATE);
        pkt.setBool1(noLog);
        pkt.setState(newState);
        pkt.setInt1(currentPass);
        pkt.setInt2(currentFlight);
        pkt.setIntArray1(flights);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    }
        
    /**
     * Updates passenger state and writes, if needed, the changes in the logging file
     * @param newState
     * @param ID
     * @param noLog
     */
    public void updatePassengerState(States newState, int ID, boolean noLog/*, int currentFlight*/){
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_PASSENGER_STATE);
        pkt.setBool1(noLog);
        pkt.setId(ID);
        pkt.setState(newState);
        //pkt.setInt1(currentFlight);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    }
 
    /**
     * Increment InQ variable by 1 unit
     */
    public void addInQ() {
    	ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_INQ);
        pkt.setBool1(true);
        
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    }

    /**
     * Decrement InQ variable by 1 unit
     */
    public synchronized void removeInQ() {
    		ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_INQ);
        pkt.setBool1(false);
        
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    }
    
  
   /**
    * Adds 1 to the currently in flight (InF) variable
    * @param flight
    * @param noLog
    */
    public void addToFlight ( boolean noLog){
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_INF);
        pkt.setBool1(true);
        pkt.setBool2(noLog);
        
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    }
    
    /**
     * Removes 1 to the currently in flight (InF) variable
     * @param flight
     * @param noLog
     */
    public synchronized void removeFromFlight (  boolean noLog){
       
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_INF);
        pkt.setBool1(false);
        pkt.setBool2(noLog);
        
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    }
    
    
    /**
     * Increments number of total passengers transported
     */
    public void IncTotalPassTrasported (){
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
                System.out.println("General Repository not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        }
        Message pkt = new Message();
        pkt.setType(MessageType.UPDATE_PTAL);
        pkt.setBool1(true);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        clientCom.close();
    } 
    
    /**
     * Stub method to send message to the repository requesting the update of the log file
     */
    public void updateFileLog() {
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
            System.out.println("Destination  not active yet, sleeping for 1 seccond");
            try {
                    Thread.sleep(1000);
            } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
            }
        }
        ;
        Message pkt = new Message();
        pkt.setType(MessageType.LOG_UPD);
        clientCom.writeObject(pkt);
        clientCom.readObject();
        clientCom.close();
        
    }
    
    /**
     * Stub method to request the repository to write the last pieces of information and close the log file
     * @param flights
     */
    public void finish(int[] flights){
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
            System.out.println("Destination  not active yet, sleeping for 1 seccond");
            try {
                    Thread.sleep(1000);
            } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
            }
        }
        ;
        Message pkt = new Message();
        pkt.setType(MessageType.FINISH);
        pkt.setIntArray1(flights);
        clientCom.writeObject(pkt);
        clientCom.readObject();
        clientCom.close();
        
    }
    
    /**
     * Method to close the communication stub of the GeneralRepository class
     * Used at the end of the simulation
     */
    public void closeStub() {
        ClientCom clientCom = new ClientCom(RunParameters.GeneralRepositoryHostName, RunParameters.GeneralRepositoryPort);
        while (!clientCom.open()) {
            System.out.println("Destination  not active yet, sleeping for 1 seccond");
            try {
                    Thread.sleep(1000);
            } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
            }
        }
        ;
        Message pkt = new Message();
        pkt.setType(MessageType.SIM_ENDED);
        clientCom.writeObject(pkt);
        clientCom.readObject();
        clientCom.close();
    }

}
