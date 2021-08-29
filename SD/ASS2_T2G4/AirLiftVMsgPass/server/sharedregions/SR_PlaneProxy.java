package server.sharedregions;


import Common.Message;
import Common.MessageType;
import server.entities.CommunicationProvider;
import server.sharedregions.Plane.SR_Plane;

/**
 * Plane proxy for the server
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_PlaneProxy implements SharedMemoryProxy{

	/**
     * Plane
     * 
     * @serialField
     */
    private final SR_Plane plane;

    /**
     * Simulation status
     * 
     * @serialField
     */
    private int finished;
    
    /**
     * SR_PlaneProxy Constructor method
     * 
     * @param plane
     */
    public SR_PlaneProxy(SR_Plane plane) {
        this.plane = plane;
        this.finished = 0;
    }
	
    /**
     * Verify if the simulation has ended
     * @return TRUE if simulation finished
     */
	@Override
	public boolean hasSimEnded() {
		return finished==1;
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
		
			case PILOT_FLYING_FORWARD:
				provider.setEntityState(pkt.getState());
				plane.flyToDestinationPoint();
				//reply.setState(States.FLYING_FORWARD);
                                reply.setState(provider.getEntityState());
				break;
				
			case PILOT_DEBOARDING:
                                provider.setEntityState(pkt.getState());
				plane.announceArrival();
				
                                //reply.setState(States.DEBOARDING);
				reply.setState(provider.getEntityState());
                                break;
				
			case PILOT_FLYING_BACK:
				plane.flyToDeparturePoint();
				//reply.setState(States.FLYING_BACK);
                                reply.setState(provider.getEntityState());
				break;
				
			case PASSENGER_IN_FLIGHT:
                                provider.setEntityState(pkt.getState());
                                provider.setEntityID(pkt.getId());
				plane.waitForEndOfFlight();
				//reply.setState(States.IN_FLIGHT);
                                reply.setState(provider.getEntityState());
				break;
                        case SET_PLANE_EMPTY:
				plane.setPlaneEmpty(pkt.getBool1());
				reply.setType(MessageType.OK);
				break;        
                        
				
			case SIM_ENDED:
                            this.finished++;
                            System.out.printf("Plane proxy finished == %d",finished);
                            reply.setType(MessageType.OK);
                            /*if (finished) {
                                //departureAirport.exit();
                            }*/
                            break;
                
			default:
				
				throw new RuntimeException("Unknown operation in message: " + pkt.getType());
		
		}
		
		return reply;
	}

}
