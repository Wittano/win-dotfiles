$dotfiles=$(Get-Item -Path $MyInvocation.MyCommand.Source).Directory.FullName
$sources=@("$env:USERPROFILE\wittano.omp.json", "$env:USERPROFILE\Documents\WindowsPowerShell")