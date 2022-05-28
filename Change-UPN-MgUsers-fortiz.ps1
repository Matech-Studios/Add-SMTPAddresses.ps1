#1- Connect to AzureAD (Graph)
Connect-MgGraph -Scopes User.ReadWrite.All

#2- Get users with Id eq fortiz@matechstudios.onmicrosoft.com
Get-MgUser -UserId fortiz@matechstudios.onmicrosoft.com |fl

#3- Update UPN for users with Id eq fortiz@matechstudios.onmicrosoft.com
Update-MgUser -UserId fortiz@matechstudios.onmicrosoft.com -UserPrincipalName fortiz@matechstudios.com

#4- Valida UPN change for user
Get-MgUser -All | Where-Object {$_.UserPrincipalName -like '*@matechstudios.com'}
