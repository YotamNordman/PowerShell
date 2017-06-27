#---------Yotam Nordman---------#
#region Basic Stuff
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
# Get-Service | Select-Object DisplayName ,CanStop
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
#endregion Basic Stuff
#region Usefull Stuff
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
#endregion UserFull Stuff








