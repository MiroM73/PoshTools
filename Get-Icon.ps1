<#
.SYNOPSIS
Get-Icon extracts the icon image from an exe file
and saves it as a .ico file in the same directory as
the .exe file.
.DESCRIPTION
Get-DiskInventory will run on specified .exe file and extract and save a .ico file.
.PARAMETER File
The exe filename containing the icon.
.PARAMETER OutputDir
The path to the output dir, where the function will extract the file with the icon.
The name of the icon file is the same as the name of the file, from which we extracted it.
.EXAMPLE
Get-Icon -File c:\exefile.exe -OutputDir c:\
#>

Function Get-Icon
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, HelpMessage = "Enter the location of the .EXE file")]
        [string]$File,
        [Parameter(Mandatory = $True, HelpMessage = "Enter the destination folder of the icon file")]
        [string]$OutputDir
    )

    [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null

    Get-Item $File |
        ForEach-Object {
            $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($_.FullName)
            [System.Drawing.Icon]::ExtractAssociatedIcon($_.FullName).ToBitmap().Save("$OutputDir\$BaseName.ico")
        }
}