. ./sources.ps1

function Get-Config-File {
    param (
        [string]$path
    )

    if (-not $(Test-Path -Path $path)) {
        throw "Missing $path"
        exit 1
    }

    $basename = $(Get-Item $path).Name
    Copy-Item -Recurse -Force -Path $path -Destination $dotfiles
}

foreach ($path in $sources) {
    Write-Output "Copy $path to dotfiles"

    Get-Config-File $path
}