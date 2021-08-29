echo "Transfering data to the general repository node."
sshpass -f passwordqwerty ssh sd204@l040101-ws01.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws01.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirGeneralRepos.zip sd204@l040101-ws01.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the general repository node."
sshpass -f passwordqwerty ssh sd204@l040101-ws01.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirGeneralRepos.zip'
echo "Executing program at the server general repository."
sshpass -f passwordqwerty ssh sd204@l040101-ws01.ua.pt 'cd Assignment2/AirLift/dirGeneralRepos ; java server.Main.GeneralRepositoryMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws01.ua.pt 'cd Assignment2/AirLift/dirGeneralRepos ; less stat'


echo "Transfering data to the departure node."
sshpass -f passwordqwerty ssh sd204@l040101-ws02.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws02.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirDeparture.zip sd204@l040101-ws02.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the departure node."
sshpass -f passwordqwerty ssh sd204@l040101-ws02.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirDeparture.zip.zip'
echo "Executing program at the server departure."
sshpass -f passwordqwerty ssh sd204@l040101-ws02.ua.pt 'cd Assignment2/AirLift/dirDeparture ; java server.Main.SR_DepartureAirportMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws02.ua.pt 'cd Assignment2/AirLift/dirDeparture ; less stat'

echo "Transfering data to the Destination node."
sshpass -f passwordqwerty ssh sd204@l040101-ws03.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws03.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirDestination.zip sd204@l040101-ws03.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the destination node."
sshpass -f passwordqwerty ssh sd204@l040101-ws03.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirDestination.zip'
echo "Executing program at the server destination."
sshpass -f passwordqwerty ssh sd204@l040101-ws03.ua.pt 'cd Assignment2/AirLift/dirDestination ; java server.Main.SR_DestinationAirportMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws03.ua.pt 'cd Assignment2/AirLift/dirDestination ; less stat'



echo "Transfering data to the Plane node."
sshpass -f passwordqwerty ssh sd204@l040101-ws04.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws04.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirPlane.zip sd204@l040101-ws04.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Plane node."
sshpass -f passwordqwerty ssh sd204@l040101-ws04.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirPlane.zip'
echo "Executing program at the server Plane."
sshpass -f passwordqwerty ssh sd204@l040101-ws04.ua.pt 'cd Assignment2/AirLift/dirPlane ; java server.Main.SR_PlaneMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws04.ua.pt 'cd Assignment2/AirLift/dirPlane ; less stat'


echo "Transfering data to the Pilot node."
sshpass -f passwordqwerty ssh sd204@l040101-ws05.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws05.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirPilot.zip sd204@l040101-ws05.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Pilot node."
sshpass -f passwordqwerty ssh sd204@l040101-ws05.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirPilot.zip'
echo "Executing program at the client Pilot."
sshpass -f passwordqwerty ssh sd204@l040101-ws05.ua.pt 'cd Assignment2/AirLift/dirPilot ; java client.PilotMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws05.ua.pt 'cd Assignment2/AirLift/dirPilot ; less stat'

echo "Transfering data to the Hostess node."
sshpass -f passwordqwerty ssh sd204@l040101-ws06.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws06.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirHostess.zip sd204@l040101-ws06.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Hostess node."
sshpass -f passwordqwerty ssh sd204@l040101-ws06.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirHostess.zip'
echo "Executing program at the client Hostess."
sshpass -f passwordqwerty ssh sd204@l040101-ws06.ua.pt 'cd Assignment2/AirLift/dirHostess ; java client.HostessMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws06.ua.pt 'cd Assignment2/AirLift/dirHostess ; less stat'


echo "Transfering data to the Passenger node."
sshpass -f passwordqwerty ssh sd204@l040101-ws07.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass f passwordqwerty ssh sd204@l040101-ws07.ua.pt 'rm -rf Assignment2/AirLift*'
sshpass -f passwordqwerty scp dirPassenger.zip sd204@l040101-ws07.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Passenger node."
sshpass -f passwordqwerty ssh sd204@l040101-ws07.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirPassenger.zip'
echo "Executing program at the client Passenger."
sshpass -f passwordqwerty ssh sd204@l040101-ws07.ua.pt 'cd Assignment2/AirLift/dirPassenger ; java client.PassengerMain '
echo "Server shutdown."
sshpass -f passwordqwerty ssh sd204@l040101-ws07.ua.pt 'cd Assignment2/AirLift/dirPassenger ; less stat'











