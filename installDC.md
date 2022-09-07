1. Using sconfig for the following on the server:
 - changed the IP address
 - changed the hostname
 - changed the DNS to the IP address
 - turned off sconfig to pop-out automatically when we start the DC

2. Setting up connection with the domain controller
   set-item WSMan:\localhost\Client\TrustedHosts -value <ip_address>
   New-PSSession <ip_address> -Credential (Get-Credential)
   Enter-PSSession <ip_address> -Credential (Get-Credential)
   
   to make it faster to log into the remote session session:
   $creds = (Get-Credential)
   $dc = New-PSSession <ip_address> -Credential $creds

   copy-paste the ad_schema created and the get_user powershell script
   cp .\ad_schema.json -ToSession $dc C:\Windows\Tasks\
    cp .\get_user.ps1 -ToSession $dc C:\Windows\Tasks\
   
3. Installed AD on the DC
 - Commands:
   Install-WindowsFeatures AD-Domain-Services -IncludeManagementTools
 
   Import-Module ADDSDeployment
   Install-ADDSForest

4. Adding a domain name
 - After it completes we want to change some more stuff

   Get-NetIPAddress 
   Get-DNSClientServerAddress

   Set-DNSClientServerAddress -InterfaceIndex 6 -ServerAddresses <ip>
   Get-DNSClientServerAddress

   We check and the DNS address is set accordingly!

 
5. Joining the workstation to the domain
   Add-Computer -DomainName <domain_name> -Credential <domain_name>\Administrator -Force -Restart
 
