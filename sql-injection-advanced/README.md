# Advanced SQL Injection -- OASIS INFOBYTE Security Analyst Task

## Project Overview

This project demonstrates SQL injection concepts in an intentionally
vulnerable, locally hosted lab. The work uses Damn Vulnerable Web
Application (DVWA), Burp Suite, SQLMap, and a separate local Python
authentication demonstration.

**Safety:** All testing is intended for the user's own local lab only.
Do not test websites, systems, or accounts without explicit
authorization.

## Objectives

-   Understand how SQL injection can affect database-backed
    applications.
-   Perform manual SQL injection testing in DVWA.
-   Identify the database through the tested DVWA request.
-   Use SQLMap for automated testing of the local DVWA SQL injection
    endpoint.
-   Demonstrate insecure query construction in a separate local Python
    login application.
-   Create a Bash script for restricted local SQLMap testing.
-   Explain defensive coding practices using parameterized queries.

## Tools and Technologies

-   Ubuntu running in VirtualBox
-   DVWA (locally hosted)
-   Burp Suite
-   SQLMap
-   Python 3
-   Bash
-   Firefox

## Lab Scope and Safety

The DVWA target is configured locally at:

`http://127.0.0.1:8080/`

The authentication demonstration is a separate Python application bound
to:

`http://127.0.0.1:5000/`

The Python demonstration is intentionally vulnerable and must remain
bound to `127.0.0.1`. It is not the DVWA login page. The DVWA SQL
Injection module and DVWA authentication page are separate application
features; this project does not claim that the DVWA login itself was
bypassed.

## Project Structure

``` text
sql-injection-advanced/
├── auth-lab/
│   ├── auth_demo.py
│   └── auth_demo.db                 # Local database; do not publish
├── evidence/
│   ├── dvwa_sqli_request.txt        # Contains session data; do not publish
│   ├── sqlmap-output/
│   └── sqlmap_script.log
├── screenshots/
├── sql_injection_exploit.sh
├── README.md
└── report.md
```

Add the screenshots you actually captured to the `screenshots/` folder
and update this structure if needed.

## Work Completed

Based on the steps reported as completed during the lab:

1.  DVWA was configured to Medium security.
2.  Burp Suite was used to intercept and inspect the DVWA SQL Injection
    request.
3.  Manual SQL injection testing was performed in the local DVWA lab.
4.  Database identification was performed.
5.  SQLMap was installed and automated testing was run using the saved
    Burp request.
6.  A separate local Python login demonstration was created and tested
    with valid and invalid credentials.
7.  The Bash exploit/testing script was created and made executable.

**Verification note:** The first execution of `sql_injection_exploit.sh`
stopped at its localhost check because the saved request did not contain
a `Host:` header matching the script's check. Do not describe the script
as successfully executed until the request-format issue is corrected and
a successful run is captured. If you have since corrected it and
verified a successful run, update this note with the actual result.

## SQLMap Automated Test

The script is designed to use the saved Burp request and test only the
`id` parameter with low test settings. The equivalent SQLMap command is:

``` bash
sqlmap -r evidence/dvwa_sqli_request.txt \
  -p id --batch --risk=1 --level=1 --current-db \
  --output-dir=evidence/sqlmap-output
```

SQLMap results depend on the request, session cookie, DVWA
configuration, and application response. Record only the database name
and detection results actually shown by your terminal. Do not invent a
database name or claim that injection was detected if SQLMap did not
report it.

## Running the Bash Script

From the project directory:

``` bash
chmod +x sql_injection_exploit.sh
./sql_injection_exploit.sh
```

Check syntax:

``` bash
bash -n sql_injection_exploit.sh
```

Review the log:

``` bash
cat evidence/sqlmap_script.log
```

The script checks for SQLMap, checks that the saved request exists,
checks the request target, runs SQLMap with low test settings, and saves
output to `evidence/`. The request must be a complete HTTP request
addressed to the local DVWA host. Never weaken the local-target
restriction just to make the script pass.

## Authentication Demonstration

The project includes a separate local Python login demonstration
(`auth-lab/auth_demo.py`). It constructs a SQL query using string
concatenation to illustrate why directly inserting user input into SQL
is unsafe.

Run it from the `auth-lab` directory:

``` bash
cd auth-lab
python3 auth_demo.py
```

Open `http://127.0.0.1:5000/` in Firefox. The demonstration account
configured in the sample application is `admin` with password
`admin123`. This is a disposable lab credential only; never reuse it.

The application is intentionally insecure. Do not expose it to a network
or use real credentials. Stop it with `Ctrl+C` when finished.

## Prevention and Secure Coding

### Python parameterized query

Use placeholders and pass user values separately:

``` python
query = """
    SELECT username
    FROM users
    WHERE username = ? AND password_hash = ?
"""
cursor.execute(query, (username, password_hash))
```

For real authentication systems, store passwords using a modern
password-hashing function such as Argon2id, bcrypt, or scrypt. Do not
store plaintext passwords.

### PHP prepared statement (MySQLi)

``` php
$stmt = $conn->prepare(
    "SELECT user_id, username FROM users WHERE username = ?"
);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
```

Additional protections include least-privilege database accounts,
server-side input validation, generic authentication error messages,
secure session handling, and keeping database and application software
updated.

## Evidence and Sensitive Files

Before publishing the project to GitHub, ensure that request files,
cookies, session identifiers, local database files, and generated files
containing sensitive data are excluded.

Suggested `.gitignore` entries:

``` gitignore
evidence/dvwa_sqli_request.txt
evidence/sqlmap-output/
evidence/sqlmap_script.log
auth-lab/auth_demo.db
__pycache__/
*.pyc
```

Review screenshots and redact cookies, tokens, passwords, and personal
information.

## References

-   DVWA: https://github.com/digininja/DVWA
-   SQLMap: https://github.com/sqlmapproject/sqlmap
-   SQLMap usage guide:
    https://github.com/sqlmapproject/sqlmap/wiki/Usage
-   OWASP SQL Injection Prevention Cheat Sheet:
    https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html

## Conclusion

This lab provides practical experience with manual and automated SQL
injection testing in a controlled environment. It also demonstrates why
dynamically concatenated SQL queries are unsafe and why parameterized
queries and secure password storage are essential.
