$dotfiles=$(Get-Item -Path $MyInvocation.MyCommand.Source).Directory.FullName

function Get-Config-File {
    param (
        [string]$path
    )
    
    if (-not $(Test-Path -Path $path)) {
        throw "Missing $path"
        exit 1
    }
    
    $basename = $(Get-Item $path).Name
    xcopy.exe $path "$dotfiles\$basename"
}

Get-Config-File "$env:USERPROFILE\wittano.omp.json"
Get-Config-File "$env:USERPROFILE\Documents\WindowsPowerShell"