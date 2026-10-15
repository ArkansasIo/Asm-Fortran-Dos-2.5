#!/usr/bin/env python3
from datetime import datetime, timezone
from pathlib import Path
out = Path('data/reports'); out.mkdir(parents=True, exist_ok=True)
(out / 'scheduled-report.log').open('a', encoding='utf-8').write(
    f"report job executed {datetime.now(timezone.utc).isoformat()}\n")
