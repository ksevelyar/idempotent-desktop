{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
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

  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        # text
        hunspell
        hunspellDicts.en_US-large
        font-manager

        # boot
        memtest86-efi
        grub2
        os-prober
        hwinfo
        wget
        curl

        # cli
        websocat
        brightnessctl
        keepassxc
        youtube-dl

        # gui
        browsh
        firefoxWrapper
        tor-browser-bundle-bin
        zathura
        evince
        betterlockscreen

        # themes
        lxappearance-gtk3

        vanilla-dmz
        ant-dracula-theme

        paper-icon-theme
        arc-icon-theme

        # im
        tdesktop

        feh
        transmission_gtk
        aria2
        polybar

        # media
        mpv
        celluloid
        cava
        moc
        google-play-music-desktop-player

        # dev
        (python3.withPackages (ps: with ps; [ httpserver ]))
        go
        roxterm
        kitty

        fzf
        neovim

        ripgrep
        tldr

        nodejs
        elixir

        universal-ctags
        global
        gcc
        git
        gitg
        gitAndTools.diff-so-fancy


        # Freelance
        libreoffice
        masterpdfeditor

        # sys
        glxinfo
        lm_sensors
        mkpasswd
        file
        memtest86plus
        system-config-printer
        jq
        tmuxPlugins.sensible
        tmuxPlugins.continuum
        tmuxPlugins.resurrect
        tmuxPlugins.open
        tmuxPlugins.yank
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
        bash
        pavucontrol
        libnotify
        dunst
        nixpkgs-fmt
        neofetch

        # images
        imv
        nomacs

        imagemagick
        gimp
        inkscape
        blender
        openscad

        # games
        dwarf-fortress
        rogue

        # fs
        spaceFM
        fd
        nnn
        appimage-run
        ncdu
        tree

        gparted
        dosfstools
        mtools
        sshfs
        ntfs3g
        exfat
        sshfsFuse
        rsync
        rclone
        rclone-browser

        # vncpasswd
        # x0vncserver -rfbauth ~/.vnc/passwd
        tigervnc

        # laptop
        arandr
        acpi
        openssh
      ];
}
