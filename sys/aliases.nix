{
  environment.shellAliases = {
    # sys
    j = "z"; # zoxide
    h = "tldr";
    s = "sudo";
    clip = "xclip -selection clipboard";
    ports = "sudo lsof -Pni"; # ports | fzf
    pgrep = "pgrep --full";
    pkill = "pkill --full";
    i = "host-info";
    ms = "mosh";

    # learn
    tr = "trans"; # https://github.com/soimort/translate-shell

    # fs
    r = "rsync -ra --info=progress2";
    l = "ls -lahXF --group-directories-first";
    tree = "exa --tree";
    u = "aunpack"; # one tool to unpack them all
    fd = "fd --hidden --exclude .git";

    # systemd
    log = "sudo journalctl --output cat -u"; # log sshd -f
    log-previous-boot = "sudo journalctl --boot=-1";
    ss = "sudo systemctl stop";
    sr = "sudo systemctl restart";
    ssu = "systemctl stop --user";
    sru = "systemctl restart --user";

    # vnc
    grab-display = "set DISPLAY ':0.0'";
    vnc-server = "x11vnc -repeat -forever -noxrecord -noxdamage -rfbport 5900";
    vnc = "vncviewer −FullscreenSystemKeys -MenuKey F12";

    # nix
    e = "nvim /etc/nixos/configuration.nix";
    # hack for https://github.com/NixOS/nixpkgs/issues/169193
    b = "nixos-rebuild switch --use-remote-sudo && tldr --update";
    search = "nix search nixpkgs";
    wipe-user-packages = "nix-env -e '*'";
    nix-gc = "sudo nix-collect-garbage --delete-older-than 30d";
    inspect-store = "nix path-info -rSh /run/current-system | sort -k2h ";
    cachix-push = "sudo nix-store -qR --include-outputs /run/current-system | cachix push idempotent-desktop ";

    # vim
    v = "nvim";
    t = "nvim ~/todo/backlog.md";
    vv = "nvim -U none"; # vanilla v, don't load plugins & init.vim

    # sec
    p = "gopass";
    pc = "gopass show -c";
    tor = "nix-shell -p tor-browser-bundle-bin --run tor-browser";

    # git
    g = "git";
    gamend = "git add . && git commit --amend";
    gco = "git checkout";
    gc = "git commit --message";
    gca = "git commit --all --message";
    gs = "git status --short";
    gd = "git diff";
    gdc = "git diff --cached";
    gfr = "git pull --rebase";
    gl = "git lg";
    gp = "git push";
    gso = "git log -p --all --source -S "; # search string in all branches, gso <string>
  };
}
