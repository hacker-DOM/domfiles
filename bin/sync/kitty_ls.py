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

import subprocess, datetime, json, rich, rich.tree

def run_command(command, shell=False, input=None):
    if input is not None:
        input = input.encode()

    process = subprocess.run(
        command,
        input=input,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=shell,
        # check=False
    )

    stdout = process.stdout.decode()
    stderr = process.stderr.decode()
    returncode = process.returncode

    return stdout, stderr, returncode

def get_process_age(process_pid: int):
    # Execute shell command to get process start time
    command = f"ps -p {str(process_pid)} -o lstart="
    process_start_str, _, _ = run_command(command, shell=True)

    # Convert process start time to datetime object
    process_start_dt = datetime.datetime.strptime(process_start_str.strip(), "%a %b %d %H:%M:%S %Y")

    # Calculate time difference
    now = datetime.datetime.now()
    delta = now - process_start_dt
    


    # Format output
    if delta.total_seconds() < 1:
        formatted_output = "0s"
        formatted_output = f"[#00ff00]{formatted_output}[/]"
    elif delta.total_seconds() < 60:
        formatted_output = f"{int(delta.total_seconds()):2d}s"
        formatted_output = f"[#00ff00]{formatted_output}[/]"
    elif delta.total_seconds() < 3600:
        formatted_output = f"{int(delta.total_seconds() // 60):2d}m"
        formatted_output = f"[#00cc00]{formatted_output}[/]"
    elif delta.total_seconds() < 86400:
        formatted_output = f"{int(delta.total_seconds() // 3600):2d}h"
        formatted_output = f"[#009000]{formatted_output}[/]"
    else:
        formatted_output = f"{int(delta.total_seconds() // 86400):2d}d"
        formatted_output = f"[#006000]{formatted_output}[/]"
    return formatted_output

def is_at_prompt(win):
    # differences:
    # cwd doesn't have device name
    # cwd expands ~
    # cwd is more canonical (follows symlink)
    tit = win["title"]
    candidates = []
    candidates.append(tit)
    candidates.append(tit.replace("dteiml@Dominiks-Air:", ""))
    candidates.append(tit.replace("dteiml@Dominiks-Air:~", "/Users/dteiml"))
    candidates.append(tit.replace("dteiml@Dominiks-Air:~", "/Users/dteiml/Dropbox/Mackup"))

    cwd = win["foreground_processes"][0]["cwd"]
    if cwd in candidates:
        return True
    return False


stdout, stderr, returncode = run_command(['kitty', '@', 'ls'])
os_wins=json.loads(stdout)
# print(j[0]["tabs"])
tree = rich.tree.Tree("kitty @ ls")
# rich.print(os_wins)

for os_win in os_wins:
    # tree.add(rich.text.Text(os_win["id"]))
    os_win_row_str = str(os_win["id"])
    os_win_row = tree.add(os_win_row_str)
    for tab in os_win["tabs"]:
        tab_row_str = str(tab["id"])
        tab_row = os_win_row.add(tab_row_str)
        for win in tab["windows"]:
            # prompt_indicator = ">" if win["at_prompt"] else "×"
            # eg [0].tabs[12].windows[1].foreground_processes[0].cwd == "/Users/dteiml/Movies/dl/yt-dlp"
            # and [0].tabs[12].windows[1].title == "dteiml@Dominiks-Air:~/Movies/dl/yt-dlp"
            process_age = get_process_age(win["pid"])
            prompt_indicator = ">" if is_at_prompt(win) else "×"
            win_row_str = f"{process_age} {prompt_indicator} {str(win['title'])}"
            tab_row.add(win_row_str)
rich.print(tree)


