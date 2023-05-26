# Dom's .dotfiles 🛠

## Some notes

[May 26 (from a chat group)]

How to manage dotfiles? I used to do the following method: On Laptop 1, symlink .zshrc to a dropbox file, on Laptop 2 do the same; done;

Later i decided to use mackup (mac—backup), which basically does the same thing, but automates it (it comes pre-installed with config locations for hundreds of apps and ofc allows you to add/remove more). Look it up, it works on Linux too, but i would recommend reading the source code here bc you dont wanna make the wrong move.. (Python 🐍.) (Install it with pipx)

Now I'm thinking of how to publish my dotfiles...

I already have this /Mackup directory in ~/Dropbox, but! I don't want to have a git repo inside of Dropbox, so i'm actually going to use a bare repo. So the only thing i have to do is: create the bare repo, add files from ~/Dropbox/Mackup/.config and gitignores, push.

And then on a new laptop I would: 
Install mackup, run mackup restore. (Optional: clone dotfiles repo.)
