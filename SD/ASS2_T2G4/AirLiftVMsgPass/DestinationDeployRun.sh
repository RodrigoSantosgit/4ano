
echo "Transfering data to the Destination node."
sshpass -p passwordqwerty ssh sd204@l040101-ws03.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws03.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirDestination.zip sd204@l040101-ws03.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the destination node."
sshpass -p passwordqwerty ssh sd204@l040101-ws03.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirDestination.zip'
echo "Executing program at the server destination."
sshpass -p passwordqwerty ssh sd204@l040101-ws03.ua.pt 'cd Assignment2/AirLift/dirDestination ; java server.Main.SR_DestinationAirportMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws03.ua.pt 'cd Assignment2/AirLift/dirDestination ; less stat'

