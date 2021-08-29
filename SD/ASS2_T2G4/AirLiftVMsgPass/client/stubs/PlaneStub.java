package client.stubs;

import Common.Message;
import Common.MessageType;
import Common.RunParameters;
import Common.ClientCom;
import client.entities.Passenger;
import client.entities.Pilot;


/**
 * PlaneStub class 
 * 
 * Plane Stub - implements an interface for the clients to interact with
 * the plane from a safe distance
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class PlaneStub {
	
	/**
	 * Constructor for PlaneStub class
	 */
    public PlaneStub(){
    }
	
    /* Methods */
    
    /**
	 * Pilot method to fly to destination airport 
	 * Puts Pilot in FLYING_FORWARD state.
	 * Pilot is put to sleep for random time interval
	 */
    public void flyToDestinationPoint(){
        ClientCom clientCom = new ClientCom(RunParameters.PlaneHostName, RunParameters.PlanePort);
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Pilot pilot = (Pilot) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PILOT_FLYING_FORWARD);
        pkt.setState(pilot.getPilotState());

        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();

        pilot.setPilotState(pkt.getState());
        clientCom.close();
        
        
       
    }
     
    /**
	 * Pilot method to announce the arrival at the destination airport 
	 * Puts Pilot in DEBOARDING state. 
	 * Pilot waits until all passengers have left the plane
	 */
    public void announceArrival() {
        ClientCom clientCom = new ClientCom(RunParameters.PlaneHostName, RunParameters.PlanePort);
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Pilot pilot = (Pilot) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PILOT_DEBOARDING);
        pkt.setState(pilot.getPilotState());

        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();

        pilot.setPilotState(pkt.getState());
        clientCom.close();
        
	}
    
    /**
	 * Pilot method to fly back to the departure airport
	 * Puts Pilot in FLYING_BACK state.
	 * Pilot is put to sleep for a random time interval
	 */
   	public void flyToDeparturePoint(){
            ClientCom clientCom = new ClientCom(RunParameters.PlaneHostName, RunParameters.PlanePort);
            while (!clientCom.open()) {
                    System.out.println("Plane not active yet, sleeping for 1 seccond");
                    try {
                            Thread.sleep(1000);
                    } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                    }
            };

            Pilot pilot = (Pilot) Thread.currentThread();
            Message pkt = new Message();
            pkt.setType(MessageType.PILOT_FLYING_BACK);
            pkt.setState(pilot.getPilotState());

            clientCom.writeObject(pkt);
            pkt = (Message) clientCom.readObject();

            pilot.setPilotState(pkt.getState());
            clientCom.close();
            
        }
   	
    /**
	 * Passenger method to wait for the flight to end
	 * Puts Passenger in IN_FLIGHT state.
	 */
    public void waitForEndOfFlight(){
        ClientCom clientCom = new ClientCom(RunParameters.PlaneHostName, RunParameters.PlanePort);
 
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Passenger passenger = (Passenger) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PASSENGER_IN_FLIGHT);
        pkt.setId(passenger.getID());
        
        System.out.println("[PLANE STUb] send msg:");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();

        passenger.setPassengerState(pkt.getState());
        
        clientCom.close();
  
    }
    
    /**
     * Method to set the state of the plane, empty or not empty
     * @param set
     */
    public void setPlaneEmpty(boolean set){
        ClientCom clientCom = new ClientCom(RunParameters.PlaneHostName, RunParameters.PlanePort);
 
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        //Passenger passenger = (Passenger) Thread.currentThread();
        Message pkt = new Message();
        System.out.println("SENDING MSG SET_PLANE_EMPTY");
        pkt.setType(MessageType.SET_PLANE_EMPTY);
        pkt.setBool1(set);
        

        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("[PLANE STUB set empty] : ");
        System.out.println(pkt);
  
        clientCom.close();

    }
    
    /**
     * Method to close the communication stub of the SR_Plane class
     * Used at the end of the simulation
     */
    public void closeStub() {
        ClientCom clientCom = new ClientCom(RunParameters.PlaneHostName, RunParameters.PlanePort);
 
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
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
