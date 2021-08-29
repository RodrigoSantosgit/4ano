package client.Main;

/**
 * Passenger main class 
 * 
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
import Common.RunParameters;
import client.entities.Passenger;
import client.stubs.DepartureStub;
import client.stubs.DestinationStub;
import client.stubs.PlaneStub;


public class PassengerMain {
    public static void main(String[] args) {
        DepartureStub departure = new DepartureStub();
        DestinationStub destination = new DestinationStub();
        PlaneStub plane = new PlaneStub();

        Passenger[] passengers = new Passenger[RunParameters.N];

        for (int i = 0; i < RunParameters.N; i++){
            passengers[i] = new Passenger(plane, destination, departure, i);
            passengers[i].start();
        }

        for (Passenger passenger: passengers) {
            try {
                passenger.join();
            } catch (InterruptedException e) {
                System.err.printf("%s interrupted\n", Thread.currentThread().getName());
                e.printStackTrace();
                System.exit(400);
            } catch (Exception e) {
                System.err.printf("%s unknown error, check logs\n", Thread.currentThread().getName());
                e.printStackTrace();
                System.exit(10);
            }
        }
        System.out.println("closing stubs, pass main");
        destination.closeStub();
        plane.closeStub();
        
        departure.closeStub();
        
        
    }
    
}
