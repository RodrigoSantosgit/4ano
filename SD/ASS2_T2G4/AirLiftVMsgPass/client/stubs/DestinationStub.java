package client.stubs;


import Common.Message;
import Common.MessageType;
import Common.RunParameters;
import Common.ClientCom;

/**
 * DepartureStub class 
 * 
 * Departure Airport Stub - implements an interface for the clients to interact with
 * the departure airport from a safe distance
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class DestinationStub  {
	
	/**
	 * Constructor for the DestinationStub class
	 */
	public DestinationStub(){
	}

	/**
	 * Passenger method to leave the plane 
     * 
     * Puts passenger in AT_DESTINATION state.
     * Last method of the passenger life-cycle
	 */
    public void leaveThePlane(){
        ClientCom clientCom = new ClientCom(RunParameters.DestinationHostName, RunParameters.DestinationPort);
        while (!clientCom.open()) {
                System.out.println("Destination not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        client.entities.Passenger passenger = (client.entities.Passenger) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PASSENGER_LEAVING_PLANE);
        pkt.setId(passenger.getID());
        

        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.printf("Passgr %d rcv msg from leavethe plane", passenger.getID());
        System.out.println(pkt);
        passenger.setPassengerState(pkt.getState());
        
        clientCom.close();
   
    }
    
    /**
     * Request Destination server for the PTAL value
     * @return PTAL, total number of passengers transported 
     */
    public int getPTAL() {
        
	ClientCom clientCom = new ClientCom(RunParameters.DestinationHostName, RunParameters.DestinationPort);
        
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
        pkt.setType(MessageType.GET_PTAL);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        int PTAL = pkt.getInt1();
        
        clientCom.close();
        return PTAL;
    }
	
    /**
     * Method to close the communication stub of the SR_DestAiport class
     * Used at the end of the simulation
     */
    public void closeStub() {
        ClientCom clientCom = new ClientCom(RunParameters.DestinationHostName, RunParameters.DestinationPort);
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

