package client.Main;

import client.entities.Hostess;
import client.stubs.DepartureStub;
import client.stubs.DestinationStub;

/**
 * Hostess main class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class HostessMain {
        public static void main(String[] args) {
            
            DepartureStub departure = new DepartureStub();
            DestinationStub destination =  new DestinationStub();
            Hostess hostess = new Hostess(departure, destination);
            
            hostess.start();
            try {
                hostess.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            destination.closeStub();
            departure.closeStub();
            
        }
}
