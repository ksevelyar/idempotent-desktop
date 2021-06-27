{
  environment.shellAliases = {
    # help
    # https://www.quora.com/Unix-Why-are-explanations-in-man-pages-so-bad
    # try tldr instead of man
    h = "tldr";
    # h rsync
    # h parted
    # h npm

    # sys
    s = "sudo";
    ss = "sudo systemctl stop";
    sr = "sudo systemctl restart";

    clip = "xclip -selection clipboard";

    ssu = "systemctl stop --user";
    sru = "systemctl restart --user";

    x = "sudo systemctl restart display-manager";

    log = "sudo journalctl --output cat -u"; # log sshd -f
    log-previous-boot = "sudo journalctl --boot=-1";

    ports = "sudo lsof -Pni"; # ports | fzf
    pgrep = "pgrep --full";
    pkill = "pkill --full";
    i = "id-info";
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
    pp = "gopass";
    open-tomb = "tomb open *.tomb -k *.tomb.key && notify-send 'Drains 5 Karma per grave.'";

    tm = "id-tm";
    tm1 = "id-tm 🦙";
    tm2 = "id-tm 🔮";
    tm3 = "id-tm 🦹";

    g = "git";
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
    gdf = "git diff --no-index"; # delta diff for non git files

    t = "task"; # https://www.youtube.com/watch?v=zl68asL9jZA
    fd = "fd --hidden --exclude .git";
    # turn screen off and stop music
    off = "sleep 0.5 && xset dpms force off; pkill -f spotify; xdotool key XF86AudioPause";

    ssht = "ssh -t skynet 'tmux new -A -s 🦙'";
    m = "mosh";
    grab-display = "export DISPLAY = ':0.0'";
    vnc-server = "x11vnc -repeat -forever -noxrecord -noxdamage -rfbport 5900";
    vnc = "vncviewer −FullscreenSystemKeys -MenuKey F12";

    # nix
    e = "sudo nvim /etc/nixos/configuration.nix";
    b = "sudo nixos-rebuild switch --keep-going";
    br = "b && xmonad --restart";
    # no = "nixos-option";
    id-wipe-user-packages = "nix-env -e '*'";

    id-gc = "sudo nix-collect-garbage --delete-older-than 30d";
    id-gc-force = "sudo rm /nix/var/nix/gc.lock; id-gc";
    id-inspect-store = "nix path-info -rSh /run/current-system | sort -k2h ";
    id-push = "sudo nix-store -qR --include-outputs /run/current-system | cachix push idempotent-desktop ";
    id-store-to-svg = "nix-du --root /run/current-system/sw/ -s 100MB | tred | dot -Tsvg > ./nix-store.svg";
    id-sync = "cd /etc/nixos && git stash && git pull --rebase && b";
    id-doc = "xdg-open http://docs.lcl";
  };
}
