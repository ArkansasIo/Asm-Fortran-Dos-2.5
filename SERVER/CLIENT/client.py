#!/usr/bin/env python3
import json, urllib.request

class BusinessClient:
    def __init__(self, base_url='http://127.0.0.1:3600'):
        self.base_url = base_url.rstrip('/')
        self.session_token = None

    def request(self, path, payload=None):
        data = None if payload is None else json.dumps(payload).encode()
        req = urllib.request.Request(self.base_url + path, data=data, headers={'Content-Type':'application/json'})
        if self.session_token:
            req.add_header('Authorization', 'Bearer ' + self.session_token)
        with urllib.request.urlopen(req, timeout=10) as response:
            return json.loads(response.read())

    def health(self):
        return self.request('/health')

    def login(self, username, password):
        result = self.request('/api/login', {'username':username, 'password':password})
        self.session_token = result.get('session_token')
        return result

    def run_job(self, name):
        return self.request('/api/jobs/run', {'name':name})
