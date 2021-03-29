package l34.labproject.planeTracker.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.LinkedList;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AllVectors {

    private int time;
    private List<List> states;
    @JsonIgnore
    private List<Flight> parsed_flights;

    public AllVectors() {

    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public List<Flight> getStates() {
        return parsed_flights;
    }

    public void setStates(List<List> states) {
        // Parsing the states from a list of generics into a list of state objects

        parsed_flights = new LinkedList<>();
        for (List state : states ) {
            parsed_flights.add(new Flight(state));
        }

        //this.parsed_flights = parsed_flights;
        this.states = states;
    }

    @Override
    public String toString() {
        return "State{" +
                "time='" + time + '\'' +
                ", value=" + states +
                '}';
    }
}