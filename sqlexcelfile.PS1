#Install-Module -Name SqlServer -AllowClobber
#Import-Module SqlServer
#Get-SqlDatabase -ServerInstance SP7261ET640\SQLEXPRESS

#encrypt/decrypt password
(Get-Credential).Password | ConvertFrom-SecureString | Out-File "C:\Users\ADMIN\Documents\powershell\password.txt"
$user = "psi"
$file = "C:\Users\ADMIN\Documents\powershell\password.txt"
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, (Get-Content $file | ConvertTo-SecureString)
Get-SqlDatabase -ServerInstance SP7261ET640\SQLEXPRESS -Credential $cred

$instance = "SP7261ET640\SQLEXPRESS"
$database = "psi"
$table = "base"
Read-SqlTableData -ServerInstance $instance -DatabaseName $database -SchemaName "dbo" -TableName $table
Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance $instance
Invoke-Sqlcmd -InputFile "C:\ScriptFolder\TestSqlCmd.sql" | Out-File -FilePath "C:\ScriptFolder\TestSqlCmd.rpt"

#Capture data into a DataSet object
$DS = Invoke-Sqlcmd -ServerInstance $instance -Query "SELECT base_id, base_name FROM psi.dbo.base" -As DataSet
$DS.Tables[0].Rows | %{ echo "{ $($_['base_id']), $($_['base_name']) }" }


Install-Module -Name ImportExcel
Import-Module ImportExcel
$xl=New-Object -ComObject excel.application
$xl.Visible=$true
$wb=$xl.Workbooks.add()
$ws=$wb.Worksheets["Plan1"]
$ws.Cells[1,1].Value = "ID"
$ws.Cells[1,2].Value = "Product"
$ws.Cells[1,3].Value = "Quantity"
$ws.Cells[1,4].Value = "Price"
$ws.Cells[1,5].Value = "Value"
$ws.Cells[2,1].Value = 12001
$ws.Cells[2,2].Value = "Nails"
$ws.Cells[2,3].Value = "37"
$ws.Cells[2,4].Value = "37"
$ws.Cells[2,4].Value = 37
$ws.Cells[2,3].Value = 37
$ws.Cells[2,4].Value = 3.99
$ws.Cells[2,5].Formula = "=C2*D2"

New-Item -Path c:\tmp\pws -ItemType Directory
New-Item -Path c:\tmp\pws\1.txt -ItemType File
Copy-Item "C:\tmp\pws\1.txt" "C:\tmp\pws\2.txt"
Copy-Item "C:\tmp\pws\" "C:\temp" -Recurse
Set-Content "C:\tmp\pws\1.txt" "Hello World"
Get-Content "C:\tmp\pws\1.txt"
Add-Content "C:\tmp\pws\1.txt" "Hello Mars"

foreach ($line in [System.IO.File]::ReadLines("C:\tmp\pws\1.txt")) {
    $line
}

Select-String -Path C:\tmp\pws\*.txt -Pattern 'hello'
Select-String -Path C:\tmp\pws\*.txt -Pattern 'xxx', 'yyy'  -NotMatch

$files = Get-ChildItem -Path "C:\tmp\pws" -name
ForEach($i in $files){
    echo $i
}


