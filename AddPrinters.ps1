<#
.SYNOPSIS
    Adding of multiple printers to a new computer
.DESCRIPTION
    You will be able to edit this file to add printers to one device without having to add them one at a time. 
    Will check if the printer has been installed correctly and test print. 
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
##################################DO NOT USE THIS PROGRAM. CURRENTLY NOT WORKING#########################################################
##################################DO NOT USE THIS PROGRAM. CURRENTLY NOT WORKING#########################################################
##################################DO NOT USE THIS PROGRAM. CURRENTLY NOT WORKING#########################################################
#Setting up the Hashtable for the Printer information and creation 
$Printers = @{
    firstPrinter =@{
        IP = '10.196.49.197'
        Name = 'Office B/W Printer'
        Driver ='HP Universal Printer Driver PCL6'
    }
    secondPrinter = @{
        IP = '10.196.48.20'
        Name = 'Office Color Printer'
        Driver ='HP Universal Printer Driver PCL6'
        }
        #You can copy the above and add more printers if you require more than 2. 
        #program will loop through and add any printers in this list. 
}

foreach ($printer in $Printers.Key){
    $AddPrint = $Printers[$Printer]
    Add-PrinterDriver -name $AddPrint.Driver
    Add-PrinterPort -Name "$AddPrint.IP" -PrinterHostAddress $AddPrint.IP
    Add-Printer -DriverName $AddPrint.Driver -Name $AddPrint.Name -PortName $AddPrint.IP
    Get-Printer | select PrinterStatus, $AddPrint.Name, $AddPrint.IP  
}
