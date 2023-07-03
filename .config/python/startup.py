# import all standard libraries that aren't internal (don't start with _ followed by a letter)
# (oh and also those imported )
# you can get the list with the following code:
# import pkgutil
# import sys
#
# def list_stdlib():
#     stdlib = {name for _, name, _ in pkgutil.iter_modules(path=None)}
#     this_python = {name for _, name, _ in pkgutil.iter_modules(path=sys.path)}
#     return stdlib & this_python
#
# for module in list_stdlib():
#     print(module)
# actually fuck it, i'll just import most common ones

import Crypto
import os
import sys
import __future__
import abc
import argparse
import ast
import collections
import concurrent
import contextlib
import csv
import datetime
import decimal
import decorator
import difflib
import enum
import functools
import glob
import inspect
import json
import keyword
import logging
import math
import pkgutil
import platform
import posixpath
import random
import re
import readline
import shutil
import subprocess
import threading
import trace
import traceback
import typing
import typing_extensions

import itertools


# from pprint import PrettyPrinterf
# from pprint import pprint as pp
# from rich import pretty

#pretty.install()

# pp=PrettyPrinter().pprint
try: import IPython
except ImportError: pass

try: from slither import Slither
except ImportError: pass
try: import woke
except ImportError: pass
try: import rich
except ImportError: pass

try:
    import pyperclip
    def cb(s: str):
        pyperclip.copy(s)
        print(f'{s} copied to clipboard.')
    def v():
        return pyperclip.paste()
except ImportError:
    pass

def yank(range):
    cb('\n'.join(range))

def b(s: str):
    s=s.strip()
    if s[0:2] == '0x':
        s=s[2:]
    if len(s) % 2 == 1:
        s='0' + s
    return bytes.fromhex(s)

def add_indexes(ls):
    return list(enumerate(ls))

try:
    import sha3
    def h(b: bytes):
        k=sha3.keccak_256()
        k.update(b)
        return k.hexdigest()
except ImportError:
    pass


print('PYTHONSTARTUP executed successfully.')

