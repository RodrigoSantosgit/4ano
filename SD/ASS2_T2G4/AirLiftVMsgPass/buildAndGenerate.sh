echo "Compiling source code."

javac -source 8 -target 8 */*/*.java */*.java 

echo "Distributing intermediate code to the different execution environments."
echo "  General Repository of Information"
rm -rf dirGeneralRepos
mkdir -p dirGeneralRepos dirGeneralRepos/server dirGeneralRepos/server/Main dirGeneralRepos/server/entities dirGeneralRepos/server/sharedregions \
         dirGeneralRepos/client dirGeneralRepos/client/entities dirGeneralRepos/Common dirGeneralRepos/server/sharedregions/Repository
		 
cp server/Main/GeneralRepositoryMain.class  dirGeneralRepos/server/Main
cp Common/*.class dirGeneralRepos/Common
cp server/entities/CommunicationProvider.class dirGeneralRepos/server/entities
cp server/sharedregions/GeneralRepositoryProxy$1.class dirGeneralRepos/server/sharedregions/
cp server/sharedregions/GeneralRepositoryProxy.class dirGeneralRepos/server/sharedregions/
cp server/sharedregions/SharedMemoryProxy.class dirGeneralRepos/server/sharedregions/
cp server/sharedregions/Repository/GeneralRepository.class dirGeneralRepos/server/sharedregions/Repository

echo " Departure Airport"
rm -rf dirDeparture
mkdir -p dirDeparture dirDeparture/server dirDeparture/server/Main dirDeparture/server/entities dirDeparture/server/sharedregions \
         dirDeparture/client dirDeparture/client/entities dirDeparture/client/stubs dirDeparture/Common dirDeparture/server/sharedregions/DepartureAirport 

cp server/Main/SR_DepartureAirportMain.class dirDeparture/server/Main
cp Common/*.class dirDeparture/Common
cp server/entities/*.class dirDeparture/server/entities
cp server/sharedregions/DepartureAirport/*.class dirDeparture/server/sharedregions/DepartureAirport
cp server/sharedregions/SR_DepartureAiportProxy$1.class dirDeparture/server/sharedregions
cp server/sharedregions/SR_DepartureAiportProxy.class dirDeparture/server/sharedregions
cp server/sharedregions/SharedMemoryProxy.class dirDeparture/server/sharedregions/
cp client/stubs/DepartureStub.class dirDeparture/client/stubs
cp client/stubs/GeneralRepositoryStub.class dirDeparture/client/stubs 

echo "  Destination Airport"
rm -rf dirDestination
mkdir -p dirDestination dirDestination/server dirDestination/server/Main dirDestination/server/entities dirDestination/server/sharedregions \
         dirDestination/client dirDestination/client/entities dirDestination/client/stubs dirDestination/Common dirDestination/server/sharedregions/DestinationAirport

cp server/Main/SR_DestinationAirportMain.class dirDestination/server/Main
cp Common/*.class dirDestination/Common
cp server/entities/*.class dirDestination/server/entities
cp server/sharedregions/DestinationAirport/*.class dirDestination/server/sharedregions/DestinationAirport
cp server/sharedregions/SR_DestinationAirportProxy$1.class dirDestination/server/sharedregions
cp server/sharedregions/SR_DestinationAirportProxy.class dirDestination/server/sharedregions
cp server/sharedregions/SharedMemoryProxy.class dirDestination/server/sharedregions/
cp client/stubs/*.class dirDestination/client/stubs

cp client/stubs/GeneralRepositoryStub.class dirDestination/client/stubs

echo "  Plane"
rm -rf dirPlane
mkdir -p dirPlane dirPlane/server dirPlane/server/Main dirPlane/server/entities dirPlane/server/sharedregions \
         dirPlane/client dirPlane/client/entities dirPlane/client/stubs dirPlane/Common dirPlane/server/sharedregions/Plane

cp server/Main/SR_PlaneMain.class dirPlane/server/Main
cp Common/*.class dirPlane/Common
cp client/entities/Pilot.class dirPlane/client/entities
cp server/entities/*.class dirPlane/server/entities
cp server/sharedregions/Plane/*.class dirPlane/server/sharedregions/Plane
cp server/sharedregions/SR_PlaneProxy$1.class dirPlane/server/sharedregions
cp server/sharedregions/SharedMemoryProxy.class dirPlane/server/sharedregions/
cp client/stubs/DepartureStub.class dirPlane/client/stubs
cp client/stubs/GeneralRepositoryStub.class dirPlane/client/stubs

echo " Pilot"
rm -rf dirPilot
mkdir -p dirPilot dirPilot/client dirPilot/client/entities dirPilot/client/Main dirPilot/client/stubs dirPilot/Common
cp Common/*.class dirPilot/Common
cp client/entities/Pilot.class dirPilot/client/entities
cp client/Main/PilotMain.class dirPilot/client/Main
cp client/stubs/DepartureStub.class client/stubs/DestinationStub.class client/stubs/PlaneStub.class dirPilot/client/stubs

echo " Hostess"
rm -rf dirHostess
mkdir -p dirHostess dirHostess/client dirHostess/client/entities dirHostess/client/Main dirHostess/client/stubs dirHostess/Common
cp Common/*.class dirHostess/Common
cp client/entities/Hostess.class dirHostess/client/entities
cp client/Main/HostessMain.class dirHostess/client/Main
cp client/stubs/DepartureStub.class client/stubs/DestinationStub.class dirHostess/client/stubs

echo " Passenger"
rm -rf dirPassenger
mkdir -p dirPassenger dirPassenger/client dirPassenger/client/entities dirPassenger/client/Main dirPassenger/client/stubs dirPassenger/Common
cp Common/*.class dirPassenger/Common
cp client/entities/Passenger.class dirPassenger/client/entities
cp client/Main/PassengerMain.class dirPassenger/client/Main
cp client/stubs/DepartureStub.class client/stubs/DestinationStub.class client/stubs/PlaneStub.class dirPassenger/client/stubs


echo "Compressing execution environments."
echo "  General Repository of Information"
rm -f  dirGeneralRepos.zip
zip -rq dirGeneralRepos.zip dirGeneralRepos
echo "  Departure Airport"
rm -f  dirDeparture.zip
zip -rq dirDeparture.zip dirDeparture
echo "  Destination Airport"
rm -f  dirDestination.zip
zip -rq dirDestination.zip dirDestination
echo "  Plane"
rm -f  dirPlane.zip
zip -rq dirPlane.zip dirPlane
echo "  Pilot"
rm -f  dirPilot.zip
zip -rq dirPilot.zip dirPilot
echo "  Hostess"
rm -f  dirHostess.zip
zip -rq dirHostess.zip dirHostess
echo "  Passenger"
rm -f  dirPassenger.zip
zip -rq dirPassenger.zip dirPassenger






