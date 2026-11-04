{
  inputs,
  pkgs,
  ...
}: let
  gameHomeManagerModule = {
    config,
    lib,
    pkgs,
    ...
  }: let
    unstablePackages = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    protonGeRuntimes = {
      proton-ge-11-1 = {
        version = "GE-Proton11-1";
        compatibilityToolPath = pkgs.fetchzip {
          url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton11-1/GE-Proton11-1.tar.gz";
          hash = "sha256-I7SSvzQQ/NqdvwjpJ9IFFtAaTS+rgHUyXx0us1vIOnw=";
        };
      };
    };
    retroarchGlobalConfiguration = pkgs.writeText "retroarch-global.cfg" ''
      input_save_state = "f6"
      input_load_state = "f9"
      input_state_slot_decrease = "minus"
      input_state_slot_increase = "equals"

      input_menu_toggle = "f12"
      input_audio_mute = "null"

      savestate_auto_load = "true"
      savestate_auto_save = "true"
    '';
    retroarchPlatforms = {
      nes = {
        corePackage = pkgs.libretro.mesen;
        coreLibraryName = "mesen_libretro.so";
      };
      snes = {
        corePackage = pkgs.libretro.snes9x;
        coreLibraryName = "snes9x_libretro.so";
      };
      genesis = {
        corePackage = pkgs.libretro.genesis-plus-gx;
        coreLibraryName = "genesis_plus_gx_libretro.so";
      };
    };
    createWineApplication = gameName: gameDefinition: let
      gameDirectory = gameDefinition.gameDirectory;
      gameExecutable = "${gameDirectory}/${gameDefinition.executable}";
      gameRuntime = protonGeRuntimes.${gameDefinition.runtime};
      gamePrefixDirectory = "${gameDirectory}/prefix/${config.home.username}/${gameRuntime.version}";
      gameLogDirectory = "${gameDirectory}/logs/${config.home.username}";
      installerArguments = lib.escapeShellArgs [
        "/VERYSILENT"
        "/SUPPRESSMSGBOXES"
        "/NORESTART"
        "/SP-"
        "/DIR=${gameDirectory}"
      ];
      installationCommand =
        if gameDefinition.installation.type == "inno-setup"
        then ''
          if [ ! -f "${gameDefinition.installation.source}" ]; then
            echo "Installer not found: ${gameDefinition.installation.source}" >&2
            exit 1
          fi

          mkdir -p "$(dirname "$gameDirectory")"
          runAndWriteLog install ${lib.getExe unstablePackages.umu-launcher} "${gameDefinition.installation.source}" ${installerArguments}
        ''
        else if gameDefinition.installation.type == "portable"
        then ''
          echo "Game executable not found: $gameExecutable" >&2
          exit 1
        ''
        else throw "Unsupported installation type: ${gameDefinition.installation.type}";
    in
      assert lib.match "[a-z0-9]+(-[a-z0-9]+)*" gameName != null;
      assert lib.hasPrefix "/" gameDirectory;
      pkgs.writeShellApplication {
        name = gameName;
        runtimeInputs = [
          pkgs.coreutils
          unstablePackages.umu-launcher
        ];
        text = ''
          gameDirectory="${gameDirectory}"
          gameExecutable="${gameExecutable}"
          gamePrefixDirectory="${gamePrefixDirectory}"
          gameLogDirectory="${gameLogDirectory}"

          export GAMEID="umu-${gameName}"
          export PROTONPATH="${gameRuntime.compatibilityToolPath}"
          export UMU_RUNTIME_UPDATE=0
          export WINEPREFIX="$gamePrefixDirectory"

          runAndWriteLog() {
            local operationName="$1"
            shift
            "$@" 2>&1 | tee "$gameLogDirectory/$operationName.log"
          }

          mkdir -p "$gamePrefixDirectory" "$gameLogDirectory"

          if [ ! -f "$gameExecutable" ]; then
            ${installationCommand}
          fi

          if [ ! -f "$gameExecutable" ]; then
            echo "Game executable not found after installation: $gameExecutable" >&2
            exit 1
          fi

          cd "$gameDirectory"
          runAndWriteLog launch ${lib.getExe unstablePackages.umu-launcher} "./${gameDefinition.executable}"
        '';
      };
    createRetroarchApplication = gameName: gameDefinition: let
      platformDefinition = retroarchPlatforms.${gameDefinition.platform} or (throw "Unsupported RetroArch platform: ${gameDefinition.platform}");
      coreLibraryPath = "${platformDefinition.corePackage}/lib/retroarch/cores/${platformDefinition.coreLibraryName}";
    in
      assert lib.match "[a-z0-9]+(-[a-z0-9]+)*" gameName != null;
      assert lib.hasPrefix "/" gameDefinition.rom;
      pkgs.writeShellApplication {
        name = gameName;
        runtimeInputs = [
          pkgs.retroarch
          platformDefinition.corePackage
        ];
        text = ''
          exec ${lib.getExe pkgs.retroarch} -f -L "${coreLibraryPath}" --appendconfig "${retroarchGlobalConfiguration}" "${gameDefinition.rom}"
        '';
      };
    createGameApplication = gameName: gameDefinition:
      if gameDefinition.type == "wine"
      then createWineApplication gameName gameDefinition
      else if gameDefinition.type == "retroarch"
      then createRetroarchApplication gameName gameDefinition
      else throw "Unsupported game type: ${gameDefinition.type}";
    gameApplications = lib.mapAttrs createGameApplication config.games;
    createGameDisplayName = gameName:
      lib.concatMapStringsSep " "
      (word: lib.toUpper (lib.substring 0 1 word) + lib.substring 1 (builtins.stringLength word) word)
      (lib.splitString "-" gameName);
    createDesktopEntry = gameName: gameApplication: {
      name = createGameDisplayName gameName;
      exec = lib.getExe gameApplication;
      terminal = false;
      categories = ["Game"];
    };
  in {
    options.games = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          type = lib.mkOption {
            type = lib.types.enum ["wine" "retroarch"];
          };
          gameDirectory = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
          runtime = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum (builtins.attrNames protonGeRuntimes));
            default = null;
          };
          executable = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
          installation = lib.mkOption {
            type = lib.types.nullOr (lib.types.submodule {
              options = {
                type = lib.mkOption {
                  type = lib.types.enum ["inno-setup" "portable"];
                };
                source = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };
              };
            });
            default = null;
          };
          platform = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum (builtins.attrNames retroarchPlatforms));
            default = null;
          };
          rom = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };
      });
      default = {};
    };

    config = {
      assertions = lib.flatten (lib.mapAttrsToList (gameName: gameDefinition: [
        {
          assertion = gameDefinition.type != "wine" || gameDefinition.gameDirectory != null;
          message = "Wine game ${gameName} requires gameDirectory.";
        }
        {
          assertion = gameDefinition.type != "wine" || gameDefinition.runtime != null;
          message = "Wine game ${gameName} requires runtime.";
        }
        {
          assertion = gameDefinition.type != "wine" || gameDefinition.executable != null;
          message = "Wine game ${gameName} requires executable.";
        }
        {
          assertion = gameDefinition.type != "wine" || gameDefinition.installation != null;
          message = "Wine game ${gameName} requires installation.";
        }
        {
          assertion = gameDefinition.type != "wine" || gameDefinition.installation == null || gameDefinition.installation.type != "inno-setup" || gameDefinition.installation.source != null;
          message = "Inno Setup game ${gameName} requires installation.source.";
        }
        {
          assertion = gameDefinition.type != "wine" || gameDefinition.gameDirectory == null || lib.hasPrefix "/" gameDefinition.gameDirectory;
          message = "Wine game ${gameName} requires an absolute gameDirectory.";
        }
        {
          assertion = gameDefinition.type != "retroarch" || gameDefinition.platform != null;
          message = "RetroArch game ${gameName} requires platform.";
        }
        {
          assertion = gameDefinition.type != "retroarch" || gameDefinition.rom != null;
          message = "RetroArch game ${gameName} requires rom.";
        }
        {
          assertion = gameDefinition.type != "retroarch" || gameDefinition.rom == null || lib.hasPrefix "/" gameDefinition.rom;
          message = "RetroArch game ${gameName} requires an absolute rom.";
        }
      ]) config.games);
      home.packages = builtins.attrValues gameApplications;
      xdg.desktopEntries = lib.mapAttrs createDesktopEntry gameApplications;
    };
  };
in {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    cabextract
    heroic
    vulkan-tools
    linuxConsoleTools
  ];

  home-manager.sharedModules = [gameHomeManagerModule];
}
