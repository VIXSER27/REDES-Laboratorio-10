from http.server import HTTPServer, BaseHTTPRequestHandler

with open("VERSION") as f:
    VERSION = f.read().strip()

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"ok")
        else:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(f"PagosYA api {VERSION}".encode())

HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()
