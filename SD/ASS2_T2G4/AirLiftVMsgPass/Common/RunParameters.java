package Common;

import java.util.Date;

/**
 * RunParameters class 
 *
 * Simulation global variables initialization
 * @author Rodrigo Santos 
 * @author Alexey Kononov
 */
public class RunParameters {

    
    /**
     * Number of min passengers arriving in each plane
     */
    public static final int MIN = 5;

    /**
     * Number of max passengers arriving in each plane
     */
    public static final int MAX = 10;

    public static final int N = 21;

    /**
     * Log filename
     */
    public static final String logFile = "log.txt";

    

    /**
     * Departure airport Port
     */
    public static final int DeparturePort = 22232;

    /**
     * Departure airport Hostname
     */
    public static final String DepartureHostName = "l040101-ws02.ua.pt";

    /**
     * Destination airport Port
     */
    public static final int DestinationPort = 22233;

    /**
     * Destination airport hostname
     */
    public static final String DestinationHostName = "l040101-ws03.ua.pt";

    /**
     * Plane port
     */
    public static final int PlanePort = 22234;

    /**
     * Plane hostname
     */
    public static final String PlaneHostName = "l040101-ws04.ua.pt";
    
    /**
     * General Repository Port
     */
    public static final int GeneralRepositoryPort = 22231;

    /**
     * General Repository Hostname
     */
    public static final String GeneralRepositoryHostName = "l040101-ws01.ua.pt";

    

}
