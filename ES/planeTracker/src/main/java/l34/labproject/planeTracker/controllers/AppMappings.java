package l34.labproject.planeTracker.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import l34.labproject.planeTracker.models.AllVectors;
import l34.labproject.planeTracker.models.Flight;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppMappings {
    
    /* Constants */
    private static final Logger log = LoggerFactory.getLogger(AppMappings.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    /* Instance Fields */
    @Autowired private RestTemplate restTemplate;
    private List<Flight> cache;
    private Date date = new Date();

    /* View Endpoints */
    @GetMapping("/planesInArea")
    public String flights(@RequestParam(name="lamin", required=false, defaultValue = "36.00608") double lamin,
                          @RequestParam(name="lomin", required=false, defaultValue = "-9.54094") double lomin,
                          @RequestParam(name="lamax", required=false, defaultValue = "43.69099") double lamax,
                          @RequestParam(name="lomax", required=false, defaultValue = "3.10004") double lomax,
                          Model model) {

        log.info("PlanesInArea - Arguments (" + lamin + "-" + lomin + "-" + lamax + "-" + lomax + ")" );

        model.addAttribute("lamin", lamin);
        model.addAttribute("lomin", lomin);
        model.addAttribute("lamax", lamax);
        model.addAttribute("lomax", lomax);

        /* Update cache if not previously updated */
        if (cache == null) {
            updateFlights();
        }

        model.addAttribute("time", dateFormat.format(date));
        model.addAttribute("flights", cache);

        return "statesInfo";
    }

    @Scheduled(fixedRate = 15000)
    public void updateFlights() {
        log.warn("[Scheduled Task] The time is now {}", dateFormat.format(new Date()));
        log.info("Updating state cache (repository/database) with OpenSky API Info");

        try {
            /* Get states from API */
            List<Flight> resultsFromAPI = getFlightsFromAPI();
            resultsFromAPI = resultsFromAPI.subList(0, resultsFromAPI.size()/3);
            cache = resultsFromAPI;

            /* Remove old states to avoid database capacity issues */
            /*for (Flight flight : resultsFromAPI) {
                List<Flight> statesToRemove = repository.findBycallsign(flight.getCallsign());
                repository.deleteAll(statesToRemove);
                repository.saveAndFlush(flight);
            }*/

            /* Update database update time */
            date = new Date();

            log.info("Updated state cache (repository/database) with OpenSky API Info");
            log.info(resultsFromAPI.toString());

        } catch (Exception e) {
            log.error("ERROR! Error updating state cache (repository/database) with OpenSky API");
            log.error("API not available (" + e.toString() + ")");
            log.warn("No changes to cache");
        }

        //cache = repository.findAll();
        //cache.sort((o1, o2) -> (int) (o1.getFlightID() - o2.getFlightID()));        // order cache
    }

    private List<Flight> getFlightsFromAPI() {
        log.info("Obtaining list of states from OpenSky API");

        /* Build URL */
        String url = "https://opensky-network.org/api/states/all?lamin=36.00608&lomin=-9.54094&lamax=43.69099&lomax=3.10004";
        UriComponentsBuilder builder =  UriComponentsBuilder.fromHttpUrl(url);
        url = builder.build().toUriString();
        log.info("URL is " + url);

        /* In production
        String url = "https://opensky-network.org/api/states/all";
        UriComponentsBuilder builder =  UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("lamin", model.getAttribute("lamin"))
                .queryParam("lomin", model.getAttribute("lomin"))
                .queryParam("lamax", model.getAttribute("lamax"))
                .queryParam("lomax", model.getAttribute("lomax"));
        url = builder.build().toUriString();
        */

        /* Retrieve results and automatically parse them into a list of Flights */
        AllVectors AllVectors = restTemplate.getForObject(url, AllVectors.class);
        log.info("Success obtaining list of states from OpenSky API");

        return AllVectors.getStates();
    }
}