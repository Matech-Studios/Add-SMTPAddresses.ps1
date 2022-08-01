$AllMailboxes = Get-Mailbox -ResultSize Unlimited
Foreach ($Mailbox in $AllMailboxes){
    # Creating NEW E-mail address that contracted in the following way: 
    # Take the existing recipient Alias name + use the NEW Domain name 
    # as a domain suffix + “Bind” the Alias name + the NEW Domain name suffix.
    
    $NewAddress = $Mailbox.Alias + "@matechstudios.com"
    Set-Mailbox -Identity $Mailbox.Alias -WindowsEmailAddress $NewAddress #-whatif
}

# Optional Disconnect Exchange Online Sessions
$Confirm = Read-Host "Disconnect all Exchange Online sessions? [Y/N]"
Switch ($Confirm) {
    Y {
    Write-Host "Disconnecting all Exchange Online sessions"
    Get-PSSession | Where-Object {$_.name  -Like "ExchangeOnlineInternalSession*"} | Remove-PSSession
    }

    N {
    Write-Host "All Exchange Sessions still active"
    }

    Default {
    Write-Host "Invalid input"
    }
}
