. "$PSScriptRoot\..\..\WrapperLib.ps1"


function RunPlugin()
{
PARAM(
[XML]$Definition,
$ctx
)
    
    Try
    {

        #Place here general plugin functions


        #Generate a plugin result:
        $result = GenerateResult -ObjectID "None" -Message "Some return description for queue result..." -Successful $TRUE

    }
    Catch
    {
    
        $ErrorMessage = $_.Exception.Message
        $result = GenerateResult -ObjectID "None" -Message "Unhandled exception thrown while running plugin: $ErrorMessage" -Successful $FALSE
   
    }

    return $result

}