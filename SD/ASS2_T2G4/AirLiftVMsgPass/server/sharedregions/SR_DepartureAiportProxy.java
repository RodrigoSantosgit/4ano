package server.sharedregions;

import server.sharedregions.DepartureAirport.SRDepartureAirport;
import Common.Message;
import Common.MessageType;
import server.entities.CommunicationProvider;

/**
 * DepartureAirport proxy for the server
 * 
 * @author Rodrigo Santos
 * @author Alexey Kononov
 */
public class SR_DepartureAiportProxy implements SharedMemoryProxy{

	/**
     * Departure Airport
     * 
     * @serialField
     */
    private final SRDepartureAirport departureAirport;

    /**
     * Simulation status
     * 
     * @serialField
     */
    private int finished;
    
    /**
     * SR_DepartureAiportProxy constructor class
     * @param departureAirport
     */
    public SR_DepartureAiportProxy(SRDepartureAirport departureAirport) {
        this.departureAirport = departureAirport;
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
		System.out.println(pkt);
		switch (pkt.getType()) {
			
			case PILOT_INFORM_READY_FOR_BOARDING:
                            provider.setEntityState(pkt.getState());
                            departureAirport.informPlaneReadyForBoarding();
                            //reply.setState(States.READY_FOR_BOARDING);
                            reply.setState(provider.getEntityState());
                            
                            break;
			
			case PILOT_WAITING_FOR_BOARDING:
				provider.setEntityState(pkt.getState());
				departureAirport.waitForAllInBoard();
				//reply.setState(States.WAITING_FOR_BOARDING);
                                reply.setState(provider.getEntityState());
				break;
		
			case HOSTESS_PREPARE_FOR_PASS_BOARDING:
				provider.setEntityState(pkt.getState());
				departureAirport.prepareForPassBoarding();
				//reply.setState(States.WAIT_FOR_PASSENGER);
				reply.setState(provider.getEntityState());
                                break;
				
			case HOSTESS_CHECK_PASSENGER:
				provider.setEntityState(pkt.getState());
				departureAirport.checkDocuments();
				//reply.setState(States.CHECK_PASSENGER);
				reply.setState(provider.getEntityState());
                                break;
				
			case HOSTESS_WAITING_FOR_PASSENGER:
				provider.setEntityState(pkt.getState());
				departureAirport.waitForNextPassenger();
				//reply.setState(States.WAIT_FOR_PASSENGER);
				reply.setState(provider.getEntityState());
                                break;
				
			case HOSTESS_INFORM_READY_TO_FLY:
				provider.setEntityState(pkt.getState());
				departureAirport.informPlaneReadyToTakeOff();
				//reply.setState(States.READY_TO_FLY);
				reply.setState(provider.getEntityState());
                                break;
				
			case HOSTESS_WAITING_FOR_FLIGHT:
				provider.setEntityState(pkt.getState());
				departureAirport.waitForNextFlight();
				
                                //reply.setState(States.WAIT_FOR_FLIGHT);
				reply.setState(provider.getEntityState());
                                break;
				
			case PASSENGER_GOING_TO_AIRPORT:
				provider.setEntityState(pkt.getState());
                                provider.setEntityID(pkt.getId());
				departureAirport.travelToAirport(pkt.getInt1());
				
                                //reply.setState(States.GOING_T0_AIRPORT);
				reply.setState(provider.getEntityState());
                                reply.setId(provider.getEntityID());
                                break;
				
			case PASSENGER_WAITS_IN_QUEUE:
				provider.setEntityState(pkt.getState());
                                provider.setEntityID(pkt.getId());
                                System.out.println("[DEP_PROX] before waitinQueue");
				departureAirport.waitInQueue();
				//reply.setState(States.IN_QUEUE);
				reply.setState(provider.getEntityState());
                                break;
				
			case PASSENGER_SHOW_DOCS:
				provider.setEntityState(pkt.getState());
                                provider.setEntityID(pkt.getId());
				departureAirport.showDocuments();
				
                                //reply.setState(States.IN_QUEUE);
				reply.setState(provider.getEntityState());
                                break;
				
			case PILOT_PARKING_AT_GATE:
				provider.setEntityState(pkt.getState());
				departureAirport.parkAtTransferGate();
				reply.setState(provider.getEntityState());
                                //reply.setState(States.AT_TRANSFER_GATE);
				break;
				
			case PASSENGER_BOARDING_PLANE:
				provider.setEntityState(pkt.getState());
                                provider.setEntityID(pkt.getId());
				departureAirport.boardThePlane();
				//reply.setState(States.IN_FLIGHT);
				reply.setState(provider.getEntityState());
                                break;
                        case GET_FLIGHT:
				reply.setInt1(departureAirport.getFlight());
				break;
                        case GET_IN_FLIGHT:
                            reply.setInt1(departureAirport.getInFlight());
                            break;
                        case SET_IN_FLIGHT:
                            departureAirport.setInFlight(pkt.getInt1());
                            reply.setType(MessageType.OK);
                            break;
                        case CAN_TAKE_OFF:
                            
                            reply.setBool1(departureAirport.isCanTakeOff()); 
                            break;
				
			case SIM_ENDED:
                            //this.finished = true;
                            /*if (finished) {
                                departureAirport.exit();
                            }*/
                            this.finished++;
                            System.out.println(finished);
                            reply.setType(MessageType.OK);
                            break;
                
			default:
				throw new RuntimeException("Unknown operation in message: " + pkt.getType());
				
		}
		
		return reply;
	}

	
	
}
