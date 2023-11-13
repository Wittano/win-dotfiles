$data=(Get-Date -Format "dd-MM-yyyy")
$osu_directory = "C:\Users\radek\AppData\Local\osu!"
$destination = "C:\Users\radek\Windows VM\osu!-" + $data + ".zip"

If(-not (Test-Path $osu_directory)) {
    Write-Output "osu! directory not found"
    Exit
}

Add-Type -assembly "system.io.compression.filesystem" 
[io.compression.zipfile]::CreateFromDirectory($osu_directory, $destination)

Write-Output "done"