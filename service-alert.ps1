function checkService {
    param($ServiceName)
    $service = Get-Service -Name $ServiceName
    if($service.Status -eq "Running") {
        Write-Host $ServiceName " is running"
    }
    if($service.Status -ne "Running") {
        $EmailFrom = "johndoe@email.com”
        $EmailPass = "password"
        $EmailTo = "adamsmith@email.com”
        $Date = (Get-Date -format F).ToString()
        $Subject = “Service Status Notification”
        $Body = "$Date`n$ServiceName is not running."
        $SMTPServer = “smtp.server.com”
        $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 99)
        $SMTPClient.EnableSsl = $true
        $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $EmailPass);
        Write-Host $ServiceName "is not running"
        Write-Host "Sending notification email"
        $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
        Write-Host "Notification sent"
    }
}

checkService -ServiceName "RemoteAccess"