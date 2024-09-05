. ./sources.ps1

function Get-Config-File {
    param (
        [string]$path
    )

    $src = "$dotfiles\$($(Get-Item $path).Name)"
    if (-not $(Test-Path -Path $src)) {
        throw "Missing $src"
        exit 1
    }
    
    $dirPath = [System.IO.Path]::GetDirectoryName($path);
    if (-not (Test-Path -PathType Container $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath
    }
    
    Copy-Item -Recurse -Path $src -Destination $path
}

foreach ($path in $sources) {
    Write-Output "Install $path from dotfiles"
    
    Get-Config-File $PSItem
}