#1- Connect to Exchange
#Connect-ExchangeOnline

#2- Build vars for targets
$AllUserMailboxes = Get-Mailbox -ResultSize Unlimited -Filter '(RecipientTypeDetails -eq "UserMailbox")'|where-object {($_.Alias -ne "fog") -and ($_.Alias -ne "fortiz")}| Select-Object Alias
$AllSharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter '(RecipientTypeDetails -eq "SharedMailbox")'| Select-Object Alias

Foreach ($Mailbox in $AllUserMailboxes){
    # Creating NEW E-mail address that contracted in the following way: Take the existing recipient Alias name + use the NEW Domain name as a domain suffix + “Bind” the Alias name + the NEW Domain name suffix.
    $NewAddress = $Mailbox.Alias + "@matechstudios.com"
    $CurrentId = $Mailbox.Alias
    Write-Host "New UserMailbox: $CurrentId --> $NewAddress"
    Set-Mailbox -Identity $CurrentId -WindowsEmailAddress $NewAddress
}

Foreach ($Mailbox in $AllSharedMailboxes){
    # Creating NEW E-mail address that contracted in the following way: Take the existing recipient Alias name + use the NEW Domain name as a domain suffix + “Bind” the Alias name + the NEW Domain name suffix.
    $NewAddress = $Mailbox.Alias + "@matechstudios.com"
    $CurrentId = $Mailbox.Alias
    Write-Host "New $Mailbox.RecipientTypeDetails: $CurrentId --> $NewAddress"
    Set-Mailbox -Identity $CurrentId -WindowsEmailAddress $NewAddress
    }

#Set-Mailbox -Identity "fortiz" -WindowsEmailAddress "fortiz@matechstudios.com"