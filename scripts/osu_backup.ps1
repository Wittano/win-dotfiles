$data=(Get-Date -Format "dd-MM-yyyy")
$HOME
$osu_directory = "$env:HOME\AppData\Local\osu!"
$destination = "$HOME\Windows VM\osu!-$data.zip"

If(-not (Test-Path $osu_directory)) {
    Write-Output "osu! directory not found"
    Exit
}

Add-Type -assembly "system.io.compression.filesystem" 
[io.compression.zipfile]::CreateFromDirectory($osu_directory, $destination)

Write-Output "done"