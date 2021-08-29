package server.sharedregions;

import Common.Message;

/**
 * Shared Memory Proxy class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public interface SharedMemoryProxy {

    /**
     * Generic method to proccess a packet and generate a reply
     * 
     * @param pkt received message
     * @return reply
     */
    public Message proccesPacket(Message pkt);

    /**
     * Generic method to check if the simulation has ended
     * 
     * @return has simulation ended
     */
    public boolean hasSimEnded();
}
