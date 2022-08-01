<# S /Users/fog> Connect-MsolService
Connect-MsolService : Could not load file or assembly 'System.IdentityModel, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'. The system cannot find the file specified.

Connect-MsolService not compatible with macos...? 
No problem! --> Adopting Connect-MgGraph
https://github.com/PowerShell/PowerShell/issues/7162
#>

#1- Connect to AzureAD (Graph)
Connect-MgGraph -Scopes User.ReadWrite.All

#2- Get all users with matechstudios.onmicrosoft.com domain
$Users=Get-MgUser -All | Where-Object {$_.UserPrincipalName -like '*@matechstudios.onmicrosoft.com'}

#3 - Change UserPrincipalName
$Users | ForEach-Object {
    if (($_.UserPrincipalName -like '*matechstudios.onmicrosoft.com') -and ($_.UserPrincipalName -notlike '*#EXT#*') -and ($_.UserPrincipalName -notlike '*fog@matechstudios.onmicrosoft.com*'))
    {
        $newDomain = "@matechstudios.com"
        $newUPN = $_.UserPrincipalName -split '@'
        $newUPN = $newUPN[0] + $newDomain
        $currentUPN = $_.UserPrincipalName
        Write-Host "New UPN: $newUPN"
        Write-Host "Current UPN: $currentUPN"
        Write-Host "Processing: $($_.UserPrincipalName) -> $newUPN"
        Update-MgUser -UserId $_.UserPrincipalName -UserPrincipalName $newUPN
        #Set-MsolUserPrincipalName -UserPrincipalName $_.userprincipalname -NewUserPrincipalName $newSMTPAddress
    }
}

<# Connect-MgGraph -Scopes 'User.Read.All'
Get-MgUser -All 
Get-MgUser -UserId fortiz@matechstudios.onmicrosoft.com |fl
Update-MgUser -UserId fortiz@matechstudios.onmicrosoft.com -UserPrincipalName fortiz@matechstudios.com
Get-MgUser -All | Where-Object {$_.UserPrincipalName -like '*@matechstudios.onmicrosoft.com'}
Connect-MgGraph -Scopes User.ReadWrite.All
 #>
