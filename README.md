# PUSD-USMT-Script
The script has been made to transfer all of the users files and app data from a WINDOWS 10 Machine to a new WINDOWS 10 Machine.
The program has 3 main steps: 
        1. Installing of USMT Tool 
        2. ScanState on old device
        3. LoadState on new device
        
        
REQUIREMENTS
 1. USMT adksetup.exe 
 2. Externla Drive
 3. Old Machine 
 4. New Machine 
 5. Apps being used
 6. Tech Password (PUSD)

NOTES
The script so far has been able to transfer most app data. It does have some problems with applications. 
Most of the Applications currently being used by PUSD devices have been transferred correctly. 
Cleaning applications, files, video and photos that might not be needed should not be transferred.
You should always install the applications that will be needed before you run the LoadState Command.

EXAMPLES OF SETUP:
1.Move script and adksetup to desktop of old/new machines
![Desktop](https://user-images.githubusercontent.com/79068398/157495869-1301d3e0-9dc3-4b9e-88ac-bf87c40af127.PNG)


2. Run the Scan/Load State script.
![USMT Install Steps](https://user-images.githubusercontent.com/79068398/157495489-30bebe2a-135b-4432-bb56-76b800b2accf.PNG)


USMT DOWNLOAD LINKS/NOTES:

I will be attaching a Zip folder with the adksetup.exe. This executable is just an installer. You will need internet connection to have this work. I would place the adksetup.exe on the desktop. 
complete the USMT install. 

You can either use the zip file provided or download your own. 

DOWNLOAD LINK:https://go.microsoft.com/fwlink/?linkid=2165884

ADK MANUALS/HELP: https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install

USMT TECHNICAL REFERENCE: https://docs.microsoft.com/en-us/windows/deployment/usmt/usmt-technical-reference
