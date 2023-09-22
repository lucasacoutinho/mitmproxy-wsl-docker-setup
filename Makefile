# Makefile

# Default target
default: run-ansible

run-ansible:
	ansible-playbook mitmproxy_setup.yml

cleanup:
	./run-cleanup.sh
