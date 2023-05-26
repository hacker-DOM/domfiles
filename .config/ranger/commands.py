import ranger.api
import ranger.core.linemode

@ranger.api.register_linemode     # It may be used as a decorator too!
class MyLinemode(ranger.core.linemode.LinemodeBase):
    name = "awesome_linemode"

    uses_metadata = True
    required_metadata = ["comment"]

    def filetitle(self, file, metadata):
        return file.relative_path + " (" + metadata.comment + ")"

    def infostring(self, file, metadata):
        return file.user
