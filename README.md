# Basic Network Scanning with Nmap
## Objective
Performed basic network scanning on my own Ubuntu virtual machine using Nmap.
## Environment
Opreating System: Ubuntu Linux
Tool: Nmap 7.98
Target: 127.0.0.1 (Localhost)
## Scans Performed
Basic scan: nmap 127.0.0.1
Service detection: nmap -sV 127.0.0.1
OS detection: nmap -O 127.0.0.1
The scan identified port 631/tcp as open . The service was identified as IPP with CUPS 2.4.
## Security Analysis
Unnecessary network services can increase the attack surface. Required services should be kept updated and restricted to authorized systems.
OS detection result: No exact OS match was identified by Nmap.
