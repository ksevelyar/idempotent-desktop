{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.browserpass.enable = true;

  programs.fish.enable = true;
  programs.mosh.enable = true;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      set -g set-titles-string "#{session_name} - #W"

      set -g history-limit 10000
      set -g status-keys vi
      set -g mouse on

      setw -g mode-keys vi
      setw -g monitor-activity on

      set -g @continuum-restore 'on'
      run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
      run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
      run-shell ${pkgs.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux
      run-shell ${pkgs.tmuxPlugins.open}/share/tmux-plugins/open/open.tmux
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux

      set-option -g status-style bg=default,fg=colour105

      set -g base-index 1
      setw -g pane-base-index 1

      set -g pane-border-style fg=white,bg=white
      set -g pane-active-border-style fg=colour105,bg=colour105
      
      set -g window-status-format " #I #{pane_current_command} #{?window_zoomed_flag,🔍 ,}#{?pane_synchronized,🏊🏊 ,}"
      set -g window-status-current-format "#[fg=black,bg=colour105] #I #{pane_current_command} #{?window_zoomed_flag,🔍 ,}#{?pane_synchronized,🏊🏊 ,}#[default]"

      set -g status-right '#[fg=colour105]#(cut -d " " -f 1-3 /proc/loadavg)#[default] '
      # set -g status-left-length 60
      set -g status-left ' #S '
      set -g status-interval 10
      set -g status-justify centre

      # No delay for escape key press
      set -sg escape-time 0

      # More friendly split pane
      bind-key h split-window -v
      bind-key v split-window -h
      
      # create (h)orizontal and (v)ertical panes without prefix
      bind -n C-M-s split-window -v
      bind -n C-M-v split-window -h
       
      # Resize panes without prefix
      bind -n C-M-Down resize-pane -D
      bind -n C-M-Up resize-pane -U
      bind -n C-M-Left resize-pane -L
      bind -n C-M-Right resize-pane -R
       
      # zoom into pane
      bind -n C-M-f resize-pane -Z
       
      # Use Alt-hjkl without prefix key to switch panes
      bind -n C-M-h select-pane -L
      bind -n C-M-l select-pane -R
      bind -n C-M-k select-pane -U
      bind -n C-M-j select-pane -D

      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5

      bind-key M-j resize-pane -D
      bind-key M-k resize-pane -U
      bind-key M-h resize-pane -L
      bind-key M-l resize-pane -R

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Use Alt-vim keys without prefix key to switch panes
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      bind f set-option -g status
    '';
  };

  programs.qt5ct.enable = true;

  programs.thefuck.enable = true; # https://github.com/nvbn/thefuck


  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        upwork

        hunspell
        hunspellDicts.en_US-large

        font-manager

        websocat
        sierra-gtk-theme
        grub2
        os-prober
        hwinfo
        wget
        curl

        hunspell
        hunspellDicts.en_US-large

        # cli
        calcurse
        brightnessctl
        wtf
        asciiquarium


        fzf
        gopass
        keepassxc
        firefoxWrapper
        google-chrome
        zathura
        evince
        memtest86-efi

        # Themes
        cura
        conky
        betterlockscreen
        vanilla-dmz
        pop-gtk-theme
        adapta-gtk-theme
        mate.mate-icon-theme-faenza
        ant-theme
        ant-bloody-theme
        ant-dracula-theme
        nordic
        nordic-polar
        arc-theme
        materia-theme
        paper-icon-theme
        lxappearance-gtk3
        adwaita-qt
        skype
        slack
        feh
        transmission_gtk
        aria2
        tdesktop
        polybar

        # media
        mpv
        cava
        vlc
        kodi
        moc
        google-play-music-desktop-player
        audacity
        lmms

        # Dev
        (python3.withPackages (ps: with ps; [ httpserver ]))
        zeal
        neovim
        neovim-qt
        gnvim
        vscode
        ripgrep
        tldr
        nodejs
        elixir
        go
        terminator
        cool-retro-term
        kitty
        asciinema
        alacritty
        universal-ctags
        global
        gcc
        git
        gitg
        gitAndTools.diff-so-fancy
        lazygit

        imagemagick
        gimp
        inkscape
        blender
        openscad

        # Freelance
        libreoffice
        masterpdfeditor

        # Sys
        glxinfo
        lm_sensors
        gparted
        mkpasswd
        parallel
        file
        memtest86plus
        system-config-printer
        jq
        tmuxPlugins.sensible
        tmuxPlugins.continuum
        tmuxPlugins.resurrect
        tmuxPlugins.open
        tmuxPlugins.yank

        ## fs
        spaceFM
        fd
        nnn
        vifm
        appimage-run
        nomacs
        ncdu
        tree
        sshfs
        ntfs3g
        exfat
        sshfsFuse
        rsync
        rclone
        rclone-browser

        lshw
        bat
        inetutils
        maim
        simplescreenrecorder
        smartmontools
        bind
        unzip
        unrar
        p7zip
        atool
        xclip
        gotop
        htop
        iotop
        powertop
        rofi
        redshift
        bash
        tor-browser-bundle-bin
        pavucontrol
        libnotify
        dunst
        nixpkgs-fmt
        tightvnc
        youtube-dl
        neofetch

        # vncpasswd
        # x0vncserver -rfbauth ~/.vnc/passwd
        tigervnc

        # games
        gzdoom
        stable.steam
        playonlinux # https://www.playonlinux.com/en/supported_apps-1-0.html

        # laptop
        arandr
        acpi
        openssh

        winusb
      ];
}