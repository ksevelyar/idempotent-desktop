{
  environment.shellAliases = {
    l = "ls -laXF --group-directories-first";
    x = "sudo systemctl start display-manager.service";
    j = "z"; # autojump alias for z
    u = "aunpack";
    e = "sudo nvim /etc/nixos/configuration.nix";
    b = "sudo nixos-rebuild switch --keep-going";
    bu = "sudo nixos-rebuild switch --upgrade --keep-going";
    t = "tmux new-session -A -s main";
    off = "sleep 0.5; xset dpms force off; pkill -f gpmdp";
    pgrep = "pgrep --full";
    pkill = "pkill --full";
    v = "nvim";
    g = "git";
    py_files_server = "python3 -m http.server 9000";
  };
}