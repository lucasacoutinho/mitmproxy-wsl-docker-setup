# Get the ports from the command line argument
$portsToCleanup = $args[0] -split ',' | ForEach-Object { [int]$_ }

# Loop through each port and remove forwarding and firewall rules
foreach ($port in $portsToCleanup) {
    # Remove port forwarding rules for the current port
    netsh interface portproxy delete v4tov4 listenport=$port listenaddress=0.0.0.0

    $firewallRule = Get-NetFirewallRule -DisplayName "WSL2 Port $port" -ErrorAction SilentlyContinue

    # If the firewall rule exists, remove it
    if ($firewallRule) {
        Remove-NetFirewallRule -DisplayName "WSL2 Port $port"
        Write-Output "Firewall rule removed for port $port"
    } else {
        Write-Output "No firewall rule exists for port $port"
    }
}

Write-Output "Cleanup completed for ports: $($portsToCleanup -join ', ')"
