"Starting setup..."
Add-WindowsFeature Web-Server; 
Add-WindowsFeature NET-Framework-45-ASPNET; 
Add-WindowsFeature Web-Asp-Net45; 
Remove-Item -Recurse C:\inetpub\wwwroot\*;

Copy-Item -Path .\index.aspx -Destination C:\inetpub\wwwroot\;
Copy-Item -Path .\Get-ServerMetrics.ps1 -Destination C:\ -Force;
Copy-Item -Path .\New-ServerLoad.ps1 -Destination C:\ -Force;
Copy-Item -Path .\entrypoint.ps1 -Destination C:\ -Force;
