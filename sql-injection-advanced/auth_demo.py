import sqlite3
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import parse_qs

DB = "auth_demo.db"

def setup_database():
    conn = sqlite3.connect(DB)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
        )
    """)
    conn.execute(
        "INSERT OR IGNORE INTO users VALUES (1, 'admin', 'admin123')"
    )
    conn.commit()
    conn.close()

class LoginHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()

        self.wfile.write(b"""
        <h2>Local Vulnerable Login Lab</h2>
        <form method="POST">
            Username: <input name="username"><br><br>
            Password: <input name="password" type="password"><br><br>
            <button type="submit">Login</button>
        </form>
        """)

    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        data = self.rfile.read(length).decode()
        values = parse_qs(data)

        username = values.get("username", [""])[0]
        password = values.get("password", [""])[0]

        conn = sqlite3.connect(DB)

        # Intentionally vulnerable query for this local demonstration
        query = (
            "SELECT username FROM users "
            f"WHERE username = '{username}' "
            f"AND password = '{password}'"
        )

        try:
            result = conn.execute(query).fetchone()
        except sqlite3.Error:
            result = None

        conn.close()

        message = (
            "Login successful!"
            if result
            else "Invalid username or password."
        )

        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()
        self.wfile.write(f"<h2>{message}</h2>".encode())

setup_database()

print("Local authentication lab: http://127.0.0.1:5000")

HTTPServer(("127.0.0.1", 5000), LoginHandler).serve_forever()
