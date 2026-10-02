"""CORS+PNA file server: lets an HTTPS console page fetch local upload materials.

Chrome sends an OPTIONS preflight (Private Network Access) when a public HTTPS
page fetches http://127.0.0.1 — plain http.server fails it silently.
"""
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

ROOT = os.path.dirname(os.path.abspath(__file__))


class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=ROOT, **kwargs)

    def _cors(self):
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "*")
        self.send_header("Access-Control-Allow-Private-Network", "true")

    def end_headers(self):
        self._cors()
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(204)
        self.end_headers()

    def log_message(self, fmt, *args):
        with open(os.path.join(ROOT, "serve_files.log"), "a", encoding="utf-8") as fh:
            fh.write("%s - %s\n" % (self.address_string(), fmt % args))


if __name__ == "__main__":
    ThreadingHTTPServer(("127.0.0.1", 8765), Handler).serve_forever()
