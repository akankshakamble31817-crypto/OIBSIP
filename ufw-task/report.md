# PROJECT REPORT
# Firewall Configuration Using UFW

**Organization:** OASIS INFOBYTE

**Internship Domain:** Cyber Security / Security Analyst

**Task:** Task 2 – Firewall Configuration Using UFW

**Operating System:** Ubuntu Linux

**Virtualization Platform:** Oracle VirtualBox

**Firewall Tool:** Uncomplicated Firewall (UFW)

---

## 1. INTRODUCTION

A firewall is an important component of network security. It monitors and controls incoming and outgoing network traffic based on predefined security rules.

UFW (Uncomplicated Firewall) is a command-line firewall management utility available on Ubuntu Linux. It provides a simple interface for configuring firewall rules and controlling network access.

The purpose of this project is to configure UFW on Ubuntu, establish firewall rules, restrict unwanted network traffic, allow required services, and verify the firewall configuration.

This project was performed as part of the OASIS INFOBYTE Cyber Security Internship.

## 2. OBJECTIVES

The main objectives of this task are:

1. Install UFW on Ubuntu Linux.
2. Enable the firewall.
3. Configure SSH traffic to be allowed through port 22.
4. Configure HTTP traffic to be denied through port 80.
5. Add additional firewall rules.
6. Restrict traffic from a specified IP address range.
7. Verify active firewall rules.
8. Test and document blocked network traffic.
9. Create a Bash script to automate firewall configuration.
10. Document the complete implementation.

## 3. SYSTEM REQUIREMENTS

| Component | Description |
|---|---|
| Operating System | Ubuntu Linux |
| Virtual Machine | Oracle VirtualBox |
| Firewall | UFW |
| Scripting Language | Bash |
| Testing Tool | curl |
| HTTP Server | Python 3 HTTP Server |
| Repository | GitHub |

## 4. INTRODUCTION TO FIREWALL RULES

Firewall rules determine which network connections are permitted and which are blocked.

The following five rules were selected for this project.

### 4.1 Allow SSH – Port 22

Command:

    sudo ufw allow ssh

SSH stands for Secure Shell. It is commonly used for secure remote administration of Linux systems.

This rule permits incoming SSH connections on port 22.

### 4.2 Deny HTTP – Port 80

Command:

    sudo ufw deny http

HTTP stands for Hypertext Transfer Protocol.

It commonly operates on TCP port 80. This rule blocks incoming HTTP connections.

### 4.3 Allow HTTPS – Port 443

Command:

    sudo ufw allow 443/tcp

HTTPS stands for Hypertext Transfer Protocol Secure.

It commonly uses TCP port 443. This rule permits incoming HTTPS traffic.

### 4.4 Deny a Specific IP Range

Command:

    sudo ufw deny from 192.0.2.0/24

This rule blocks incoming traffic originating from the specified IP address range.

The range 192.0.2.0/24 is reserved for documentation and examples.

### 4.5 Allow Custom Port – 8080

Command:

    sudo ufw allow 8080/tcp

This rule permits incoming TCP traffic on port 8080.

It demonstrates how administrators can allow connections for additional applications and services.

## 5. IMPLEMENTATION PROCEDURE

### Step 1: Update Ubuntu Packages

The package information was updated using:

    sudo apt update

This command refreshes the package information available to the Ubuntu package manager.

### Step 2: Install UFW

UFW was installed using:

    sudo apt install ufw -y

The installation was verified using:

    sudo ufw version

### Step 3: Check Initial Firewall Status

The initial firewall status was checked using:

    sudo ufw status verbose

This command displays the current firewall state and configuration.

### Step 4: Configure Default Policies

The following commands were used:

    sudo ufw default deny incoming

    sudo ufw default allow outgoing

These policies deny incoming connections by default while allowing outgoing connections.

### Step 5: Configure Firewall Rules

The five firewall rules described in Section 4 were added.

### Step 6: Enable UFW

The firewall was enabled using:

    sudo ufw enable

This activates the configured firewall rules.

### Step 7: Verify Firewall Configuration

The final firewall configuration was checked using:

    sudo ufw status verbose

The output was reviewed to verify the active firewall status and configured rules.

## 6. AUTOMATION USING BASH SCRIPT

A Bash script named `ufw_configuration.sh` was created to automate firewall configuration.

The script performs the following operations:

- Checks whether UFW is installed.
- Installs UFW if necessary.
- Configures default firewall policies.
- Adds the SSH allow rule.
- Adds the HTTP deny rule.
- Adds the HTTPS allow rule.
- Blocks the specified example IP range.
- Allows TCP port 8080.
- Enables the firewall.
- Displays the final firewall status.

### Script Execution

The script was made executable using:

    chmod +x ufw_configuration.sh

It can be executed using:

    sudo ./ufw_configuration.sh

This automation reduces the need to manually enter every firewall configuration command.

## 7. FIREWALL TESTING AND VERIFICATION

Testing is an important part of firewall configuration because it helps verify whether the configured rules behave as expected.

### 7.1 Verify Active Rules

Command:

    sudo ufw status verbose

The command displays the firewall status, default policies, and configured rules.

### 7.2 HTTP Traffic Testing

A temporary Python HTTP server can be started using:

    sudo python3 -m http.server 80 --bind 0.0.0.0

The Ubuntu IP address can be checked using:

    hostname -I

From another machine that can reach the Ubuntu VM, an HTTP connection can be attempted using:

    curl --connect-timeout 5 -v http://UBUNTU_IP/

The actual test result should be documented.

### 7.3 Check Firewall Logs

Firewall logs can be inspected using:

    sudo grep -i 'DPT=80' /var/log/ufw.log | tail -n 20

Alternatively:

    sudo journalctl -k --since "10 minutes ago" | grep -i UFW

Matching log entries can help establish whether UFW blocked the attempted connection.

### 7.4 Testing Observations

The following observations should be recorded after testing:

| Test | Expected Behaviour |
|---|---|
| SSH – Port 22 | Allowed by UFW |
| HTTP – Port 80 | Denied by UFW |
| HTTPS – Port 443 | Allowed by UFW |
| IP Range – 192.0.2.0/24 | Incoming traffic denied |
| TCP Port 8080 | Allowed by UFW |

A configured ALLOW rule does not guarantee that an application is available on that port.

Similarly, an unsuccessful connection does not independently prove that UFW blocked it. Network connectivity and firewall logs must also be considered.

## 8. SCREENSHOTS AND EVIDENCE

Screenshots are maintained in the `screenshots/` directory.

The following evidence is intended for the project submission:

| Screenshot | Description |
|---|---|
| 01-project-folder.png | Creation of the UFW project directory |
| 02-ufw-installation.png | UFW installation and initial status |
| 03-ufw-status.png | Active firewall configuration |
| 04-firewall-script.png | Execution of the Bash configuration script |
| 05-firewall-script-code.png | UFW configuration script |
| 06-traffic-testing.png | HTTP traffic testing and firewall logs |

Only screenshots of actual completed steps should be included.

## 9. SECURITY IMPORTANCE

Firewall configuration is important for protecting computer systems and networks.

The configured rules demonstrate several security principles:

- Restricting unwanted incoming connections.
- Allowing required network services.
- Controlling access through specific ports.
- Blocking traffic from selected source IP ranges.
- Applying default-deny incoming policies.
- Automating security configurations.
- Verifying firewall activity through status commands and logs.

These practices help administrators manage network exposure and reduce unnecessary access.

## 10. LEARNING OUTCOMES

After completing this task, I gained practical knowledge of:

1. Installing and managing UFW on Ubuntu.
2. Understanding firewall rules and network traffic.
3. Configuring allow and deny rules.
4. Understanding commonly used network ports.
5. Blocking traffic from an IP address range.
6. Applying default firewall policies.
7. Automating configuration using Bash scripting.
8. Verifying firewall status and inspecting logs.
9. Understanding basic network connectivity testing.
10. Documenting practical cybersecurity activities.

## 11. CONCLUSION

This project demonstrates the configuration and management of a Linux firewall using UFW on Ubuntu.

The task involved installing UFW, configuring firewall rules, enabling the firewall, setting default security policies, and creating a Bash script to automate the configuration process.

It also introduced practical methods for verifying firewall settings and investigating blocked network traffic.

Overall, this project provided useful hands-on experience in Linux administration, firewall management, network security, and Bash scripting.

## 12. REFERENCES

1. Ubuntu Server Documentation – Firewall Configuration.
2. UFW Manual – Linux Firewall Management.
3. Ubuntu Linux Manual Pages.
4. Python Documentation – HTTP Server.
5. Git and GitHub Documentation.

---

**Project:** Firewall Configuration Using UFW

**Organization:** OASIS INFOBYTE

**Domain:** Cyber Security / Security Analyst

**Submission:** GitHub Repository
