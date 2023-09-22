# Makefile

PORTS ?= 8180

default: all

all: build run port_forward

build:
	ansible-playbook mitmproxy_setup.yml --extra-vars "ports=$(PORTS)" --tags build

run:
	ansible-playbook mitmproxy_setup.yml --extra-vars "ports=$(PORTS)" --tags run

port_forward:
	ansible-playbook mitmproxy_setup.yml --extra-vars "ports=$(PORTS)" --tags port_forward

cleanup:
	ansible-playbook mitmproxy_setup.yml --extra-vars "ports=$(PORTS)" --tags cleanup
