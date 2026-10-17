#!/bin/bash

# OASIS INFOBYTE Security Analyst Internship
# Task: Firewall Configuration Using UFW

set -e

# Check that the script is run with administrator privileges.
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script using sudo."
    exit 1
fi

echo "========================================"
echo " UFW Firewall Configuration"
echo "========================================"

# Install UFW if it is not already installed.
if ! command -v ufw >/dev/null 2>&1; then
    echo "Installing UFW..."
    apt-get update
    apt-get install -y ufw
fi

# Configure the default firewall policies.
echo "Setting default policies..."
ufw default deny incoming
ufw default allow outgoing

# Rule 1: Allow SSH.
echo "Allowing SSH on port 22..."
ufw allow 22/tcp

# Rule 2: Deny HTTP.
echo "Denying HTTP on port 80..."
ufw deny 80/tcp

# Rule 3: Allow HTTPS.
echo "Allowing HTTPS on port 443..."
ufw allow 443/tcp

# Rule 4: Deny the documentation IP range.
echo "Denying traffic from 192.0.2.0/24..."
ufw deny from 192.0.2.0/24

# Rule 5: Allow the custom TCP port 8080.
echo "Allowing TCP port 8080..."
ufw allow 8080/tcp

# Enable the firewall only after adding the SSH rule.
echo "Enabling UFW..."
ufw --force enable

# Display the resulting configuration.
echo "========================================"
echo " Final Firewall Status"
echo "========================================"
ufw status verbose

echo "Firewall configuration completed."
