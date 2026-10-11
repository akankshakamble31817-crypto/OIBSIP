# UFW Firewall Configuration and Testing

## 1. Project Overview
This project demonstrates how to configure and inspect the UFW
(Uncomplicated Firewall) in Ubuntu Linux.

The objective is to manage incoming network traffic, configure
firewall rules, and examine firewall logs to investigate blocked traffic.

## 2. Objectives
- Check the status of the UFW firewall.
- Configure rules to allow or deny incoming traffic.
- Deny incoming traffic from a specified IP address range.
- Inspect firewall logs.
- Test network connectivity and document the results.

## 3. Tools Used
- Ubuntu Linux
- UFW (Uncomplicated Firewall)
- VirtualBox
- Windows Command Prompt
- Git and GitHub

## 4. Firewall Configuration

Check the firewall status:

    sudo ufw status numbered

Display network IP addresses:

    ip -4 addr

Display listening TCP ports:

    sudo ss -lntp

Inspect recent UFW firewall logs:

    sudo journalctl -k --since "30 minutes ago" --no-pager | grep -i UFW

## 5. Configured Firewall Rules

The project uses the following firewall rules:

- Allow incoming SSH traffic on TCP port 22.
- Deny incoming HTTP traffic on TCP port 80.
- Allow incoming traffic on port 443.
- Deny incoming FTP traffic on TCP port 21.
- Deny incoming traffic from the 192.168.56.0/24 source range.

Note: The actual behavior depends on the applicable firewall rules,
network configuration, and traffic path.

## 6. Testing Method

1. Check the UFW status and configured rules.
2. Identify the Windows and Ubuntu IP addresses.
3. Test connectivity from Windows to Ubuntu.
4. Run a temporary HTTP server on Ubuntu for a TCP connection test.
5. Inspect the UFW kernel logs for blocked packets.

## 7. Test Results

- UFW was active during testing.
- A ping request from Windows to Ubuntu timed out.
- A connection attempt to the temporary HTTP server was unsuccessful.
- UFW logs contained blocked TCP packets.
- The available logs did not establish that the specific Windows
  test connection was blocked by the intended source-range rule.

Further verification is needed to confirm that the Windows test
traffic matches the intended UFW rule.

## 8. Screenshots

Place screenshots of the following in the screenshots directory:

- UFW status and numbered rules.
- Ubuntu IP address information.
- Windows connectivity test.
- UFW firewall log output.

## 9. Conclusion

This project demonstrates basic UFW firewall configuration,
network connectivity testing, and firewall log inspection in Ubuntu.
The results highlight the importance of verifying firewall behavior
with evidence from the actual test traffic.

## 10. Safety Note

Use firewall testing only on systems and networks you own or have
permission to test. Avoid changing firewall rules on remote systems
without ensuring that administrative access will remain available.
