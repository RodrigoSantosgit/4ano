package server.sharedregions;

import Common.Message;
import Common.MessageType;
import server.entities.CommunicationProvider;
import server.sharedregions.DestinationAirport.SR_DestAirport;

/**
 * DestinationAirport proxy for the server
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_DestinationAirportProxy implements SharedMemoryProxy{

	/**
     * Destination Airport
     * 
     * @serialField
     */
    private final SR_DestAirport destinationAirport;

    /**
     * Simulation status
     * 
     * @serialField
     */
    private int finished;
    
    /**
     * Constructor method for SR_DestinationAirportProxy
     * @param destinationAirport
     */
    public SR_DestinationAirportProxy(SR_DestAirport destinationAirport) {
        this.destinationAirport = destinationAirport;
        this.finished = 0;
    }
	
    /**
     * Verify if the simulation has ended
     * @return TRUE if simulation finished
     */
	@Override
	public boolean hasSimEnded() {
		return finished==2;
	}

	/**
     * Message processor
     * 
     * @param pkt message from clients
     * @return reply to message
     */
	@Override
	public Message proccesPacket(Message pkt) {
		
		Message reply = new Message();
		CommunicationProvider provider = (CommunicationProvider) Thread.currentThread();
		System.out.println("Got message of type " + pkt.getType());
		
		switch (pkt.getType()) {
		
			case PASSENGER_LEAVING_PLANE:
                            provider.setEntityID(pkt.getId());
                            provider.setEntityState(pkt.getState());
                            destinationAirport.leaveThePlane();
                            //reply.setState(States.AT_DESTINATION);
                            reply.setState(provider.getEntityState());
                            break;
                        case GET_PTAL:
                            
                            reply.setInt1(destinationAirport.getPTAL());
                            reply.setType(MessageType.OK);
                            //System.out.println(reply);
                            break;
				
			case SIM_ENDED:
                            this.finished ++;
                            System.out.println(finished);
                            /*if (finished==3) {
                                destinationAirport.exit();
                            }*/
                            reply.setType(MessageType.OK);
                            break;
                
			default:
				
				throw new RuntimeException("Unknown operation in message: " + pkt.getType());
		
		}
		
		return reply;
	}

	
	
}
