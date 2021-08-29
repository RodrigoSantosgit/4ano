echo "Transfering data to the general repository node."
sshpass -p passwordqwerty ssh sd204@l040101-ws01.ua.pt 'mkdir -p Assignment2/AirLift'
sshpass -p passwordqwerty ssh sd204@l040101-ws01.ua.pt 'rm -rf Assignment2/AirLift/*'
sshpass -p passwordqwerty scp dirGeneralRepos.zip sd204@l040101-ws01.ua.pt:Assignment2/AirLift
echo "Decompressing data sent to the general repository node."
sshpass -p passwordqwerty ssh sd204@l040101-ws01.ua.pt 'cd Assignment2/AirLift ; unzip -uq dirGeneralRepos.zip'
echo "Executing program at the server general repository."
sshpass -p passwordqwerty ssh sd204@l040101-ws01.ua.pt 'cd Assignment2/AirLift/dirGeneralRepos ; java server.Main.GeneralRepositoryMain '
echo "Server shutdown."
sshpass -p passwordqwerty ssh sd204@l040101-ws01.ua.pt 'cd Assignment2/AirLift/dirGeneralRepos ; less stat'
