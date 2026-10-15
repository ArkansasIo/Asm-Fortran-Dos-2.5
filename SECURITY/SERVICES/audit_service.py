#!/usr/bin/env python3
from datetime import datetime, timezone
from pathlib import Path
import json

LOG=Path('data/audit/audit.jsonl')

def audit(event_type, user_id=None, details=None):
    LOG.parent.mkdir(parents=True, exist_ok=True)
    record={'timestamp':datetime.now(timezone.utc).isoformat(),'event_type':event_type,'user_id':user_id,'details':details}
    with LOG.open('a',encoding='utf-8') as f: f.write(json.dumps(record)+'\n')
