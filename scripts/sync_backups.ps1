param(
    [string]$source,
    [string]$dest
)

$files = Get-ChildItem "$source\*.zip" -File

foreach ($file in $files) {
    $filename = $file.Name

    if(-not (Test-Path "$dest\$filename")) {
        Copy-Item -LiteralPath $file -Destination $dest
    }
}
