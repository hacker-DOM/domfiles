import os
import ranger.api
from ranger.core.linemode import LinemodeBase
from .devicons import *

SEPARATOR = os.getenv('RANGER_DEVICONS_SEPARATOR', ' ')



@ranger.api.register_linemode
class DevIconsLinemode(LinemodeBase):
  name = "sccd"

  uses_metadata = True

  def filetitle(self, file, metadata):
    return devicon(file) + SEPARATOR + file.relative_path + (" (" + metadata.comment + ") " if metadata.comment else "")
    # return str(type(file))
  
  def infostring(self, file, metadata):
    try:
      return f'{metadata.programmingCode:_}'
    except Exception:
      return ""
