function checkService {
    param($ServiceName)
    $service = Get-Service -Name $ServiceName
    $log = 'C:\path\to\file'
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
    if($service.Status -eq "Running") {
        Write-Host $ServiceName " is running"
        if(([System.Io.fileinfo]$log).LastWriteTime.Date -ne [datetime]::Today){
            $Body = "$Date`n$log has not been updated"
            Write-Host "$log has not been updated"
            Write-Host "Sending notification email"
            #$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
            Write-Host "Notification sent"
        } else {
            Write-Host "$log is up-to-date"
        }
    }
    if($service.Status -ne "Running") {
        Write-Host $ServiceName "is not running"
        Write-Host "Sending notification email"
        $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
        Write-Host "Notification sent"
    }
}

checkService -ServiceName "CagService"