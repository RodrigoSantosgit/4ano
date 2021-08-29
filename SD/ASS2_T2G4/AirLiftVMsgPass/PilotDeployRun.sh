echo "Transfering data to the Pilot node."
sshpass -p passwordqwerty ssh sd204@l040101-ws05.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws05.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirPilot.zip sd204@l040101-ws05.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Pilot node."
sshpass -p passwordqwerty ssh sd204@l040101-ws05.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirPilot.zip'
echo "Executing program at the client Pilot."
sshpass -p passwordqwerty ssh sd204@l040101-ws05.ua.pt 'cd Assignment2/AirLift/dirPilot ; java client.Main.PilotMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws05.ua.pt 'cd Assignment2/AirLift/dirPilot ; less stat'
