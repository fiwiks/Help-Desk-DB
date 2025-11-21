import http.server
import socketserver
import subprocess
import urllib.parse
import os
import json

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
os.chdir(BASE_DIR)

PORT = 8000
APP_USER = "user"
APP_PASS = "pass"
LOGIN = False

bypass_login = {
    "/static/login.html",
    "/static/styles.css",
    "/static/login.js"
}

class Handler(http.server.SimpleHTTPRequestHandler):

    def do_GET(self):
        global LOGIN
        
        if not LOGIN:
            if (self.path in bypass_login) or self.path.startswith("/login") or self.path.startswith("/static/login"):
                pass
            else:
                self.path = "/static/login.html"
                return http.server.SimpleHTTPRequestHandler.do_GET(self)

        if self.path.startswith("/admin"):
            parsed = urllib.parse.urlparse(self.path)
            params = urllib.parse.parse_qs(parsed.query)
            op = params.get("op", [""])[0]

            if op == "create":
                cmd = ["./runSQL.sh", "create"]
            elif op == "delete":
                cmd = ["./runSQL.sh", "delete"]
            elif op == "insert":
                cmd = ["./runSQL.sh", "insert"]
            else:
                self.send_response(400)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                self.wfile.write(b'{"ok": false, "message": "Unknown operation"}')
                return

            try:
                out = subprocess.check_output(cmd, stderr=subprocess.STDOUT, timeout=60)
                msg = out.decode(errors="ignore")
                ok = True
            except subprocess.CalledProcessError as e:
                print(e)
                ok = False
                msg = e.output.decode(errors="ignore") if e.output else str(e)
            except Exception as e:
                print(e)
                ok = False
                msg = str(e)

            self.send_response(200 if ok else 500)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            response = {"ok": ok, "message": msg}
            self.wfile.write(json.dumps(response).encode())
            return

        if self.path.startswith("/run"):
            parsed = urllib.parse.urlparse(self.path)
            params = urllib.parse.parse_qs(parsed.query)
            q = params.get("q", ["1"])[0]

            query_file = f"sql/web_queries/q{q}.sql"

            result = subprocess.check_output(["./run_query.sh", query_file])

            self.send_response(200)
            self.send_header("Content-Type", "text/html")
            self.end_headers()

            html = f"""
            <html>
                <head>
                    <link rel="stylesheet" href="/static/styles.css">
                </head>
                <body>
                    <a href="/?from=notcache">Back</a>
                    <h1>Query {q} Results</h1>
                    <div class="table-container">
                        {result.decode()}
                    </div>
                </body>
            </html>
            """

            self.wfile.write(html.encode())
            return

        if (self.path == "/" or self.path == "/index.html" or self.path.startswith("/?")):
            self.path = "/static/index.html"

        return http.server.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        if self.path.startswith("/login"):
            length = int(self.headers.get("Content-Length"))
            body = self.rfile.read(length).decode()
            params = urllib.parse.parse_qs(body)

            username = params.get("username",[""])[0]
            password = params.get("password",[""])[0]
            print(username + " " + password)

            if username == APP_USER and password == APP_PASS:
                print("Successful login")
                global LOGIN
                LOGIN = True
                self.send_response(200)
                self.send_header("Content-Type","application/json")
                self.end_headers()
                self.wfile.write(b'{"ok" : true, "message" : "Success"}')
            else:
                print("Failed login")
                self.send_response(401)
                self.send_header("Content-Type","application/json")
                self.end_headers()
                self.wfile.write(b'{"ok" : false, "message" : "Invalid Credentials"}')
            return
                


print(f"Serving at http://localhost:{PORT}")
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    httpd.serve_forever()
