# cleanup.ps1

# Define the ports you had forwarded
$portsToForward = @(8180, 8181)

# Loop through each port to remove forwarding and firewall rules
foreach ($port in $portsToForward) {
    # Remove port forwarding rules for the current port
    netsh interface portproxy delete v4tov4 listenport=$port listenaddress=0.0.0.0

    # Remove the firewall rule for the current port
    $firewallRule = Get-NetFirewallRule -DisplayName "WSL2 Port $port" -ErrorAction SilentlyContinue
    if ($firewallRule) {
        Remove-NetFirewallRule -DisplayName "WSL2 Port $port"
        Write-Output "Firewall rule removed for port $port"
    }
}

Write-Output "Cleanup completed for ports: $($portsToForward -join ', ')"
