# SQL Injection on DVWA — Low Security

## Project Overview

This project demonstrates SQL injection using the Damn Vulnerable Web Application (DVWA) in a local Ubuntu virtual machine.

The objective is to understand how unsafe SQL query construction can allow crafted user input to change database query behavior.

## Tools and Technologies

- Ubuntu Linux
- Oracle VirtualBox
- Docker and Docker Compose
- Damn Vulnerable Web Application (DVWA)
- MariaDB
- Firefox Web Browser

## Objective

To demonstrate Boolean-based SQL injection in DVWA with the security level configured to Low.

## Practical Steps

1. Start DVWA in the local Ubuntu environment.
2. Initialize the application database.
3. Log in to DVWA.
4. Set the security level to Low.
5. Open the SQL Injection module.
6. Submit a normal user ID and record the output.
7. Perform two Boolean-based SQL injection tests.
8. Capture screenshots and document the results.
9. Explain the vulnerability and recommend mitigations.

## Test Results

### Normal Input

Input: `1`

Result: The application returned the admin record.

### Injection Test 1

Payload: `1' OR '1'='1`

Result: Five user records were returned.

### Injection Test 2

Payload: `1' OR '2'='2`

Result: The same five user records were returned.

## Security Impact

Improper SQL query construction can allow user input to interfere with query logic and expose unintended database records.

## Recommended Mitigations

- Use prepared statements and parameterized queries.
- Validate input before processing it.
- Avoid concatenating untrusted input into SQL queries.
- Follow the principle of least privilege for database accounts.
- Handle database errors securely.

## Conclusion

The practical successfully demonstrated Boolean-based SQL injection in DVWA at Low security. Both test payloads caused the application to return multiple records.

This exercise was performed in a local, intentionally vulnerable training environment.

## Evidence

The `screenshots/` directory contains the practical screenshots. The `sql_injection_notes.md` file documents the individual tests and observations.
