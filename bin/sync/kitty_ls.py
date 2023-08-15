# import subprocess
# import json
# import rich
#
# def main():
#     process.Popen(
#         cmd=['kitty', '@', 'ls'],
#
#     )
#     json.load
#
# # main()
#
# import subprocess
#
# def run_command(command, input=None):
#     if input is not None:
#         input = input.encode()
#
#     process = subprocess.run(
#         command,
#         input=input,
#         # stdout=subprocess.PIPE,
#         # stderr=subprocess.PIPE,
#         shell=True,
#         check=False
#     )
#
#     try: stdout = process.stdout.decode()
#     except AttributeError: stdout = None
#     try: stderr = process.stderr.decode()
#     except AttributeError: stderr = None
#     returncode = process.returncode
#
#     return stdout, stderr, returncode
#
# stdout, stderr, returncode = run_command('cat', input='foo')
# print('stdout:', stdout)
# print('stderr:', stderr)

import subprocess, json, rich, rich.tree

def run_command(command, input=None):
    if input is not None:
        input = input.encode()

    process = subprocess.run(
        command,
        input=input,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        # shell=True,
        # check=False
    )

    stdout = process.stdout.decode()
    stderr = process.stderr.decode()
    returncode = process.returncode

    return stdout, stderr, returncode

stdout, stderr, returncode = run_command(['kitty', '@', 'ls'])
j=json.loads(stdout)
# print(j[0]["tabs"])
tree = rich.tree.Tree("kitty @ ls")
for os_win in j:
    # tree.add(rich.text.Text(os_win["id"]))
    tree_os_win = tree.add(str(os_win["id"]))
    for tab in os_win["tabs"]:
        tree_tab = tree_os_win.add(str(tab["title"]))
        for win in tab["windows"]:
            tree_tab.add(str(win["title"]))
rich.print(tree)


