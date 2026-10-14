# OASIS INFOBYTE - Security Analyst Task 1
## Network Scanning Using Nmap

### 1. Project Overview

This project demonstrates network scanning using Nmap on an
Ubuntu Linux virtual machine.

The objective is to identify open ports, detect running services,
perform service version detection, and attempt operating system
detection.

### 2. What Is Nmap?

Nmap stands for Network Mapper. It is an open-source network
scanning tool used to discover hosts, identify open ports,
detect running services, and gather information about network
systems.

Nmap is commonly used by network administrators and security
professionals to assess network exposure and improve security.

### 3. Why Is Network Scanning Important?

Network scanning helps security professionals:

- Identify open and accessible ports.
- Discover running network services.
- Identify software versions.
- Detect potentially unnecessary services.
- Review possible security risks.
- Improve firewall rules and system configurations.

An open port does not automatically indicate a vulnerability.
Each service must be assessed according to its configuration,
software version, and exposure.

### 4. Project Environment

- Operating System: Ubuntu Linux
- Virtualisation: Oracle VirtualBox
- Scanning Tool: Nmap 7.98
- Target: Local Ubuntu system
- Target IP: 127.0.0.1

### 5. Nmap Installation

Update the package list:

    sudo apt update

Install Nmap:

    sudo apt install nmap -y

Verify the installation:

    nmap --version

Nmap was verified successfully. The installed version is 7.98.

### 6. Basic Scan

Command:

    nmap 127.0.0.1

Purpose:

The basic scan identifies open ports on the target system.

Observed result:

- Target: 127.0.0.1
- Host status: Up
- Open TCP port: 631
- Service: IPP
- Other 999 scanned TCP ports: Closed

### 7. Service Version Detection

Command:

    sudo nmap -sV 127.0.0.1

Purpose:

The service version scan attempts to identify the software
running on discovered open ports.

Observed result:

- Port: 631/tcp
- State: Open
- Service: IPP
- Detected software: CUPS 2.4

### 8. Operating System Detection

Command:

    sudo nmap -O 127.0.0.1

Purpose:

The -O option attempts to identify the target operating system
by analysing network responses.

The actual output of this scan should be documented in
nmap_scan_results.txt. OS detection may not identify the
operating system when scanning localhost.

### 9. Open Port Analysis

#### Port 631/TCP - IPP

Service: Internet Printing Protocol (IPP)

Software: CUPS 2.4

Purpose:

IPP is used for printing-related communication. CUPS is a
printing system commonly used on Linux and Unix-like systems
to manage printers and print jobs.

Potential security risks:

- Unauthorised access to printing services.
- Insecure printing service configuration.
- Exposure of printer information or administrative functions.
- Vulnerabilities in outdated software.

Security recommendation:

Review the CUPS configuration, restrict access to trusted
systems, keep the software updated, and disable the service
if it is not required.

An open port alone does not prove that the service is vulnerable.

### 10. Scan Results

The file nmap_scan_results.txt contains the recorded results
of the basic scan, service version scan, and OS detection scan.

The confirmed open port identified during the basic scan is
631/tcp, running IPP. Service detection identified CUPS 2.4.

### 11. Screenshots

The screenshots directory contains terminal screenshots
documenting the Nmap installation and scanning process.

Screenshots should show the actual terminal output.

### 12. Ethical Use Guidelines

- Scan only systems you own or have explicit permission to test.
- Do not scan third-party systems without authorisation.
- Follow applicable laws and organisational security policies.
- Do not use scan results for unauthorised access.
- Protect sensitive information discovered during testing.
- Use findings responsibly to improve security.

### 13. Conclusion

This project demonstrates the use of Nmap for basic network
scanning and service version detection on an Ubuntu system.

The scan identified port 631/tcp running IPP, with CUPS 2.4
detected during service version analysis.

The results help demonstrate how network scanning can identify
services that may require further security review.

### 14. Project Files

- README.md: Project overview and instructions.
- nmap_scan_results.txt: Recorded scan results.
- basic_scan.txt: Basic scan output.
- service_version_scan.txt: Service version scan output.
- os_detection_scan.txt: OS detection output.
- nmap_version.txt: Nmap version information.
- screenshots/: Terminal screenshots.

### 15. Disclaimer

This project was performed for educational purposes on a
system under my control. Network scanning must be conducted
only with proper authorisation.
