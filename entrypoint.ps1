$error = $false
if((Test-Path C:\New-ServerLoad.ps1) -ne $true){
    "C:\New-ServerLoad.ps1 must exist"
    $error = $true;
}
if((Test-Path C:\Get-ServerMetrics.ps1) -ne $true){
    "C:\Get-ServerMetrics.ps1 must exist"
    $error = $true;
}
if($error -eq $false){
    if( $Host -and $Host.UI -and $Host.UI.RawUI ) {
        $rawUI = $Host.UI.RawUI
        $oldSize = $rawUI.BufferSize
        $typeName = $oldSize.GetType( ).FullName
        $newSize = New-Object $typeName (150, $oldSize.Height)
        $rawUI.BufferSize = $newSize
    }
    Add-WindowsFeature NET-Framework-45-ASPNET
    Add-WindowsFeature Web-Asp-Net45
    Start-Sleep -Seconds 10

    C:\New-ServerLoad.ps1
    Start-Sleep -Seconds 5
    C:\Get-ServerMetrics.ps1
    Get-Job | Remove-Job -Force | Out-Null
}
else{
    "Please correct the above errors to continue"
}


