param(
    [string]$source,
    [string]$dest,
    [string]$alt
)

if([string]::IsNullOrEmpty($source) -or [string]::IsNullOrEmpty($dest)) {
    Write-Output "Missing required source or destination path"
    Exit
}

$data=(Get-Date -Format "dd-MM-yyyy")
$basename = (Get-Item $source).BaseName
$destination = "$dest\$basename-backup-$data.zip"
$alt_destination = "$alt\$basename-backup-$data.zip"

Write-Output $destination

If(-not (Test-Path $source)) {
    Write-Output "Source directory '$source' not found"
    Exit
}

if(Test-Path $dest) {
    Compress-Archive -LiteralPath $source -DestinationPath $destination
} else {
    Compress-Archive -LiteralPath $source -DestinationPath $alt_destination
}