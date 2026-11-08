{lib, ...}: {
  home.shellAliases = lib.mkDefault {
    j = "z";
    h = "tldr";
    s = "sudo";
    clip = "xclip -selection clipboard";
    ports = "sudo ss -ntpl";
    pgrep = "pgrep --full";
    pkill = "pkill --full";
    i = "host-info";
    cat = "bat --style plain --pager never";
    y = "yt-dlp --proxy localhost:2080";

    tr = "trans";

    r = "rsync -ra --no-links --info=progress2";
    l = "ls -lahXF --group-directories-first";
    tree = "exa --tree";
    u = "aunpack";
    fd = "fd --hidden --exclude .git";

    log = "sudo journalctl --output cat -u";
    log-previous-boot = "sudo journalctl --boot=-1";
    ss = "sudo systemctl stop";
    sr = "sudo systemctl restart";
    ssu = "systemctl stop --user";
    sru = "systemctl restart --user";

    grab-display = "set DISPLAY ':0.0'";
    vnc-server = "x11vnc -repeat -forever -noxrecord -noxdamage -rfbport 5900";
    vnc = "vncviewer −FullscreenSystemKeys -MenuKey F12";

    e = "nvim /etc/nixos/configuration.nix";
    search = "nix search nixpkgs";
    wipe-user-packages = "nix-env -e '*'";
    inspect-store = "nix path-info -rSh /run/current-system | sort -k2h ";
    cachix-push = "cachix push idempotent-desktop /run/current-system";

    v = "nvim";

    pi = "env HTTPS_PROXY=http://127.0.0.1:2081 pi";
    opencode = "env HTTPS_PROXY=http://127.0.0.1:2081 opencode";

    p = "gopass";
    pc = "gopass show -c";
    tor = "nix-shell -p tor-browser-bundle-bin --run tor-browser";

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
    gso = "git log -p --all --source -S ";
  };
}
