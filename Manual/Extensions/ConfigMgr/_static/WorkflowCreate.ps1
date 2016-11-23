$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\ConfigMgr.dll")

$ConfigMgrConnectionSettings = New-Object SIM.ConfigMgr.ConnectionSettings
$ConfigMgrConnectionSettings.WMIHostName = 'MyConfigMgrHost'
$ConfigMgrConnectionSettings.SiteCode = 'P01'
$ConfigMgrConnectionSettings.SQLHostname = $ConfigMgrConnectionSettings.WMIHostName

$ConfigMgrConnection = New-Object SIM.ConfigMgr.Connection($ConfigMgrConnectionSettings)

$ConfigMgrComputersSettings = New-Object SIM.ConfigMgr.Computers.ComputerParameters
$ConfigMgrComputersSettings.ComputerName = "TestComputer"
$ConfigMgrComputersSettings.MACAddress = "E4-F8-9C-5D-DE-39"
$ConfigMgrComputersSettings.ComputerOverwriteExistingObject = $true

$val = New-Object SIM.ConfigMgr.Parameter("Var1", "Val1")

$ConfigMgrComputersSettings.Variables.Add($val)

$ParametersCollectionMembership = New-Object SIM.ConfigMgr.ParametersCollectionMembership
$ParametersCollectionMembership.IsComputerMembership = $true
$ParametersCollectionMembership.CollectionName = "Windows Server 2012 Deploy"
$ParametersCollectionMembership.CreateCollectionIfNotExist = $false

$ConfigMgrComputersSettings.Collections.Add($ParametersCollectionMembership);

$ConfigMgrComputersWorkflowCreate = New-Object SIM.ConfigMgr.Computers.Computer($ConfigMgrConnection)

$ResCreate = $ConfigMgrComputersWorkflowCreate.WorkflowCreate($ConfigMgrComputersSettings)

$ResCreate.Dump()