<#<#
.SYNOPSIS
    Will run the USMT [Scan and load] 
.DESCRIPTION
    Will be used to gether user profiles and place them into portable drive. 
    Scan and Load commands to transfer the user data into the new machine.
    Make sure to have the user apps installed before your run the load state. 
.EXAMPLE
    Run-ScanState 
    Explanation of what the example does
.INPUTS
    Portable Drive Path ------> D:\Profiles\RM10
    You will scan and load into this filepath on the external drive you currently have connected. 
    There is also an option to store this data on a server. Will need to work on this option. 
.OUTPUTS
    
.NOTES
  Make empty folders for the teachers or staff that you will be using this script on before your begin the process. 
  OLD MACHINE: I would also prep the old machine by removing any programs and files that are no longer being used. Will cut back on storage and time. 

  TARGET MACHINE: Install the applications that your user had on their previous machine. Will allow for most transfers of app data. 
  USMT has not been able to transfer Printer locations so far. Will work on adding more parts to this script to allow for this feature. 
#>

#This command will elevate the privilages of the powershell window to allow for the execution of the script. 
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
     { Start-Process PowerShell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Will ask user to install USMT if not present on machine. Will check for USMT in the file path to make sure it has been installed. 
Write-Host "
  ############################################################################
  #                        Is USMT Installed on this  device?                #
  # ======================================================================== #                                                                        
  # [1] YES. Move to Scan/Load Step                                          #
  # [2] NO.  Install USMT Package Automatically                              #
  #                                                                          #
  ############################################################################
" -ForegroundColor Yellow

$USMTInstall = Read-Host "Select Option: [1][2]"

#Installation of USMT if not present. 
switch ($USMTInstall){
  1{
    $Install_USMT_Check = Test-Path -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
    if($Install_USMT_Check -eq $true){
      Write-Host 'Moving on.......'
    }Else{
      Write-Host "USMT Kit Not Found!" -ForegroundColor Yellow 
      Write-Host "Install USMT and Run again"
      Read-Host -prompt "Press Any Key To Close"
      Stop-Process -id $PID 
    }
  }
  2{
  #USMT  ADK set up tool should be move to the desktop. If this program fails or stalls for a while. The user has probably changed the file path from the orginal one.
  #You can just install the ADK from the adksetup.exe. You will only need the USMT tool. 
   set-location -Path "C:\Users\Teacher\Desktop"
   .\adksetup.exe /quiet /installpath "C:\Program Files (x86)\Windows Kits\10" /features OptionId.UserStateMigrationTool 
  
  #Used to check if USMT has been installed correctly and is present on the machine. 
  $Install_USMT_Check = Test-Path -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
  While ($Install_USMT_Check -ne $true){
      if($Install_USMT_Check -eq $true){
      Write-Host 'Moving on.......'
      Write-Host 'Program was installed correctly'  -ForegroundColor Green 
      Break 
      }
      #Loop that check if USMT has been installed. Gives User a bit of feedback. 

      else{ 
      Write-Host "Program is still installing......." 
      Start-Sleep -Seconds 10
      }
      $Install_USMT_Check = Test-Path -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
      #Internet connection is need to get the latest USMT version. 
      #Will be adding a check to make sure the device is connected to the network before starting this process. 
    }
  }
}
#Prompt User to pick what they will be running. 
Write-Host "
  ##########################################################################
  #                         *** USMT Scritp ***                            #
  # ====================================================================== #                                                                      
  #                                V.87                                    #
  # Select Program:                                                        #
  # [1] Run (ScanState)                                                    #
  # [2] Run (LoadState)                                                    #
  # [3] Exit Script                                                        #
  #                                                                        #
  ##########################################################################
" -ForegroundColor Yellow
$Option = Read-Host "Select Option: [1][2][3]" 

#Main command to start the ScanState Process. 
switch ($Option)
{
  1{ 
   Invoke-Command {
	 Set-Location -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
         $StorePath = Read-Host "Enter your External Storage Path"
         $USMTpath64  = 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
         $Scanstate = "$USMTpath64\scanstate.exe"
	 
        #These options can be changed to include a wide set of settings and options to customize the scan and load option.
         & $Scanstate $StorePath /i:MigApp.xml /i:MigDocs.xml /i:migUser.xml /c /o
	     Read-host -Prompt 'Completed! Press any key to exit'
    }
    
    }
  #Main command to start the LoadState Process. 
  2{  
    Invoke-Command {
    Set-Location -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
        $StorePath = Read-Host "Enter your External Storage Path"
        $USMTpath64  = 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool\amd64'
        $Loadstate = "$USMTpath64\loadstate.exe"

      #These options can be changed to include a wide set of settings and options to customize the scan and load option. 
        & $Loadstate $StorePath /i:MigApp.xml /i:MigDocs.xml /i:migUser.xml /c 
        Read-host -Prompt 'Completed! Press any key to exit'
    }
    
    }
  3{ 
    
    Read-Host -prompt "Press any key to close"
  
    }
 }
