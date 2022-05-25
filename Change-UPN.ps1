#1- Connect to Exchange
Connect-ExchangeOnline
#2- Initiate a connection to Azure Active Directory
Connect-MSOLService
#3- Get all users with engworks.com domain
$Users=Get-MsolUser -DomainName "engworks.com" -all | select Userprincipalname,displayname,firstname,lastname
#4 - Change Username
$Users | ForEach-Object {
    if (($_.userprincipalname -like '*engworks.com') -and ($_.userprincipalname -notlike '*#EXT#*'))
    {
        $newDomain = "@engbim.com"
        $newSMTPAddress = $_.userprincipalname -split '@'
        $newSMTPAddress = $newSMTPAddress[0] + $newDomain
        Write-Host "Processing: $_.userprincipalname -> $newSMTPAddress"
        Set-MsolUserPrincipalName -UserPrincipalName $_.userprincipalname -NewUserPrincipalName $newSMTPAddress
    }
}