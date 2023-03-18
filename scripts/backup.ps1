param(
    [string]$source,
    [string]$filename,
    [string]$dest,
    [string]$alt
)


function Remove-Duplicate {
    param (
        [string]$filename,
        [string]$dir
    )

    $first_saved_backup = Get-ChildItem -Path "$dir\$filename*" -File 
    | Sort-Object LastWriteTime -Descending 
    | Select-Object -First 1

    $second_saved_backup = Get-ChildItem -Path "$dir\$filename*" -File 
    | Sort-Object LastWriteTime -Descending 
    | Select-Object -First 2
    | Select-Object -Last 1

    Write-Output "Calucating hashed for lastest backups"
    $latest_update_hash = Get-FileHash $first_saved_backup
    $saved_update_hash = Get-FileHash $second_saved_backup

    if ($latest_update_hash -eq $saved_update_hash) {
        Write-Output "Remove duplicate backups"
        Remove-Item $first_saved_backup
    }
}

if ([string]::IsNullOrEmpty($source) -or [string]::IsNullOrEmpty($dest)) {
    Write-Output "Missing required source or destination path"
    Exit
}

$data = (Get-Date -Format "dd-MM-yyyy")

if([string]::IsNullOrEmpty($filename)) {
    $basename = (Get-Item $source).BaseName
} else {
    $basename = $filename
}

$destination = "$dest\$basename-backup-$data.zip"
$alt_destination = "$alt\$basename-backup-$data.zip"

If (-not (Test-Path $source)) {
    Write-Output "Source directory '$source' not found"
    Exit
}

Write-Output "Create backup"
if (Test-Path $dest) {
    Compress-Archive -LiteralPath $source -DestinationPath $destination
    Remove-Duplicate -dir $dest -filename $basename 
}
else {
    Compress-Archive -LiteralPath $source -DestinationPath $alt_destination
    Remove-Duplicate -dir $alt -filename $basename 
}