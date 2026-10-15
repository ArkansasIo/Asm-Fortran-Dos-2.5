#!/usr/bin/env python3
"""BUSINESS-OS backend service reference implementation.

This service owns authentication, scheduling, API dispatch, and persistence boundaries.
The production database adapter may be replaced by the native MySQL layer.
"""
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json, os, time, secrets

HOST = os.getenv("BUSINESS_OS_HOST", "127.0.0.1")
PORT = int(os.getenv("BUSINESS_OS_PORT", "3600"))
SESSIONS = {}
JOBS = {}

class Handler(BaseHTTPRequestHandler):
    def _send(self, status, payload):
        data = json.dumps(payload).encode()
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        if self.path == "/health":
            self._send(200, {"status":"ok", "service":"business-os-backend"})
        elif self.path == "/api/jobs":
            self._send(200, {"jobs": list(JOBS.values())})
        else:
            self._send(404, {"error":"not_found"})

    def do_POST(self):
        length = int(self.headers.get("Content-Length", "0"))
        try:
            body = json.loads(self.rfile.read(length) or b"{}")
        except json.JSONDecodeError:
            self._send(400, {"error":"invalid_json"}); return
        if self.path == "/api/login":
            token = secrets.token_urlsafe(32)
            SESSIONS[token] = {"created": time.time(), "user": body.get("username", "")}
            self._send(200, {"status":"ok", "session_token":token})
        elif self.path == "/api/jobs/run":
            name = body.get("name", "")
            if not name:
                self._send(400, {"error":"job_name_required"}); return
            job_id = secrets.token_hex(8)
            JOBS[job_id] = {"id":job_id,"name":name,"status":"queued","created":time.time()}
            self._send(202, JOBS[job_id])
        else:
            self._send(404, {"error":"not_found"})

if __name__ == "__main__":
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()
