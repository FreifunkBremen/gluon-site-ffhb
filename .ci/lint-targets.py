#!/usr/bin/env python3

from yaml import safe_load as yaml_load
import subprocess
from os import environ, chdir

targets_in_ci = []
targets_in_make = []


##
# Fetch data from .gitlab-ci.yml
##
with open('.gitlab-ci.yml', 'r') as file:
    ci = yaml_load(file)

if "build" in ci:
  targets_in_ci = ci["build"]['parallel']["matrix"][0]['GLUON_TARGET']

##
# Fetch data from gluon make
##
d = dict(environ)
if "GLUON_SITEDIR" not in d:
    d["GLUON_SITEDIR"] = "../"
if "GLUON_DIR" not in d:
    d["GLUON_DIR"] = "./gluon/"
chdir(d["GLUON_DIR"])
result = subprocess.run(['make', 'list-targets'], env=d, stdout=subprocess.PIPE, text=True)

targets_in_make = result.stdout.splitlines()

##
# Compare
##
only_in_ci = [ item for item in targets_in_ci if item not in targets_in_make]
only_in_make = [ item for item in targets_in_make if item not in targets_in_ci]

if len(only_in_ci) > 0:
    print(f"\U0001F525 CI-Pipeline contains not supported TARGETS: {only_in_ci}")
    exit(1)

if len(only_in_make) > 0:
    print(f"\u26a0 CI-Pipeline does not contain all supported TARGETS: {only_in_make}")
else:
    print("\u2705 works well - let's build for every TARGET a firmware")
