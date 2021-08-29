echo "Transfering data to the Hostess node."
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'mkdir -p Assignment2'
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirHostess.zip sd204@l040101-ws06.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the Hostess node."
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirHostess.zip'
echo "Executing program at the client Hostess."
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'cd Assignment2/AirLift/dirHostess ; java client.Main.HostessMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws06.ua.pt 'cd Assignment2/AirLift/dirHostess ; less stat'

