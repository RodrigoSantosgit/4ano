package server.sharedregions;

import Common.Message;
import Common.MessageType;
import server.sharedregions.Repository.GeneralRepository;

/**
 * General Repository Proxy class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class GeneralRepositoryProxy implements SharedMemoryProxy {

    /**
     * Repository 
     */
    private final GeneralRepository repository;

    /**
     * Simulation status
     */
    private int finished;

    /**
     * RepositoryProxy Constructor method
     * 
     * @param repository
     */
    public GeneralRepositoryProxy(GeneralRepository repository) {
        this.repository = repository;
        this.finished = 0;
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

        System.out.println("Got message of type " + pkt.getType());
        System.out.println("Message: " + pkt.toString());

        switch (pkt.getType()) {
            
            case UPDATE_PILOT_STATE:
                
                repository.updatePilotState(pkt.getState() , pkt.getBool1(), pkt.getInt1());
                break;

            case UPDATE_HOSTESS_STATE:
                repository.updateHostessState(pkt.getState(), pkt.getBool1(), pkt.getInt1(), pkt.getInt2(), pkt.getIntArray1() );
                break;

            case UPDATE_PASSENGER_STATE:
                repository.updatePassengerState(pkt.getState(), pkt.getId(),pkt.getBool1());
                break;

            case UPDATE_INQ:
                if(pkt.getBool1())
                    repository.addInQ();
                else
                    repository.removeInQ();
                break;

            case UPDATE_INF:
                
                if(pkt.getBool1())
                    repository.addToFlight( pkt.getBool2());
                else
                    repository.removeFromFlight( pkt.getBool2());
                break;

            case UPDATE_PTAL:
                repository.IncTotalPassTrasported();
                break;

            case SIM_ENDED:
                this.finished++;
                System.out.println(finished);
                break;
            
            case FINISH:
                repository.finish(pkt.getIntArray1());
                break;

            default:
                throw new RuntimeException("Wrong operation in message: " + pkt.getType());
        }
        reply.setType(MessageType.OK);
        reply.setBool1(true);
        //System.out.println("[GRProxy]Returning");
        return reply;
    }

    /**
     * Verify if the simulation has ended
     */
    public boolean hasSimEnded() {
        return this.finished == 3;
    }
}