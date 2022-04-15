{
  environment.shellAliases = {
    # h rsync
    # h parted
    # h npm
    h = "tldr";

    # sys
    s = "sudo";
    ss = "sudo systemctl stop";
    sr = "sudo systemctl restart";
    ssu = "systemctl stop --user";
    sru = "systemctl restart --user";

    clip = "xclip -selection clipboard";

    x = "sudo systemctl restart display-manager";

    log = "sudo journalctl --output cat -u"; # log sshd -f
    log-previous-boot = "sudo journalctl --boot=-1";

    ports = "sudo lsof -Pni"; # ports | fzf
    pgrep = "pgrep --full";
    pkill = "pkill --full";
    i = "host-info";
    l = "ls -lahXF --group-directories-first";
    tree = "exa --tree";
    j = "z"; # autojump alias 
    u = "aunpack"; # one tool to unpack them all
    v = "nvim";
    vo = "nvim -o (fzf)";
    vv = "nvim -U none"; # vanilla v, don't load plugins & init.vim
    r = "rsync -ra --info=progress2";
    search = "nix search nixpkgs";

    # sec
    p = "gopass show";
    pc = "gopass show -c";
    pp = "gopass";
    tor = "nix-shell -p tor-browser-bundle-bin --run tor-browser";

    g = "git";
    gamend = "git add . && git commit --amend";
    gst = "git stash";
    gsp = "git stash pop";
    gsa = "git stash apply";
    gsl = "git stash list --pretty=format:'%Cblue%gd%C(yellow): %C(brightwhite)%s'";
    gco = "git checkout";
    gc = "git commit --message";
    gca = "git commit --all --message";
    gs = "git status --short";
    gd = "git diff";
    gdc = "git diff --cached";
    gfr = "git pull --rebase";
    tig = "tig status";
    gl = "git lg";
    gp = "git push";
    gso = "git log -p --all --source -S "; # search string in all branches, gso <string>

    t = "task"; # https://www.youtube.com/watch?v=zl68asL9jZA
    fd = "fd --hidden --exclude .git";

    m = "mosh";
    grab-display = "export DISPLAY = ':0.0'";
    vnc-server = "x11vnc -repeat -forever -noxrecord -noxdamage -rfbport 5900";
    vnc = "vncviewer −FullscreenSystemKeys -MenuKey F12";

    # nix
    e = "nvim /etc/nixos/configuration.nix";
    b = "sudo nixos-rebuild switch --keep-going";
    wipe-user-packages = "nix-env -e '*'";

    nix-gc = "sudo nix-collect-garbage --delete-older-than 30d";
    inspect-store = "nix path-info -rSh /run/current-system | sort -k2h ";
    cachix-push = "sudo nix-store -qR --include-outputs /run/current-system | cachix push idempotent-desktop ";
  };
}
