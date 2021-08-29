echo "Transfering data to the departure node."
sshpass -p passwordqwerty ssh sd204@l040101-ws02.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws02.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirDeparture.zip sd204@l040101-ws02.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the departure node."
sshpass -p passwordqwerty ssh sd204@l040101-ws02.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirDeparture.zip'
echo "Executing program at the server departure."
sshpass -p passwordqwerty ssh sd204@l040101-ws02.ua.pt 'cd Assignment2/AirLift/dirDeparture ; java server.Main.SR_DepartureAirportMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws02.ua.pt 'cd Assignment2/AirLift/dirDeparture ; less stat'

