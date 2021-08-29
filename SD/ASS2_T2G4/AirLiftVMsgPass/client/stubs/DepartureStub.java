package client.stubs;


import Common.ClientCom;
import Common.Message;
import Common.MessageType;
import Common.RunParameters;
import client.entities.Hostess;
import client.entities.Passenger;
import client.entities.Pilot;

/**
 * DepartureStub class 
 * 
 * Departure Airport Stub - implements an interface for the clients to interact with
 * the departure airport from a safe distance
 *  
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class DepartureStub {

	/**
	 * Constructor for the DepartureStub class
	 */
    public DepartureStub ( ){ }
    
    /**
     * Method to signal hostess that check in can start.
     * Puts pilot in READY_FOR_BOARDING state. 
     */
    public void informPlaneReadyForBoarding(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
                
        Pilot pilot = (Pilot) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PILOT_INFORM_READY_FOR_BOARDING);
        pkt.setState(pilot.getPilotState());
        
        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        
        pilot.setPilotState(pkt.getState());
        clientCom.close();
                
    }
    
    /**
     * Method used to make Pilot wait while passengers are boarding. 
     * Puts pilot in WAITING_FOR_BOARDING state.  
     */
    public void waitForAllInBoard(){
        
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Pilot pilot = (Pilot) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PILOT_WAITING_FOR_BOARDING);
        pkt.setState(pilot.getPilotState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        pilot.setPilotState(pkt.getState());
        clientCom.close();
        
    }
    
    /**
     * Method used to make hostess wait for next flight.
     * Puts hostess in READY_FOR_BOARDING state.
     */
    public void prepareForPassBoarding(){
        
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Hostess hostess = (Hostess) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.HOSTESS_PREPARE_FOR_PASS_BOARDING);
        pkt.setState(hostess.getHostessState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        hostess.setHostessState(pkt.getState());
        clientCom.close();
        
        
    }
    
    /**
     * Method used to make hostess check in passengers from waiting queue and check their documents.
     * Puts hostess in CHECK_PASSENGER state.
     * 
     */
    public void checkDocuments(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Hostess hostess = (Hostess) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.HOSTESS_CHECK_PASSENGER);
        pkt.setState(hostess.getHostessState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        //int current_passangerToCheck = pkt.getInt1() or pkt.getID();
        hostess.setHostessState(pkt.getState());
        clientCom.close();
        //return current_passengerToCheck;
    }
    
    /**
     * Method used to make hostess wait to passenger to show documents, remove him from waiting queue and decide of current flight is ready to take off.
     * Puts hostess in WAIT_FOR_PASSENGER state.
     */
    public void waitForNextPassenger(){
         ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Hostess hostess = (Hostess) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.HOSTESS_WAITING_FOR_PASSENGER);
        pkt.setState(hostess.getHostessState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        
        hostess.setHostessState(pkt.getState());
        //current_passengerToBoard;
        clientCom.close();
        
        
    }
    
    /**
     * Method used to inform Pilot that plane is ready to take off.
     * Puts hostess in READY_TO_FLY state.
     */
    public void informPlaneReadyToTakeOff(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Hostess hostess = (Hostess) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.HOSTESS_INFORM_READY_TO_FLY);
        pkt.setState(hostess.getHostessState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        hostess.setHostessState(pkt.getState());
        
        clientCom.close();
        

    }
    
    /**
    * Method used to make hostess decide wait for pilot to come back and park at transfer gate and proceed to next flight if there is more passengers to be transported
    * Puts hostess in WAIT_FOR_FLIGHT state.
    */
    public void waitForNextFlight(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Hostess hostess = (Hostess) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.HOSTESS_WAITING_FOR_FLIGHT);
        pkt.setState(hostess.getHostessState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        hostess.setHostessState(pkt.getState());
        
        clientCom.close();
        
        
    }
    
    /**
     * Method used to make passenger sleep for a random time simulating a trip to Airport.
     * 
     * @param travelTime 
     */
    public void travelToAirport(int travelTime){ 
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Passenger passenger = (Passenger) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PASSENGER_GOING_TO_AIRPORT);
        pkt.setId(passenger.getID());
        

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        passenger.setPassengerState(pkt.getState());
        
        clientCom.close();
        
       
    }
    
    /**
     * method to add passenger to waiting queue and signal hostess to start check in and wait to passenger's turn to check in.
     * Puts passenger in IN_QUEUE state.
     */
    public void waitInQueue(){ 
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Passenger passenger = (Passenger) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PASSENGER_WAITS_IN_QUEUE);
        pkt.setId(passenger.getID());
        

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        passenger.setPassengerState(pkt.getState());
        
        clientCom.close();
       
    }
    
    /**
     * Method in which passenger waits for his turn to show documents and then shows it.
     * Maintains passenger in IN_QUEUE state.
     */
    public void showDocuments(){ 
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Passenger passenger = (Passenger) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PASSENGER_SHOW_DOCS);
        pkt.setId(passenger.getID());
        

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        passenger.setPassengerState(pkt.getState());
        
        clientCom.close();
        
    }
    
    /**
    * Method to make pilot park at transfer gate after flight and signal hostess to proceed to next flight or finish life cycle.
    * Puts pilot in AT_TRANSFER_GATE state.
    */
    public void parkAtTransferGate(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Pilot pilot = (Pilot) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PILOT_PARKING_AT_GATE);
        pkt.setState(pilot.getPilotState());

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        pilot.setPilotState(pkt.getState());
        clientCom.close();
       
    }
    
    /**
     * Method in which passenger waits to his turn to board the plane and signal hostess when boarded.
     * Puts passenger in IN_FLIGHT state.
     */
    public synchronized void boardThePlane(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
                System.out.println("Departure not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Passenger passenger = (Passenger) Thread.currentThread();
        Message pkt = new Message();
        pkt.setType(MessageType.PASSENGER_BOARDING_PLANE);
        pkt.setId(passenger.getID());
        

        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);

        passenger.setPassengerState(pkt.getState());
        
        clientCom.close();
        
    }
    
    /**
     * Stub method to request the canTakeOff variable value
     * @return canTakeOff, when TRUE Hostess can announce the plane is ready to take
     */
    public boolean isCanTakeOff() {
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
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
        pkt.setType(MessageType.CAN_TAKE_OFF);
        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        boolean canTakeOff = pkt.getBool1();
        clientCom.close();
        return canTakeOff;
    }
    
    /**
     * Stub method the request the server the InF variable value
     * @return InF, number of passengers currently in flight
     */
    public int getInFlight(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
 
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Message pkt = new Message();
        pkt.setType(MessageType.GET_IN_FLIGHT);
        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        
        clientCom.close();
        return pkt.getInt1();
    }
    
    /**
     * Stub method to set the servers InF variable value
     * @param value
     */
    public void setInFlight(int value) throws Exception {
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
 
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Message pkt = new Message();
        pkt.setType(MessageType.SET_IN_FLIGHT);
        pkt.setInt1(value);
        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        try{clientCom.writeObject(pkt);
            pkt = (Message) clientCom.readObject();
        }catch (Exception e){
            e.printStackTrace(System.out);
        }
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        
        clientCom.close();

    }
    
    /**
     * Stub method to request the server for the currentFlight number
     * @return
     */
    public int getFlight(){
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
 
        while (!clientCom.open()) {
                System.out.println("Plane not active yet, sleeping for 1 seccond");
                try {
                        Thread.sleep(1000);
                } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                }
        };
        
        Message pkt = new Message();
        pkt.setType(MessageType.GET_FLIGHT);
        System.out.println("SENDING TO SERVER: ");
        System.out.println(pkt);
        clientCom.writeObject(pkt);
        pkt = (Message) clientCom.readObject();
        System.out.println("RECEIVED FROM SERVER: ");
        System.out.println(pkt);
        
        clientCom.close();
        return pkt.getInt1();
    }
    
    /**
     * Method to close the communication stub of the SR_DestAiport class
     * Used at the end of the simulation
     */
    public void closeStub() {
        ClientCom clientCom = new ClientCom(RunParameters.DepartureHostName, RunParameters.DeparturePort);
        while (!clientCom.open()) {
            System.out.println("Arrival Lounge  not active yet, sleeping for 1 seccond");
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
