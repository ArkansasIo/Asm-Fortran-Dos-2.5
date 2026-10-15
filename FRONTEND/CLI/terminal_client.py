#!/usr/bin/env python3
from SERVER.CLIENT.client import BusinessClient

client=BusinessClient()
print('BUSINESS-OS TERMINAL CLIENT')
print('Type HELP or EXIT')
while True:
    try: command=input('C:\\BUSINESS> ').strip().upper()
    except EOFError: break
    if command=='EXIT': break
    if command=='HELP': print('HEALTH JOBS RUN <name> EXIT'); continue
    if command=='HEALTH': print(client.health()); continue
    if command.startswith('RUN '): print(client.run_job(command[4:].lower())); continue
    print('Unknown command. Type HELP.')
