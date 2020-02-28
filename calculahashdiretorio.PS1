param($diretorio)
$ErrorActionPreference = "Stop"

. .\sha.PS1

$arquivos = Get-ChildItem $diretorio -File
foreach ($item in $arquivos.FullName) {
    $hashItem = Get-FileSHA1 $item
    Write-Host "O hash dp arquivo $item eh $hashItem"
}