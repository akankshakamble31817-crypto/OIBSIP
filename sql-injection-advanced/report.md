# Advanced SQL Injection -- Project Report

## 1. Title

**Advanced SQL Injection Demonstration and Prevention**

## 2. Introduction

SQL injection is a web application security vulnerability that occurs
when untrusted input is incorporated into an SQL query in an unsafe
manner. An attacker may be able to change the intended meaning of a
query, potentially exposing or modifying data or affecting
authentication.

This project explores SQL injection in a controlled local lab using
DVWA. It also includes a separate Python login application to
demonstrate insecure query construction and secure coding practices.

## 3. Objectives

-   Understand the concept and impact of SQL injection.
-   Configure and use DVWA in a local virtual machine.
-   Inspect HTTP requests using Burp Suite.
-   Perform manual SQL injection testing.
-   Identify the database through the tested request.
-   Run SQLMap automated testing against the local lab.
-   Demonstrate insecure authentication query construction in a separate
    local Python application.
-   Develop a Bash script for restricted local testing.
-   Describe prevention techniques using parameterized queries.

## 4. Environment

  Component                         Description
  --------------------------------- -------------------------------------------
  Operating system                  Ubuntu in VirtualBox
  Vulnerable practice application   DVWA
  DVWA address                      `http://127.0.0.1:8080/`
  Interception tool                 Burp Suite
  Automated testing tool            SQLMap
  Scripting                         Bash and Python 3
  Browser                           Firefox
  DVWA security setting             Medium, as configured during the exercise

## 5. Methodology and Work Performed

### 5.1 DVWA configuration

DVWA was opened in the local browser and its security setting was
configured to Medium. This provided the practice environment for the SQL
Injection module.

**Evidence:** Add the actual DVWA security screenshot filename.

### 5.2 Burp Suite request interception

Burp Suite was used to intercept and inspect the HTTP request sent by
the DVWA SQL Injection page. The request was reviewed so that the
relevant parameter and session information could be used for authorized
local testing.

**Evidence:** Add the actual Burp request/response screenshot filename.
Redact session cookies before sharing screenshots.

### 5.3 Manual SQL injection

Manual SQL injection testing was performed against the local DVWA SQL
Injection module. The request and response were examined to understand
how the application handled the supplied parameter.

**Observed result:** Enter the actual result shown by DVWA. Do not add
records or other data unless they were visibly returned by the lab.

**Evidence:** Add the actual manual-testing screenshot filename.

### 5.4 Database identification

Database identification was performed through the local DVWA SQL
Injection request.

**Database name reported:**
`[Enter the actual database name shown by your output]`

**Database/version details:** `[Enter only if displayed by your test]`

**Evidence:** Add the actual database-identification screenshot
filename.

### 5.5 SQLMap automated testing

SQLMap was installed and used with a saved Burp request. The test was
restricted to the `id` parameter and used low risk and level settings.

Command used:

``` bash
sqlmap -r evidence/dvwa_sqli_request.txt \
  -p id --batch --risk=1 --level=1 --current-db \
  --output-dir=evidence/sqlmap-output
```

**Actual SQLMap result:**
`[Record whether SQLMap detected injection and copy the database name, if reported. If it did not detect injection, state that clearly.]`

**Evidence:** Add the actual SQLMap screenshot filename.

### 5.6 Authentication demonstration

A separate Python application was created in `auth-lab/auth_demo.py` and
bound to `127.0.0.1:5000`. It intentionally builds an SQL query by
concatenating login input into the query string. The application was
used to demonstrate normal valid and invalid login behavior and to
explain the risk of unsafe query construction.

**Important distinction:** This was a separate local demonstration. It
was not the DVWA login page, and it should not be described as a
successful bypass of DVWA authentication.

**Evidence:** Add the actual login page, valid login, and invalid login
screenshot filenames.

### 5.7 Bash exploit/testing script

The Bash script `sql_injection_exploit.sh` was created to check for
SQLMap, verify that the saved request exists, restrict the target to a
local DVWA request, run SQLMap with low test settings, and save output
to a log.

Commands used:

``` bash
chmod +x sql_injection_exploit.sh
bash -n sql_injection_exploit.sh
./sql_injection_exploit.sh
```

**Validation note:** The first recorded execution stopped with the
message `Request is not addressed to localhost.` The subsequent check
`grep -i "^Host:" evidence/dvwa_sqli_request.txt` returned no matching
line. This indicates that the request file did not contain a `Host:`
header in the format expected by the script. Record a successful
execution only after correcting the saved request format and verifying
the output. If it remains unresolved, report it as a limitation rather
than claiming success.

**Evidence:** Add the actual script and execution screenshot filenames
after verification.

## 6. Results Summary

  ----------------------------------------------------------------------------
  Activity                Status                  Result / Evidence
  ----------------------- ----------------------- ----------------------------
  DVWA Medium             Completed               Add screenshot
  configuration                                   

  Burp Suite interception Completed               Add screenshot

  Manual SQL injection    Completed               Add actual observation

  Database identification Completed               Add actual database name

  SQLMap installation     Completed               Version previously reported
                                                  as `1.10.4#stable`

  SQLMap automated        Reported completed      Add actual detection result
  testing                                         

  Separate Python         Reported completed      Add valid/invalid login
  authentication                                  evidence
  demonstration                                   

  Bash script creation    Created                 `sql_injection_exploit.sh`

  Bash script successful  Needs verification      Initial run stopped at
  execution                                       localhost check

  Database table          Not confirmed in the    Add actual output if
  enumeration             available progress      completed

  Column enumeration      Not confirmed in the    Add actual output if
                          available progress      completed
  ----------------------------------------------------------------------------

## 7. Vulnerability Explanation

The Python demonstration uses unsafe string concatenation to construct
an SQL query. When application input is inserted directly into a query,
the database may interpret that input as part of the SQL statement
rather than as ordinary data.

This is the core weakness behind SQL injection. Input validation alone
is not a replacement for parameterized queries.

## 8. Prevention and Remediation

### 8.1 Python

Use parameterized queries:

``` python
query = """
    SELECT username
    FROM users
    WHERE username = ? AND password_hash = ?
"""
cursor.execute(query, (username, password_hash))
```

### 8.2 PHP with MySQLi

Use prepared statements:

``` php
$stmt = $conn->prepare(
    "SELECT user_id, username FROM users WHERE username = ?"
);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
```

### 8.3 Additional recommendations

-   Use parameterized queries or prepared statements for database
    operations.
-   Store passwords using a modern password-hashing algorithm; never
    store plaintext passwords.
-   Use a database account with only the permissions the application
    needs.
-   Validate input on the server side, while still using parameterized
    queries.
-   Avoid revealing detailed SQL errors to end users.
-   Keep application dependencies and database software updated.
-   Protect session cookies and use secure session management.

## 9. Limitations

-   Testing was limited to an intentionally vulnerable local lab.
-   Results depend on the DVWA configuration, HTTP request, session
    state, and SQLMap detection.
-   The actual database name, SQLMap detection details, and table/column
    enumeration results must be filled in from the user's own terminal
    output.
-   The first recorded execution of the Bash script failed its
    localhost-header check; successful script execution must be verified
    before reporting it as complete.
-   The Python login application is a teaching demonstration, not
    production-ready authentication software.

## 10. Conclusion

The project demonstrates a workflow for examining SQL injection in a
controlled environment using manual testing, HTTP request inspection,
and automated testing. The separate Python demonstration illustrates the
danger of building SQL queries through string concatenation.
Parameterized queries, secure password hashing, least-privilege database
access, and careful session management are important defenses against
these risks.

## 11. References

1.  DVWA -- https://github.com/digininja/DVWA
2.  SQLMap -- https://github.com/sqlmapproject/sqlmap
3.  SQLMap Usage Guide --
    https://github.com/sqlmapproject/sqlmap/wiki/Usage
4.  OWASP SQL Injection Prevention Cheat Sheet --
    https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html

## 12. Appendix: Evidence Checklist

-   [ ] DVWA Medium security screenshot
-   [ ] Burp request/response screenshot (cookies redacted)
-   [ ] Manual SQL injection screenshot(s)
-   [ ] Database identification screenshot
-   [ ] SQLMap automated testing screenshot
-   [ ] Authentication demo login page screenshot
-   [ ] Authentication demo valid login screenshot
-   [ ] Authentication demo invalid login screenshot
-   [ ] Exploit script source screenshot
-   [ ] Successful exploit script execution screenshot
-   [ ] SQLMap log and output evidence
-   [ ] Database table enumeration evidence, if completed
-   [ ] Column enumeration evidence, if completed
