import os
import sys
# from pprint import PrettyPrinterf
from pprint import pprint as pp
#from rich import pretty

#pretty.install()

# pp=PrettyPrinter().pprint

try:
    from Slither import slither
    import woke
except ImportError:
    pass

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

