{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      playerctl

      (pkgs.writeScriptBin "spotify" ''
        #!/usr/bin/env bash
        exec ${pkgs.ungoogled-chromium}/bin/chromium \
          --proxy-server=socks5://127.0.0.1:2081 \
          --app="https://open.spotify.com" \
          --class="spotify-scratchpad"
      '')
    ];
  };
}
