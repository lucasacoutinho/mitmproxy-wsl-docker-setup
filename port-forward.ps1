# port-forward.ps1

# Define the ports you want to forward
$portsToForward = @(8180, 8181)

# Get WSL2 IP
$wslIp = wsl -e bash -c "ip addr show eth0 | grep 'inet ' | cut -d ' ' -f 6 | cut -d '/' -f 1"

# Loop through each port and set up forwarding
foreach ($port in $portsToForward) {
    # Remove any existing port forwarding rules for the current port
    netsh interface portproxy delete v4tov4 listenport=$port listenaddress=0.0.0.0

    # Add new port forwarding rule for the current port
    netsh interface portproxy add v4tov4 listenport=$port listenaddress=0.0.0.0 connectport=$port connectaddress=$wslIp

    $firewallRule = Get-NetFirewallRule -DisplayName "WSL2 Port $port" -ErrorAction SilentlyContinue

    # If the firewall rule doesn't exist, create it
    if (-not $firewallRule) {
        New-NetFirewallRule -DisplayName "WSL2 Port $port" -Direction Inbound -LocalPort $port -Protocol TCP -Action Allow
        Write-Output "Firewall rule created for port $port"
    } else {
        Write-Output "Firewall rule already exists for port $port"
    }
}

Write-Output "Port forwarding set up for ports: $($portsToForward -join ', ')"
