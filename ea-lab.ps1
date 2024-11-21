# Import AutomatedLab module
Import-Module AutomatedLab

# Define the lab name
New-LabDefinition -Name 'SQLWinLab' -DefaultVirtualizationEngine HyperV

# Add an operating system ISO for Windows Server and Windows 11
Add-LabIsoImageDefinition -Name 'WindowsServer2022' -Path 'C:\LabSources\ISOs\WindowsServer2022.iso'
Add-LabIsoImageDefinition -Name 'Windows11' -Path 'C:\LabSources\ISOs\Windows11.iso'

# Add a domain to the lab
Add-LabDomainDefinition -Name 'MyDomain.local' -AdminUser 'LabAdmin' -AdminPassword 'SecurePassword123!'

# Define a network for the lab
Add-LabVirtualNetworkDefinition -Name 'LabNetwork'

# Add a Windows Server for the Domain Controller
Add-LabMachineDefinition -Name 'DC01' `
    -Roles RootDC `
    -OperatingSystem 'Windows Server 2022 Datacenter (Desktop Experience)' `
    -IpAddress 192.168.1.10 `
    -Network 'LabNetwork'

# Add a Windows Server for SQL Server
Add-LabMachineDefinition -Name 'SQLServer' `
    -Roles SQLServer2019 `
    -OperatingSystem 'Windows Server 2022 Datacenter (Desktop Experience)' `
    -IpAddress 192.168.1.20 `
    -Network 'LabNetwork' `
    -DomainName 'MyDomain.local'

# Add a Windows 11 client
Add-LabMachineDefinition -Name 'Win11Client' `
    -OperatingSystem 'Windows 11 Enterprise' `
    -IpAddress 192.168.1.30 `
    -Network 'LabNetwork' `
    -DomainName 'MyDomain.local'

# Add a domain user for the Windows 11 client
Set-LabInstallationCredential -Username 'LabUser' -Password 'UserPassword123!'

# Install the lab
Install-Lab

# Export RDP files for easy access to machines
Export-LabVM -Path 'C:\LabVMs'

Write-Output "Lab setup is complete. Use the RDP files in 'C:\LabVMs' to access your lab machines."
