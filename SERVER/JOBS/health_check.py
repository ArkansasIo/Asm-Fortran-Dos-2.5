#!/usr/bin/env python3
import json, urllib.request
url = 'http://127.0.0.1:3600/health'
try:
    with urllib.request.urlopen(url, timeout=5) as response:
        print(json.loads(response.read()))
except Exception as exc:
    print(json.dumps({'status':'error','message':str(exc)}))
