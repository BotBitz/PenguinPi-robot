# PenguinPi Static Hotspot

This Wifi config is designed for use with an external wifi adapters. It sets up a static hostpot with the internal raspberry pi wifi appended with the devices mac address. It does not check for existing hostpots. Instead it uses an external device to connect to the internet or other services.

**Install-wifi.sh**

Installs the static wifi service. 

**Remove-webserver.sh**

Removes the static wifi service.

**Connecting to Wifi**
On first boot the Penguin Pi hotspot will be advertised. This can be connected to using the password: PenguinPi
Once connected you can then connect to a secondary wifi using the external wifi adapter. 

Use the command "sudo nmtui" to open the terminal ui for connecting to access points with the second wifi adapter. 
Select Activate -> Choose the appropriate wifi hostpot and enter password. 

Alternatively plug in a screen keyboard and mouse and connect through the GUI. 





