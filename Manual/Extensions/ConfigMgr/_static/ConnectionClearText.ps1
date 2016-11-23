$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\ConfigMgr.dll")

$ConfigMgrConnectionSettings = New-Object SIM.ConfigMgr.ConnectionSettings
$ConfigMgrConnectionSettings.WMIHostName = 'MyConfigMgrHost'
$ConfigMgrConnectionSettings.SiteCode = 'P01'
$ConfigMgrConnectionSettings.WMIUserDomainName = 'MyDomain'
$ConfigMgrConnectionSettings.WMIUserName = 'administrator'
$ConfigMgrConnectionSettings.WMIUserPassword = 'Password123'
$ConfigMgrConnectionSettings.SQLHostname = $ConfigMgrConnectionSettings.WMIHostName;
$ConfigMgrConnectionSettings.SQLUserName = "administrator";
$ConfigMgrConnectionSettings.SQLUserPassword = "Password123";