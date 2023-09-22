# Mitmproxy Setup with WSL2 and Docker
This project sets up a mitmproxy container using Docker and WSL2, allowing for traffic interception and modification. The setup includes port forwarding and firewall rules to ensure smooth communication.

## Prerequisites
* Windows Subsystem for Linux 2 (WSL2)
* Docker (with WSL2 backend support)
* Ansible
* Python 3.9+

## Dependencies
To install the required dependencies, run the following:

```
pip install --upgrade ansible docker
```

## Project Structure
* `Makefile`: Contains commands for running the Ansible playbook.
* `mitmproxy_setup.yml`: Ansible playbook for setting up the mitmproxy Docker container.
* `Dockerfile`: Defines the Docker image for mitmproxy.
* `redirect.py`: Python script for mitmproxy to redirect specific requests.
* `run-port-forward.sh`: Bash script to set up port forwarding using a PowerShell script.
* `port-forward.ps1`: PowerShell script to set up port forwarding and firewall rules.
* `run-cleanup.sh`: Bash script to run the cleanup process using a PowerShell script.
* `cleanup.ps1`: PowerShell script to remove port forwarding and firewall rules.

## Usage

1. Setup Mitmproxy:

Use the Makefile to run the Ansible playbook:
```
make
```
This will set up the mitmproxy Docker container, configure port forwarding, and set up the necessary firewall rules.

2. Intercept Traffic:

Configure your device to use the proxy at the IP address of your WSL2 instance on port 8180.

3. Cleanup:

After you're done, it's a good practice to remove the port forwarding and firewall rules:

```
make cleanup
```

## Notes
* The `redirect.py` script is currently set to redirect requests from `google.com` to `instagram.com`. Modify this script as needed for your use case.
* Ensure you run scripts with the necessary permissions, especially when modifying firewall rules or port forwarding.
* *Improvement Opportunity*: The current scripts have ports 8180 and 8181 hardcoded. A potential improvement would be to modify the scripts to allow users to define their desired ports, making the setup more flexible.
