# OASIS INFOBYTE Cyber Security Internship

## Task 2: Firewall Configuration Using UFW

### 1. Project Overview

This project demonstrates the configuration and management of a firewall using UFW (Uncomplicated Firewall) on Ubuntu Linux.

The main objective is to configure firewall rules to control incoming network traffic, allow trusted services, block unwanted connections, verify firewall settings, and test whether restricted traffic is blocked.

This task provides practical experience in Linux firewall administration and basic network security.

---

### 2. Objectives

- Install and configure UFW on Ubuntu.
- Enable the firewall and configure default policies.
- Allow SSH traffic through port 22.
- Deny HTTP traffic through port 80.
- Allow HTTPS traffic through port 443.
- Block traffic from a specified IP address range.
- Configure an additional custom port rule.
- Verify active firewall rules.
- Test and document blocked network traffic.
- Automate firewall configuration using a Bash script.

---

### 3. Tools and Technologies

| Tool | Purpose |
|---|---|
| Ubuntu Linux | Operating system |
| UFW | Firewall management |
| Oracle VirtualBox | Virtual machine environment |
| Bash Shell | Firewall automation |
| Python 3 | Temporary HTTP server for testing |
| curl | Network connection testing |
| Git and GitHub | Version control and project submission |

---

### 4. What is UFW?

UFW stands for **Uncomplicated Firewall**.

It is a command-line firewall management utility available on Ubuntu Linux. It provides a simple way to manage firewall rules without manually configuring complex firewall settings.

A firewall monitors and controls incoming and outgoing network traffic based on predefined security rules.

UFW helps administrators:

- Allow specific network connections.
- Deny unwanted connections.
- Restrict traffic from particular IP addresses.
- Manage network access through specific ports.
- Monitor firewall activity.

---

### 5. Firewall Configuration

The following firewall rules were configured for this project.

#### Rule 1: Allow SSH (Port 22)

Command:

```bash
sudo ufw allow ssh
```

Purpose:

Allows incoming SSH connections on TCP port 22.

SSH (Secure Shell) is commonly used for secure remote access and administration of Linux systems.

#### Rule 2: Deny HTTP (Port 80)

Command:

```bash
sudo ufw deny http
```

Purpose:

Blocks incoming HTTP traffic on TCP port 80.

This rule demonstrates how to restrict access to an unencrypted web service.

#### Rule 3: Allow HTTPS (Port 443)

Command:

```bash
sudo ufw allow 443/tcp
```

Purpose:

Allows incoming TCP connections on port 443, commonly used by HTTPS websites.

HTTPS provides encrypted communication between clients and web servers. Allowing this port does not automatically create an HTTPS service.

#### Rule 4: Deny a Specific IP Range

Command:

```bash
sudo ufw deny from 192.0.2.0/24
```

Purpose:

Blocks incoming traffic originating from the specified IP address range.

The range `192.0.2.0/24` is reserved for documentation and examples.

This rule demonstrates how to restrict network traffic from a particular source range.

#### Rule 5: Allow Custom Port 8080

Command:

```bash
sudo ufw allow 8080/tcp
```

Purpose:

Allows incoming TCP connections through port 8080.

This rule demonstrates how to permit traffic for an additional application or custom network service.

---

### 6. Default Firewall Policies

The following default policies were configured:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

Explanation:

- Deny incoming: Blocks incoming connections unless explicitly permitted by a firewall rule.
- Allow outgoing: Permits outgoing connections by default.

These policies provide a basic security configuration by restricting unsolicited incoming connections.

---

### 7. Installation and Configuration

#### Step 1: Update package information

```bash
sudo apt update
```

#### Step 2: Install UFW

```bash
sudo apt install ufw -y
```

#### Step 3: Check UFW version

```bash
sudo ufw version
```

#### Step 4: Configure firewall rules

Add the five firewall rules described in Section 5.

#### Step 5: Enable UFW

```bash
sudo ufw enable
```

#### Step 6: Verify firewall status

```bash
sudo ufw status verbose
```

The status command displays whether the firewall is active, the default policies, logging status, and configured rules.

**Note:** Firewall configuration should be reviewed before enabling UFW, particularly on remote systems, to avoid accidentally blocking essential services.

---

### 8. Automated Firewall Configuration

A Bash script named `ufw_configuration.sh` was created to automate firewall configuration.

The script performs the following operations:

1. Checks whether UFW is installed.
2. Installs UFW if necessary.
3. Sets default incoming and outgoing policies.
4. Allows SSH traffic on port 22.
5. Denies HTTP traffic on port 80.
6. Allows HTTPS traffic on port 443.
7. Denies traffic from `192.0.2.0/24`.
8. Allows TCP traffic on port 8080.
9. Enables UFW.
10. Displays the final firewall status.

#### Execute the script

Make the script executable:

```bash
chmod +x ufw_configuration.sh
```

Run the script:

```bash
sudo ./ufw_configuration.sh
```

**Note:** Review existing firewall rules and services before executing the script. Running it repeatedly may create duplicate rules.

---

### 9. Testing and Verification

Firewall configuration was verified using:

```bash
sudo ufw status verbose
```

A controlled HTTP connection test can be performed using a temporary Python HTTP server.

#### Step 1: Start a temporary HTTP server

```bash
sudo python3 -m http.server 80 --bind 0.0.0.0
```

#### Step 2: Find the Ubuntu IP address

```bash
hostname -I
```

#### Step 3: Test from another reachable machine

```bash
curl --connect-timeout 5 -v http://UBUNTU_IP/
```

Replace `UBUNTU_IP` with the actual IP address of the Ubuntu virtual machine.

#### Step 4: Check firewall logs

```bash
sudo grep -i 'DPT=80' /var/log/ufw.log | tail -n 20
```

Alternatively:

```bash
sudo journalctl -k --since "10 minutes ago" | grep -i UFW
```

A matching UFW log entry showing blocked traffic to destination port 80 provides evidence that the firewall denied the connection.

**Testing note:** A failed connection alone does not prove that UFW blocked the traffic. Network connectivity, VirtualBox networking mode, and firewall logs must also be considered. Testing from localhost is not sufficient to demonstrate that external HTTP traffic is blocked.

---

### 10. Screenshots and Evidence

The `screenshots/` directory contains visual evidence collected during project implementation.

| Screenshot | Description |
|---|---|
| 01-project-folder.png | UFW project folder structure |
| 02-ufw-installation.png | UFW installation and initial status |
| 03-ufw-status.png | Active firewall rules |
| 04-firewall-script.png | Execution of the configuration script |
| 05-firewall-script-code.png | Firewall configuration script |
| 06-traffic-testing.png | Network traffic testing and results |

Screenshots should represent actual command execution and testing results.

---

### 11. Project Directory Structure

```text
ufw-task/
│
├── README.md
│
├── ufw_configuration.sh
│
└── screenshots/
    ├── 01-project-folder.png
    ├── 02-ufw-installation.png
    ├── 03-ufw-status.png
    ├── 04-firewall-script.png
    ├── 05-firewall-script-code.png
    └── 06-traffic-testing.png
```

---

### 12. Learning Outcomes

Through this task, I gained practical knowledge of:

- Linux firewall administration.
- UFW installation and configuration.
- Managing incoming and outgoing network traffic.
- Allowing and denying network ports.
- Blocking traffic from specific IP ranges.
- Understanding SSH, HTTP, and HTTPS ports.
- Automating firewall configuration using Bash scripting.
- Verifying firewall rules and examining logs.
- Testing network connectivity and documenting results.

---

### 13. Conclusion

This project demonstrates the practical implementation of firewall security using UFW on Ubuntu Linux.

By configuring different firewall rules, I learned how to control network traffic, allow essential services, block unwanted connections, and manage network access through specific ports and IP ranges.

The project also demonstrates the use of Bash scripting to automate firewall configuration and the importance of verifying and testing firewall rules.

Overall, this task provided valuable hands-on experience in Linux system administration, network security, and basic firewall management.

---

### Disclaimer

This project was developed for educational purposes as part of the OASIS INFOBYTE Cyber Security Internship.

Firewall configurations should always be reviewed and tested carefully before being implemented on production systems.
