#!/usr/bin/env python

import os
import sys
import string
import getpass

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: generate_config.py <NUMBER>")
        sys.exit(1)
    number = sys.argv[1]

    instance = os.environ.get('MID_INSTANCE')
    username = os.environ.get('MID_USERNAME')
    password = os.environ.get('MID_PASSWORD')

    if not instance:
        print("Instance: ", end='', flush=True, file=sys.stderr)
        instance = sys.stdin.readline().strip().replace('.service-now.com', '')

    if not username:
        print("Username: ", end='', flush=True, file=sys.stderr)
        username = sys.stdin.readline().strip()

    if not password:
        password = getpass.getpass()

    with open('config.xml') as infile:
        tmpl = string.Template(infile.read())
        print(tmpl.substitute(instance=instance,
                              username=username,
                              password=password,
                              number=number))
