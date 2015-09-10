$shell = new-object -com shell.application
$zip = $shell.NameSpace("C:\selenium\IEDriverServer_Win32_2.47.0.zip")
foreach($item in $zip.items())
{
$shell.Namespace("C:\selenium").copyhere(($item),0x14)
}
