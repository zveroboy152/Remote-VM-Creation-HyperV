#RemoteHV-VM-CreationV1

﻿#This is to remotely create VMs via powershell CLI
#This can be used to remotely create vms in other Hyper-V hosts and can be linked / changed to other scripts to automate the deployment of VMs
#This was written by Tyler Lindberg
#________________________________________________________________________________________________
clear
 
#______________________________TAKING THE USERS INPUT_____________________________________________
#This asks for the VM host you want to create the vm on
    $HVRemoteHost = Read-Host -Prompt 'What system do you want to create VMs on?'
 
#VM name variable taken from the input
    $VMName = Read-Host -Prompt 'What do you want the name to be?'
 
#Asking for VM memory variable
    $VMMemory = Read-Host -Prompt 'How much Memory should the vm have?(example: 4GB )'
 
#Asking for VM memory variable
    $VMVHD = Read-Host -Prompt 'How large will the VHD be?'
 
    Write-Host 'One moment, I am fetching the Virtual Networks of the Host...'
 
#Listing remote hosts virtual networks
$InvokeVMNICs = Invoke-Command -ComputerName $HVRemoteHost -ScriptBlock {
 
Get-VMSwitch -SwitchType External | Sort-Object Name
 
}
        #This will then print out what was above ^
        Write-Host $InvokeVMNICs
 
 
    #Asking what VMNIC you'd like to add
    $VMNIC = Read-Host -Prompt 'What network would you like the VM to be a part of?'
 
    Write-Host 'Let me fetch the list of disks next...'
 
#This will list the disks
Invoke-Command -ComputerName $HVRemoteHost -ScriptBlock {
 
Get-PSDrive
 
}
 
 #Asking the for the VM location after listing the disks on the remote host machines
    $VMlocation = Read-Host -Prompt 'Where do you want to store this VM'
 
 
    #This will convert the GB to bytes for the memory and storage variables
    $vmmembytes1 = ($VMMemory / 1GB) * 1GB
    $vmmembytesvhd1 = ($VMVHD / 1GB) * 1GB
 
#__________________________REMOTE COMMANDS USING THE USERS INPUT________________________________________
#This is to invoke the command on the remote machine
Invoke-Command -ComputerName $HVRemoteHost -ScriptBlock {
 
#This will create the vm on the remote machine
 
New-VM -Name $using:VMName -MemoryStartupBytes $using:vmmembytes1 -BootDevice VHD -NewVHDPath $using:VMLocation\$using:VMName.vhdx -Path $using:VMLocation -NewVHDSizeBytes $using:vmmembytesvhd1 -Generation 2 -Switch $using:VMNIC
 
        
       
       #Then the VM will start
       
        Start-VM -Name $using:VMName
}
 
    Write-Host 'Enjoy your new Virtual Machine! If any issues persist please contact the Hyper-V System Administrator.'
    Write-Host 'Goodbye.'