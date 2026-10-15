#!/usr/bin/env python3
"""Simple cron-style job runner for BUSINESS-OS.

Jobs are declared in SERVER/JOBS/jobs.json. This runner is intentionally
small and portable; production deployments can map the same job definitions
to systemd timers, cron, Windows Task Scheduler, or a queue worker.
"""
import json, subprocess, time, pathlib, datetime

ROOT = pathlib.Path(__file__).resolve().parents[2]
JOB_FILE = ROOT / "SERVER" / "JOBS" / "jobs.json"

def load_jobs():
    return json.loads(JOB_FILE.read_text(encoding="utf-8"))

def due(job, now):
    return job.get("enabled", True) and now.minute % int(job.get("interval_minutes", 60)) == 0

def run_job(job):
    command = job.get("command")
    if not command: return
    subprocess.run(command, shell=True, cwd=ROOT, check=False)

if __name__ == "__main__":
    while True:
        now = datetime.datetime.now()
        for job in load_jobs().get("jobs", []):
            if due(job, now):
                run_job(job)
        time.sleep(60)
