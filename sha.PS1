$ErrorActionPreference = "Stop"

Function Get-FileSHA1() {
    param(
        [Parameter(
            ValueFromPipeline = $true, 
            ValueFromPipelineByPropertyName = "FullName", 
            Mandatory = $true
        )]
        [String]$filePath
    )
    begin {
        $sha = New-Object System.Security.Cryptography.SHA1Managed
        $prettyHash = New-Object System.Text.StringBuilder
    }
    process {
        $fileContent = Get-Content $filePath
        $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
            
        $hash = $sha.ComputeHash($fileBytes)
        
        foreach ($item in $hash) {
            $hexaNotation = $item.ToString("X2")
            $prettyHash.Append($hexaNotation) > $null
        }
        $prettyHash.ToString()
        $prettyHash.Clear() > $null
    }
    end {
        $sha.Dispose()
    }
}
#$arq = "C:\Users\ADMIN\Documents\powershell\sha.PS1"
#$hashArquivo = Get-FileSHA1 $arq
#Write-Host "O hash do $arq eh $hashArquivo" -BackgroundColor Red -ForegroundColor Yellow
Function Get-FileSHA256() {
    
}
Function Get-FileSHA384() {
    
}
Function Get-FileSHA512() {
    
}