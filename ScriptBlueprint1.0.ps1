#---------Yotam Nordman---------#
#region Really Basic Stuff
#region Get-Command
#  Get-Command <SomeCommand> -Syntax
# Will get the commands syntax this way:
#
# EXAMPLE:   Get-Service [[-Name] <string[]>] [-ComputerName <string[]>] [-DependentServices] [-RequiredServices] [-Include <string[]>] [-Exclude <string[]>] [<CommonParameters>]
#                 /\        /\       /\  /\              /\                                                                                                            /\
#                 !!        !!       !!  !!              !!                                                                                                            !!
#               Command  Positional Type Array        Optional                                                                                             Common stuff commands have
#
#               Square brackets mean optional.
#               Square brackets on a Command makes it a Positional Parameter - Meaning you can write the parameter without stating its name in the right position
#               EXAMPLE: Get-Service BITS -ComputerName localhost  -> BITS is a service name, i could write BITS without its parameter name because its the first positional parameter
#               Pointy brackets mean input type -> string int... could include [] to make it an array
#               No brackets means Mandatory (Name of the command is without brackets because it has to be written in order to invoke the command)
#               CommonParameters EXAMPLE: -Verbose            - Confirm           -WhatIf
#endregion
#region Help
# Most important command ever  -> Mark Something And Press F1 To View Help in ISE
# Remember to update help      -> Update-Help
# How to update help when not connected to the internet :
#
# Save-Help in a computer with up to date help on it
# Get the file to the target computer and   ->    Update-Help PathToTheHelpSaved
#
# Dont Forget the Switches :
#
#         -Full        ->      Gets all the help it can find
#         -Examples    ->      Gets examples of usage
#endregion
#region Get-Member -> gm
# Gets all members of a given Object , Command
# EXAMPLE:
# Get-Process | gm
#endregion
#region Select-Object Where-Object
# Select Object selects fields from a pipeline input
# EXAMPLE:
# Get-service | Select-Object DisplayName ,CanStop
# Where-Object lets to apply a condition to the pipeline input
# EXAMPLE:
# Get-Service | Where-Object Name -like 'bi*'
#endregion
#region Group-Object
# Can group objects by property
# EXAMPLE:
# Get-Service | Group-Object -Property Status
#endregion
#region  ->   $_.   <-
# Current object in the iteration or operation, like this. in .NET
#endregion
#region Check PowerShell Version
# $PSVersionTable.PSVersion
#endregion
#endregion Basic Stuff
#region Basic Usefull Stuff
#region Execution Policy , Set-StrictMode
# This is disabled by default and need to enable in order to run a full script from file !

#                        \/

# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

#                        /\

# To avoid mistakes of performing impactfull commands on empty variables instead of one (Empty variables)
Set-StrictMode -Version 1
#endregion
#region Measure-Command , Measure-Object
# Measure Command gets a script block {} and measures the time it takes
# EXAMPLE:
# $Time = (Measure-Command {Get-Service BITS}).TotalMilliseconds
# Measure Object counts objects that get out of pipeline
# EXAMPLE:
# Get-Service | Measure-Object
#endregion
#region Get-Credential
# Lets you input credentials and save them or input to a function (prompts for creds)
# Some commands have -Credential to use the inputed credentials
# EXAMPLE:
# Invoke-Command -Credential (Get-Credential)
# $Creds = Get-Credential
#endregion
#region Get-Date
# Gets the current date and time                                                         !!
#                                                                                        \/
# Date - Date = TimeSpan   -> its not a date object type     ->     <TimeSpanObject>.TotalDays gives days combined with hours minutes and secounds etc...
#                                                                                        /\
#                                                                                        !!
#endregion
#region alias
# New-Alias  ->  New alternate name for something
# Notice when running exe files that u didnt cover their name with alias
# EXAMPLE: Run ipconfig.exe instead of writing ipconfig
#endregion
#region dir -> Get-ChildItem
# dir and ls are aliases for GetChildItem
# -Path <>  -> on a spacified path
# -Recurse  -> get all paths under that path in the tree
#endregion
#region Export-Csv , HashTable Col
# Can apear after a PIPELINE
# Theres an annoying line on top of the csv to remove it :
# -NoTypeInformation
# EXAMPLE:
# Get-Process | Select-Object ProcessName,@{Name='hello';Expression={$_.Threads.Count}} | Export-Csv -Path C:\PowerShell\hello.csv -NoTypeInformation
#endregion
#region -OutVariable , OutNull
# OutVariable directs a copy of the output to a variable of choice
# EXAMPLE:
# Get-Service -OutVariable something
# $something
# OutNull Redirects output to void
#endregion
#region New-IseSnippet , CTRL + J
# UseFull functions that can be pasted with CTRL + J
#endregion
#region Out-GridView -PassThru
# EXAMPLE:
# $s = dir C:\PowerShell| Out-GridView -PassThru   ->   Lets you pop out a windows and choose an object into the variable
#endregion
#endregion UserFull Stuff
#region More Advance Stuff
#region $ConfimPreference
# $ConfirmPreference = 'Low'   ->   Makes it so low and above impact commands only will get a prompt for user confirmation
# Default is 'Medium'
#endregion
#region New-EventLog
# New-EventLog -LogName 'opa' -Source 'SourceName'  ->  creates an event in the event log(event viewer)  ->  Winkey + R -> eventvwr
#endregion
#region Advanced Functions
# CTRL + J to paste the template
# $DynamicParam - runs only when u TYPE the command for dynamic params in the auto completion.  ->  MUST HAVE $Begin, $Process or $End !!!!!!!!!!!!!
# $End  ->  Runs at the end of the function
# $Begin  -> Runs at the very start of the function
# $Process -> Actuall logic of the function runs after the begin
#endregion
#region $?
# Gets True or False Whether the last command ran was successful
#endregion
#region Debug with Trace-Command
# EXAMPLE:
# Trace-Command -Name metadata,parameterbinding,cmdlet -Expression {Get-Service BITS} -PSHost
#endregion
#region &{}
# $s = & {<Code>}  ->  Runs the code but output is redirectred to the variable instead of screen
#endregion
#region Connection Testing
# Test-Connection      ->  Uses Ping
# Test-NetConnection   ->  Is like Telnet to check a port
#endregion
#endregion
#region Facebook Login
function Login-Facebook {
# Remember to give creds as param
# $Credential = Get-Credential
# Login-Faceook $Credential
  param ($Credential)
  
  $url = 'https://www.facebook.com/'
  $r = Invoke-WebRequest -Uri $url -SessionVariable fb -UseBasicParsing   
  $form = $r.Forms[0]
  
  # change this to match the website form field names:
  $form.Fields['email'] = $Credential.UserName
  $form.Fields['pass'] = $Credential.GetNetworkCredential().Password
  
  # change this to match the form target URL
  $r = Invoke-WebRequest -Uri $form.Action -WebSession $fb -Method POST -Body $form.Fields
  $r
}
#endregion Facebook Login
#region DSC First Tests
Configuration MyFirstDSC
{
   # A Configuration block can have zero or more Node blocks
   Node 'DESKTOP-COBF18G'#'DESKTOP-B0R554C'
   {
        Archive myArchiveExample
        {
            Ensure = "Present" # You can also set Ensure to "Absent"
            Path = "C:\PSTest\Demos.zip"
            Destination = "C:\PSTest\Test"
            DependsOn= '[File]CreateFolder'
        }
        Registry myRegistryExample
        {
          Ensure = "Present"
          Key = 'HKEY_LOCAL_MACHINE\SOFTWARE'
          ValueName = "HELLO"
          ValueData = "ITS.ME"
        }
        File CreateFolder
        {
            DestinationPath='C:\PSTest\Test'
            Ensure ='Present'
            Type ='Directory'
        }
#        WindowsFeature IIS
#        {
#        Ensure = "Present"
#        Name = "Web-Server"
#        }
#        File WebDirectory
#        {
#        Ensure = "Present"
#        Type = "Directory"
#        Recurse= $true
#        SourcePath= 'C:\Powershell\whatwhat'
#        DestinationPath= "C:\inetpub\wwwroot"
#        DependsOn= "[WindowsFeature]IIS"
#       }
    }

   LocalConfigurationManager{
   ConfigurationMode="ApplyAndAutocorrect"
   RefreshFrequencyMins=30
   ConfigurationModeFrequencyMins=30
   #ConfigurationID=''
   #DownloadManagerName="WebDownloadManager"
   #RefreshMode="Pull"
   #CertificateID="71AA68562316FE3F73536F1096B85D66289ED60E"
   #Credential=$cred
   #RebootNodeIfNeeded=$true
   #AllowModuleOverwrite=$false
   }
}
mkdir 'C:\PSTest\MyFirstDSC\' -ErrorAction SilentlyContinue
cd 'C:\PSTest\MyFirstDSC\'
MyFirstDSC

#notepad .\MyFirstDSC\Web2012R2.mof

Start-DscConfiguration  -Verbose -Path 'C:\PSTest\MyFirstDSC\MyFirstDSC\' -Force -Wait -ComputerName 'DESKTOP-COBF18G'
Get-DscConfigurationStatus
Get-DscConfiguration
#Stop-DscConfiguration 
#Enable-PSRemoting
#Enable-PSRemoting -SkipNetworkProfileCheck
#endregion DSC First Tests
#region DSC New Domain
configuration NewDomain             
{             
   param             
    (             
        [Parameter(Mandatory)]             
        [pscredential]$safemodeAdministratorCred,             
        [Parameter(Mandatory)]            
        [pscredential]$domainCred            
    )             
            
    Import-DscResource -ModuleName xActiveDirectory            
            
    Node $AllNodes.Where{$_.Role -eq "Primary DC"}.Nodename             
    {             
            
        LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true            
        }            
            
        File ADFiles            
        {            
            DestinationPath = 'N:\NTDS'            
            Type = 'Directory'            
            Ensure = 'Present'            
        }            
                    
        WindowsFeature ADDSInstall             
        {             
            Ensure = "Present"             
            Name = "AD-Domain-Services"             
        }            
            
        # Optional GUI tools            
        WindowsFeature ADDSTools            
        {             
            Ensure = "Present"             
            Name = "RSAT-ADDS"             
        }            
            
        # No slash at end of folder paths            
        xADDomain FirstDS             
        {             
            DomainName = $Node.DomainName             
            DomainAdministratorCredential = $domainCred             
            SafemodeAdministratorPassword = $safemodeAdministratorCred            
            DatabasePath = 'N:\NTDS'            
            LogPath = 'N:\NTDS'            
            DependsOn = "[WindowsFeature]ADDSInstall","[File]ADFiles"            
        }            
            
    }             
}            
            
# Configuration Data for AD              
$ConfigData = @{             
    AllNodes = @(             
        @{             
            Nodename = "localhost"             
            Role = "Primary DC"             
            DomainName = "alpineskihouse.com"             
            RetryCount = 20              
            RetryIntervalSec = 30            
            PsDscAllowPlainTextPassword = $true            
        }            
    )             
}             
            
NewDomain -ConfigurationData $ConfigData `
    -safemodeAdministratorCred (Get-Credential -UserName '(Password Only)' `
        -Message "New Domain Safe Mode Administrator Password") `
    -domainCred (Get-Credential -UserName alpineskihouse\administrator `
        -Message "New Domain Admin Credential")            
            
# Make sure that LCM is set to continue configuration after reboot            
Set-DSCLocalConfigurationManager -Path .\NewDomain –Verbose            
            
# Build the domain            
Start-DscConfiguration -Wait -Force -Path .\NewDomain -Verbose    
#endregion DSC New Domain
#region DSC Install Chrome
Configuration Sample_InstallChromeBrowser
{
    param
    (
    [Parameter(Mandatory)]
    $Language,
        
    [Parameter(Mandatory)]
    $LocalPath
        
    )
    
    Import-DscResource -module xChrome
    
    MSFT_xChrome chrome
    {
    Language = $Language
    LocalPath = $LocalPath
    }
}
#endregion DSC Install Chrome