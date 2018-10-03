#Unlocks Users in both Meritage and Carefree Domains
#Created by Kyle King - 10.01.2018
##################################
#Script Change Log
#10.01.2018 - Created Script

#Global Settings
    import-module activedirectory
    $script:colorprompt = "white"
    $script:colortrue = "green"
    $script:colorfalse = "red"
    $script:meritagedomain = "meritage.corp"
    $script:carefreedomain = "carefree.meritage.corp"

#Define Servers
    $westsac = "100F10001"
    $SoCal = "150F10001"
    $Scottsdale = "200F10003"
    $Tucson = "270F0001"
    $DFW = "505F10001"
    $Houston = "550F10001"
    $Austin = "575F10001"
    $SanAntonio = "580F10001"
    $Orlando = "855F10001"
    $SanRamon = "P125AD001V"
    $CoLo1 = "P220IAW001"
    $CoLo2 = "P220IAW002"
    $ColoPHX = "P225AD001V"
    $Nashville = "P600AD001"
    $Greenville = "P610AD001V"
    $Atlanta = "P630AD001V"
    $Denver = "P700AD001V"
    $Tampa = "P800AD001"
    $BoyntonBeach = "P875AD001V"
    $Raliegh = "P900IAW001"
    $Charlotte = "P950AD001"
    $Azure = "PAZW02DC001-01"
    $CareFreeCoLo1 = "p220ad902"
    $CareFreeCoLo2 = "p222ad001v"

#Define Meritage Function
function Meritage
{
    $prompt = "Enter username (john.doe):"
    $color = $script:colorprompt
    do
    {
	    write-host $prompt -foregroundcolor $color
	    $script:username = Read-Host
    }
        while (!$(dsquery user -samid $script:username -s $script:meritagedomain; $prompt="User $script:username was not found, try again. `n`rEnter username (john.doe):"; $color=$script:colorfalse))
        $script:nameduser = (get-aduser -server $script:meritagedomain $script:username).samaccountname
        $script:disablefullname = (get-aduser -server $script:meritagedomain $script:username).Name
    
    write-host "$script:nameduser selected" -foregroundcolor $script:colortrue

    #Unlock Account in Meritage Domains
    Unlock-ADAccount $script:username -Server "$westsac.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$SoCal.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Scottsdale.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Tucson.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$DFW.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Houston.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Austin.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$SanAntonio.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Orlando.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$SanRamon.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$CoLo1.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$CoLo2.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$ColoPHX.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Nashville.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Greenville.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Atlanta.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Denver.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Tampa.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$BoyntonBeach.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Raliegh.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Charlotte.$script:meritagedomain"
    Unlock-ADAccount $script:username -Server "$Azure.$script:meritagedomain"
}

#Define Carefree Function
function Carefree
{
    $prompt = "Enter username (john.doe):"
    $color = $script:colorprompt
    do
    {
	    write-host $prompt -foregroundcolor $color
	    $script:username = Read-Host
    }
        while (!$(dsquery user -samid $script:username -s $script:carefreedomain; $prompt="User $script:username was not found, try again. `n`rEnter username (john.doe):"; $color=$script:colorfalse))
        $script:nameduser = (get-aduser -server $script:carefreedomain $script:username).samaccountname
        $script:disablefullname = (get-aduser -server $script:carefreedomain $script:username).Name
    
    write-host "$script:nameduser selected" -foregroundcolor $script:colortrue

    Unlock-ADAccount $script:username -Server "$CareFreeCoLo1.$script:carefreedomain"
    Unlock-ADAccount $script:username -Server "$CareFreeCoLo2.$script:carefreedomain"
}


#Looping Call
do 
{
    #Carefree Title Question
        write-host "Is this a Carefree Title User?: (y/n)" -foregroundcolor $script:colorprompt
        $script:CFResponse = Read-Host
            if($script:CFResponse -eq "y")
            {
                Carefree
            }
            else
            {
                Meritage
            }
$response = read-host "Repeat? (Y/N)"
}
while ($response -eq "Y")