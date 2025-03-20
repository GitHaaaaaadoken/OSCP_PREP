
# README

## ENGAGEMENT
Idea behind this script is to gather tools, organize binaries and create useful scripts for OSCP use. The script, on Kali, will cp the included binaries into their respective folders, wget useful tools (i.e Ligolo), and echo scripts that could be useful for payload generation, ligolo configuration, etc. 

## LIGFIG
ligfig is a python script that just runs linux commands to prep your attack machine for pivoting. It will create your tuntap with your specified username, bring the interface up and add your route. It even spits out some tips for running your proxy on Linux and agent on Windows. 

## LISTEN
Listen is python script that'll run an rlwrapped NC listener, in an effort to maybe save a little time but also to provide syntax for shell stability. Copy it to your /usr/bin/ folder for easier execution. 

## MACRO
Macro template is just a quick reference for how your client side macros should look. Be sure to run vba_breakup.py (generated with engagement & saved in OSCP/windows/) after generating your b64 encoded payload like the engagement created OSCP/windows/PowerShell/pull_rev.ps1 :)

## PORT_EXTRACTOR
port extractor is something I made for pulling out all of the ports after running an NMAP scan with -oN flag. Just another time saver. 

## SERV2
serv2 is another python script used for setting up a python3 http server. I was getting tired of typing python3 -m http.server 80...now its just serv2 80 :) Anotha one to add to your /usr/bin folder for ease of use. 

## Download.ps1
Simple powershell script, allows you to download 3 files with a single invoke web request. Does some verification and if any errors arise, prints them in red. 


