
echo "Transfering data to the Passenger node."
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'mkdir -p Assignment2'
sshpass -p passwordqwerty ssh sd204@l040101-ws07.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws07.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirPassenger.zip sd204@l040101-ws07.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Passenger node."
sshpass -p passwordqwerty ssh sd204@l040101-ws07.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirPassenger.zip'
echo "Executing program at the client Passenger."
sshpass -p passwordqwerty ssh sd204@l040101-ws07.ua.pt 'cd Assignment2/AirLift/dirPassenger ; java client.Main.PassengerMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws07.ua.pt 'cd Assignment2/AirLift/dirPassenger ; less stat'



