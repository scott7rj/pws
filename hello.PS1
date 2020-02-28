param($tipoDeExportacao)
$ErrorActionPreference = "Stop"
echo "hello world!"
<#
$servico = Get-Service -Name "SQLAgent*"
$servico.Status
if ($servico.Status -eq "Running") {
    echo "servico SQLAgent esta executando"
    #$servico.Stop()
    #$servico.Start()
} else {
    echo "servico SQLAgent nao esta executando"
}
<#

<#
echo $env:Path.Split(';')
echo $env:Path.GetType()
echo $env:Path | Get-Member

Get-Alias -Name dir
Get-Command -Verb *rename*
#Get-Help -name rename-item
Get-Command -noun Alias
Set-ExecutionPolicy -CurrentUser Unrestricted
Get-ExecutionPolicy
Get-Help about_Profiles
$profile.AllUsersAllHosts
#>

#gci -File | Select-Object Name, length | Where-Object {$_ -like "*.txt*"} | Select-Object name, { "{0:N2}KB" -f ($_.Length/1KB) }
<#
$nameExpr = "Name"
$lengthExpr = {"{0:N2}KB" -f ($_.Length/1KB)}
$params = ($nameExpr, $lengthExpr)
gci -Recurse -File |
? Name -like "*.txt*" |
select $params
#>

Set-Location -Path C:\users\ADMIN\Documents
$nameExpr = @{Label = "Nome"; Expression = {$_.Name}}
$lengthExpr = @{Label = "Tamanho"; Expression = { "{0:N2}KB" -f ($_.Length/1KB) }}
$params = $nameExpr, $lengthExpr
$resultado = 
    gci -File |
    ? Name -like "*.txt*" |
    select $params
if ($tipoDeExportacao -eq "html") {
    $css = Get-Content C:\users\ADMIN\Documents\powershell\style.css
    $cssTag = "<style>$css</style>"
    $titulo = "Arquivos"
    $tituloBody = "<h1>$titulo</h1>"
    $resultado | 
        ConvertTo-Html -Head $cssTag -Title $titulo -Body $tituloBody | 
        Out-File C:\Users\ADMIN\Documents\TMP\relatorio.html
} elseif ($tipoDeExportacao -eq "json") {
    $resultado | 
        ConvertTo-Json | 
        Out-File C:\Users\ADMIN\Documents\TMP\relatorio.json
} elseif ($tipoDeExportacao -eq "csv") {
    $resultado | 
        ConvertTo-Csv -Delimiter ";" |
        Out-File C:\Users\ADMIN\Documents\TMP\relatorio.csv
} else {
    echo "tipo de exportacao nao foi passado"
}