package server.entities;

import Common.ServerCom;

import Common.Message;
import Common.States;
import server.sharedregions.SharedMemoryProxy;


public class CommunicationProvider extends Thread {

/**
 * Provides the necessary channels to redirect the messages in order to be
 * unwrapped and processed.
 * 
 * @author Alexey Kononov
 * @author Rodrigo Santos
 * 
 */
    /**
     * Shared Memory Proxy Interface, generic to all proxies
     * 
     * @serialField sharedMemory
     */
    private SharedMemoryProxy sharedMemory;

    /**
     * Server communication channel
     * 
     * @serialField serverCom
     */
    private ServerCom serverCom;

    /**
     * Entity state
     * 
     * @serialField state
     */
    private States state;

    /**
     * Entity ID
     * 
     * @serialField entityID
     */
    private int entityID;

    /**
     * Current flight being simulated
     * 
     * @serialField flightID
     */
    private int flightID;

    /**
     * Tunnel Provider constructor method
     * 
     * @param sharedMemory shared memory corresponding to this provider
     * @param serverCom    coms channel corresponding to the target
     */
    public CommunicationProvider(SharedMemoryProxy sharedMemory, ServerCom serverCom) {
        this.sharedMemory = sharedMemory;
        this.serverCom = serverCom;
    }

    /**
     * Wait and send method for the shared memory
     */
    @Override
    public void run() {
        
            try {
            Message rcv = (Message) serverCom.readObject();
            //System.out.println("[PROVIDER] rcv message: ");
            //System.out.println(rcv);
            if (rcv != null) {
                Message snd = (Message)sharedMemory.proccesPacket(rcv);
                System.out.println("[PROVIDER] snd message: ");
                System.out.println(snd);
                serverCom.writeObject(snd);
                serverCom.close();
            } else {
                System.out.println("Received no message");
            }
        } catch (NullPointerException e) {
            // System.err.println("Nothing connected");
        } catch (Exception e) {
            System.err.println("Exception");
        }
        

    }

    /**
     * Return the state of the current entity
     * 
     * @return entity state
     */
    public States getEntityState() {
        return this.state;
    }

    /**
     * Set current entity state
     * 
     * @param state entity state
     */
    public void setEntityState(States state) {
        this.state = state;
    }

    /**
     * Get entity ID
     * 
     * @return entity ID
     */
   
    public int getEntityID() {
        return this.entityID;
    }

    /**
     * Set entity ID
     * 
     * @param id entity ID
     */
    public void setEntityID(int id) {
        this.entityID = id;
    }

  
}
