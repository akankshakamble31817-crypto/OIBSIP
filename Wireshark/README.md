# TASK 8 – Capture Network Traffic with Wireshark

## OASIS INFOBYTE – Security Analyst Internship

## 1. Project Overview

This project focuses on capturing and analysing live network traffic using **Wireshark**, an open-source network protocol analyser.

The objective is to understand how network communication works, identify different protocols, analyse TCP connections, and observe the security risks associated with unencrypted HTTP communication.

The practical exercises are performed in an Ubuntu virtual machine running on Oracle VirtualBox.

## 2. Objectives

- Install and configure Wireshark on Ubuntu.
- Capture live network traffic for at least two minutes.
- Apply display filters to identify HTTP, DNS, and TCP packets.
- Analyse the TCP three-way handshake.
- Identify an HTTP GET request containing unencrypted information.
- Export the captured network traffic as a `.pcap` file.
- Understand the security differences between HTTP and HTTPS.
- Document network analysis findings and security observations.

## 3. Tools and Technologies Used

| Tool | Purpose |
|---|---|
| Wireshark | Network packet capture and analysis |
| Ubuntu Linux | Operating system |
| Oracle VirtualBox | Virtualisation environment |
| Terminal | Executing network commands |
| Nmap (previous task) | Network scanning |
| Git and GitHub | Project documentation and version control |

## 4. System Environment

- Operating System: Ubuntu Linux
- Virtualisation: Oracle VirtualBox
- Network Interface: enp0s3 (VirtualBox NAT, if active)
- Packet Analysis Tool: Wireshark
- Capture Format: PCAP

## 5. Installation of Wireshark

Wireshark was installed using the Ubuntu terminal.

### Step 1: Update package information

```bash
sudo apt update
```

### Step 2: Install Wireshark

```bash
sudo apt install wireshark -y
```

### Step 3: Configure packet capture permissions

During installation, select **Yes** when asked whether non-superusers should be allowed to capture packets.

### Step 4: Add the user to the Wireshark group

```bash
sudo usermod -aG wireshark $USER
```

Restart Ubuntu to apply the group membership.

### Step 5: Verify installation

```bash
wireshark --version
```

Check user permissions:

```bash
groups
```

The `wireshark` group should appear in the output.

## 6. Network Traffic Capture

Wireshark was opened from the Ubuntu terminal:

```bash
wireshark
```

The active network interface was selected from the available interfaces.

For this project, `enp0s3` was used when active.

### Capture procedure

1. Open Wireshark.
2. Select the active network interface.
3. Start packet capture.
4. Generate network traffic using test commands.
5. Continue capturing for at least two minutes.
6. Stop the capture.
7. Save the captured traffic as `wireshark_capture.pcap`.

### Commands used to generate network traffic

DNS traffic:

```bash
nslookup google.com
```

Network connectivity test:

```bash
ping -c 5 google.com
```

HTTPS request:

```bash
curl https://example.com
```

HTTP request:

```bash
curl -v http://neverssl.com/
```

Note: The `curl` package must be installed before using these commands.

## 7. Applying Wireshark Display Filters

Display filters help isolate specific types of network packets from the captured traffic.

### A. HTTP Filter

Display filter:

```text
http
```

Purpose:

- Identify HTTP requests and responses.
- Examine HTTP GET requests.
- Observe unencrypted HTTP communication.

### B. DNS Filter

Display filter:

```text
dns
```

Purpose:

- Identify DNS queries and responses.
- Observe domain name resolution.
- Examine DNS communication between the client and DNS server.

### C. TCP Filter

Display filter:

```text
tcp
```

Purpose:

- Identify TCP packets.
- Examine source and destination ports.
- Analyse TCP connection establishment.

## 8. TCP Three-Way Handshake Analysis

TCP uses a three-way handshake to establish a reliable connection between a client and a server.

The handshake consists of three steps:

### Step 1: SYN

The client sends a SYN packet to request a connection with the server.

### Step 2: SYN-ACK

The server responds with a SYN-ACK packet, acknowledging the client's request.

### Step 3: ACK

The client sends an ACK packet to confirm the connection.

After these three steps, the TCP connection is established.

### Handshake Summary

| Step | Packet | Description |
|---|---|---|
| 1 | SYN | Client requests connection |
| 2 | SYN-ACK | Server acknowledges request |
| 3 | ACK | Client confirms connection |

### Useful Wireshark filters

To identify SYN packets:

```text
tcp.flags.syn == 1
```

To identify ACK packets:

```text
tcp.flags.ack == 1
```

To examine all packets belonging to a particular connection:

```text
tcp.stream eq 0
```

Replace `0` with the actual TCP stream number of the selected connection.

The complete handshake should be identified by examining the packet flags and sequence in the same TCP connection.

## 9. Analysis of Unencrypted HTTP Traffic

HTTP stands for Hypertext Transfer Protocol.

It transfers information between a web browser or client and a web server without encrypting the HTTP application data.

An HTTP GET request can be examined in Wireshark.

Example:

```http
GET / HTTP/1.1
Host: neverssl.com
```

### Information that may be visible

- HTTP request method.
- Requested website or hostname.
- Requested resource path.
- HTTP headers.
- User-Agent information.
- Other information transmitted in the request.

The exact information depends on the captured request.

### Security Risks of Unencrypted HTTP

Unencrypted HTTP traffic is dangerous because:

1. Network observers may read transmitted information.
2. Sensitive information may be exposed.
3. Attackers may intercept communication.
4. Data may be modified during transmission.
5. Users may be exposed to man-in-the-middle attacks.

## 10. HTTP vs HTTPS

HTTPS stands for Hypertext Transfer Protocol Secure.

HTTPS uses TLS encryption to protect communication between a client and a web server.

| HTTP | HTTPS |
|---|---|
| No TLS encryption | Uses TLS encryption |
| Data can be read in plaintext | Application data is encrypted |
| Less secure | More secure |
| Uses port 80 by default | Uses port 443 by default |

### How HTTPS Prevents Eavesdropping

HTTPS protects transmitted application data through encryption.

It provides:

- **Confidentiality:** Prevents unauthorised observers from reading protected application data.
- **Integrity:** Helps detect unauthorised changes to transmitted data.
- **Authentication:** Helps verify the identity of the website through digital certificates.

Although network observers can still see certain metadata, such as IP addresses, ports and connection information, they cannot ordinarily read the encrypted HTTPS application contents.

## 11. Project Screenshots

The following screenshots should be included as practical evidence.

| Screenshot | Description |
|---|---|
| 01_installation.png | Wireshark installation |
| 02_live_capture.png | Live packet capture |
| 03_http_filter.png | HTTP filtered packets |
| 04_dns_filter.png | DNS filtered packets |
| 05_tcp_filter.png | TCP filtered packets |
| 06_tcp_handshake.png | TCP SYN, SYN-ACK and ACK sequence |
| 07_http_get_request.png | Unencrypted HTTP GET request |

## 12. Project Files and Directory Structure

```text
wireshark-task/
│
├── README.md
│
├── wireshark_capture.pcap
│
├── screenshots/
│   ├── 01_installation.png
│   ├── 02_live_capture.png
│   ├── 03_http_filter.png
│   ├── 04_dns_filter.png
│   ├── 05_tcp_filter.png
│   ├── 06_tcp_handshake.png
│   └── 07_http_get_request.png
│
└── analysis/
    └── packet_analysis.md
```

## 13. Glossary

**1. Packet**

A packet is a small unit of data transmitted over a network. Large amounts of information are divided into smaller packets for communication.

**2. Protocol**

A protocol is a set of rules that defines how devices communicate and exchange information over a network.

Examples: HTTP, HTTPS, DNS and TCP.

**3. Port**

A port is a logical communication endpoint used to identify a particular service or application on a device.

Examples: Port 80 for HTTP and port 443 for HTTPS.

**4. Payload**

Payload is the actual data carried inside a network packet, excluding the protocol headers.

**5. Handshake**

A handshake is an exchange of messages between two devices to establish or negotiate a connection before communication begins.

## 14. Security Observations

The practical analysis demonstrates the importance of understanding network protocols and protecting transmitted information.

Key observations:

- DNS packets help identify domain name resolution.
- TCP uses a three-way handshake to establish connections.
- HTTP traffic can expose readable application data.
- HTTPS uses encryption to protect application data.
- Wireshark helps security analysts monitor and investigate network communication.

## 15. Conclusion

This project provided practical experience in capturing and analysing network traffic using Wireshark.

It helped develop an understanding of network protocols, DNS requests, TCP communication, and the three-way handshake.

The analysis of HTTP and HTTPS demonstrated why encryption is essential for protecting information transmitted over networks.

Wireshark is a valuable tool for network troubleshooting, traffic monitoring, and cybersecurity investigations.

## 16. Ethical Considerations

All network traffic captured for this project must belong to the user's own system or an authorised test environment.

Capturing traffic from public Wi-Fi, university networks, or other networks without explicit permission is prohibited.

The project is intended strictly for educational and ethical cybersecurity learning.

---

**Project:** Task 8 – Capture Network Traffic with Wireshark

**Internship:** OASIS INFOBYTE – Security Analyst
