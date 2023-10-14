## Managing dotfiles
- Initialize a git bare repo:
    - git init --bare ~/.dotfiles
    - alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    - config config status.showUntrackedFiles no
- Clone a git bare repo
    - echo ".dotfiles" >> .gitignore
    - git clone --bare <remote-git-repo-url> $HOME/.dotfiles
    - alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
    - config config --local status.showUntrackedFiles no
    - config checkout
    (if 'config checkout' fails, it is because the files already exist. Back them up or delete them)

