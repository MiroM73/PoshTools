Function Get-Icon
{
    <#
.SYNOPSIS
Get-Icon extracts the icon image from an exe file
and saves it as a .ico file in the same directory as
the .exe file.
.DESCRIPTION
Get-DiskInventory will run on specified .exe file and extract and save a .ico file.
.PARAMETER File
The exe filename containing the icon. The array of files is also possible.
.PARAMETER OutputDir
The path to the output dir, where the function will extract the file with the icon.
The name of the icon file is the same as the name of the file, from which we extracted it.
.EXAMPLE
Get-Icon -File c:\exefile.exe -OutputDir c:\
.EXAMPLE
Get-Icon -File c:\exefile.exe,c:\exefile2.exe,c:\exefile3.exe -OutputDir c:\
.EXAMPLE
Get-Icon -File (Get-ChildItem -Path 'C:\Program Files' -Filter '*.exe' -Recurse).FullName -OutputDir c:\
.NOTES
Created by Joshua Duffney
https://github.com/Duffney/PowerShell/blob/master/FileSystems/Get-Icon.ps1

Modified by me.
#>

    [CmdletBinding()]
    Param (
        #Enter the location of the .EXE file/s.
        [Parameter(Mandatory = $true)]
        [string[]]$Files,
        #Enter the destination folder of the icon file/s.
        #Default is a current folder.
        [string]$OutputDir
    )

    begin
    {
        [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null
        if ([string]::IsNullOrEmpty($OutputDir))
        {
            $OutputDir = '.'
        }
    }
    process
    {
        foreach ($File in @($Files | Get-Item))
        {
            $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($File.FullName)
            [System.Drawing.Icon]::ExtractAssociatedIcon($File.FullName).ToBitmap().Save("$OutputDir\$BaseName.ico")
        }
    }
}