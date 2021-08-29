echo "Transfering data to the Plane node."
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'mkdir -p Assignment2'
sshpass -p passwordqwerty ssh sd204@l040101-ws04.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws04.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirPlane.zip sd204@l040101-ws04.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Plane node."
sshpass -p passwordqwerty ssh sd204@l040101-ws04.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirPlane.zip'
echo "Executing program at the server Plane."
sshpass -p passwordqwerty ssh sd204@l040101-ws04.ua.pt 'cd Assignment2/AirLift/dirPlane ; java server.Main.SR_PlaneMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws04.ua.pt 'cd Assignment2/AirLift/dirPlane ; less stat'

