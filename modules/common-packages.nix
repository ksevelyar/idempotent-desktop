{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  programs.tmux = {
    enable = true;
    clock24 = true;
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

  environment.systemPackages = with pkgs;
    [
      # boot
      grub2

      # vim
      neovim
      watchman
      (
        python3.withPackages (
          ps: with ps; [
            httpserver
            pywal
          ]
        )
      )
      nodejs_latest
      fzf
      ripgrep
      # navi
      universal-ctags
      global

      # sys
      lsof
      tldr
      git
      gitAndTools.diff-so-fancy
      bash
      lm_sensors
      mkpasswd
      file
      memtest86plus
      jq
      tmuxPlugins.sensible
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
      tmuxPlugins.open
      tmuxPlugins.yank
      lshw
      pciutils # lspci
      usbutils # lsusb
      psmisc # pstree, killall
      bat
      inetutils

      # sec
      tomb
      # pass
      # We can add existing passwords to the store with insert:
      # pass insert Business/cheese-whiz-factory
      passExtensions.pass-audit
      passExtensions.pass-genphrase
      passExtensions.pass-import
      passExtensions.pass-otp
      passExtensions.pass-tomb
      passExtensions.pass-update
      (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb ]))
      ripasso-cursive
      gopass

      # cli
      taskwarrior
      nmap
      wget
      curl
      aria2
      translate-shell
      websocat
      brightnessctl
      youtube-dl

      # monitoring 
      hwinfo
      smartmontools
      acpi
      gotop
      htop
      iotop
      iftop
      powertop
      stable.nixpkgs-fmt
      neofetch

      # fs
      bind
      unzip
      unrar
      p7zip
      atool
      parted
      fasd
      mc
      fd
      nnn
      ncdu
      tree
      dosfstools
      mtools
      sshfs
      ntfs3g
      exfat
      sshfsFuse
      rsync
    ];
}
