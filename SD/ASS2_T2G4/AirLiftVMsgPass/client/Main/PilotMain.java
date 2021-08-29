package client.Main;

import client.entities.Pilot;
import client.stubs.DepartureStub;
import client.stubs.DestinationStub;
import client.stubs.PlaneStub;

/**
 * Hostess main class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class PilotMain {
    public static void main(String[] args) {
            
            DepartureStub departure = new DepartureStub();
            
            PlaneStub plane = new PlaneStub();
            
            DestinationStub dest = new DestinationStub();
            
            Pilot pilot = new Pilot(departure, plane,dest);
            
            pilot.start();
            try {
                pilot.join();
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            dest.closeStub();
            plane.closeStub();
            
            departure.closeStub();

        }
    
}
