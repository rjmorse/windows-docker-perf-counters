param(
    [int]$identityType = 4
)
"identityType = $identityType"
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
    Import-Module WebAdministration
    #Per https://docs.microsoft.com/en-us/iis/configuration/system.applicationhost/applicationpools/add/processmodel#configuration
    #Value 0 = LocalSystem, highest privilege
    #Value 1 = LocalService, high privilege
    #Value 2 = NetworkService, past privilege, used last in IIS 7
    #Value 3 = SpecificUser, custom identity. Don't care about this here/now.
    #Value 4 = ApplicationPoolIdentity, default

    Get-ChildItem 'iis:\sites\' | Remove-Item -Recurse -Force
    New-Item 'iis:\Sites\Default Web Site' -bindings @{protocol="http";bindingInformation=":80:"} -physicalPath c:\inetpub\wwwroot
    Set-ItemProperty IIS:\AppPools\DefaultAppPool -name processModel.identityType -value $identityType
    Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name ApplicationPool -Value DefaultAppPool    

    C:\New-ServerLoad.ps1
    Start-Sleep -Seconds 5
    C:\Get-ServerMetrics.ps1
    Get-Job | Remove-Job -Force | Out-Null
}
else{
    "Please correct the above errors to continue"
}


