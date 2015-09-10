set PATH=%PATH%;C:\selenium
java -jar C:\selenium\selenium-server.jar -role node -hub http://dev:4444/grid/register -host 192.168.10.40 -browser browserName="internet explorer",version=10.0,platform=WINDOWS -Dwebdriver.internetexplorer.driver=C:\selenium\IEDriverServer.exe
