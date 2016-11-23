. "$PSScriptRoot\..\..\WrapperLib.ps1"

#Comment out function part for development

#function RunPlugin()
#{
#PARAM(
#[XML]$Definition,
#$ctx
#)

#Add $Definition for testing purpose

$Definition = [XML]"<Definition><Plugin>TestPlugin</Plugin><Data><ExampleString>MyString</ExampleString></Data></Definition>"

$ExampleString = $Definition.Definition.Data.ExampleString

$ExampleString >> "C:\SIMTestPlugin.txt" 

$result = GenerateResult -ObjectID "None" -Message "To file C:\SIMTestPlugin.txt was written '$ExampleString'" -Successful $TRUE

return $result

#Comment out function part for development
#}