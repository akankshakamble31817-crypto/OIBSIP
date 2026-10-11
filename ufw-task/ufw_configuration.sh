#!/bin/bash

echo "=================================="
echo " UFW Firewall Inspection"
echo "=================================="

echo ""
echo "1. Firewall Status and Rules"
sudo ufw status numbered

echo ""
echo "2. IPv4 Network Addresses"
ip -4 addr

echo ""
echo "3. Listening TCP Ports"
sudo ss -lntp

echo ""
echo "4. Recent UFW Firewall Logs"
sudo journalctl -k --since "30 minutes ago" --no-pager | grep -i UFW || echo "No UFW log entries found."

echo ""
echo "Firewall inspection completed."
