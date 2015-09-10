$swarm_executors = $args[0]
$swarm_master = $args[1]
$slave_name = $args[2]

echo $swarm_master

# WMI needed such that processes invoked through PS Remoting are kept running on the server after the session is closed
Invoke-WmiMethod -path win32_process -name create -argumentlist "java.exe -jar `"c:\jenkins\swarm-client.jar`" -disableSslVerification -executors `"$swarm_executors`" -master `"$swarm_master`" -name `"slave-$slave_name`""
