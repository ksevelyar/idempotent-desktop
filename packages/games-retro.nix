{
  pkgs,
  lib,
  ...
}: let
  platforms = {
    nes = {
      core = "${pkgs.retroarch}/bin/retroarch -f -L ${pkgs.libretro.mesen}/lib/retroarch/cores/mesen_libretro.so --appendconfig /etc/retroarch-global.cfg";
      roms = [
        "Battle City.nes"
        "Battletoads.nes"
        "Bomberman.nes"
        "Bubble Bobble.nes"
        "Castlevania 2 - Simon's Quest.nes"
        "Castlevania 3 - Dracula's Curse.nes"
        "Castlevania.nes"
        "Contra.nes"
        "Darkwing Duck.nes"
        "Dr. Mario.nes"
        "Duck Tales.nes"
        "Ghosts n Goblins.nes"
        "Gradius.nes"
        "Legend of Zelda, The.nes"
        "Megaman 6.nes"
        "Super Mario Bros.nes"
        "Super Mario bros 2.nes"
        "Super Mario bros 3.nes"
      ];
    };

    snes = {
      core = "${pkgs.retroarch}/bin/retroarch -f -L ${pkgs.libretro.snes9x}/lib/retroarch/cores/snes9x_libretro.so --appendconfig /etc/retroarch-global.cfg";
      roms = [
        "Contra 3 - The Alien Wars.smc"
        "Donkey Kong Country.smc"
        "F-ZERO.smc"
        "Final Fantasy 2.smc"
        "Final Fantasy 3.smc"
        "Final Fight.smc"
        "Harvest Moon.smc"
        "Kirby Super Star.smc"
        "Legend of Zelda, The - A Link to the Past.smc"
        "Mega Man X 2.smc"
        "Mega Man X 3.smc"
        "Mega Man X.smc"
        "Secret of Mana.smc"
        "Star Fox.smc"
        "Street Fighter 2 - The World Warrior.smc"
        "Street Fighter 2 Turbo - Hyper Fighting.smc"
        "Super Mario All-Stars.smc"
        "Super Mario World 2 - Yoshi's Island.smc"
        "Super Mario World.smc"
        "Super Mario World.smc"
        "Super Metroid.smc"
      ];
    };

    genesis = {
      core = "${pkgs.retroarch}/bin/retroarch -f -L ${pkgs.libretro.genesis-plus-gx}/lib/retroarch/cores/genesis_plus_gx_libretro.so --appendconfig /etc/retroarch-global.cfg";
      roms = [
        "Castlevania - Bloodlines.bin"
        "Golden Axe 2.bin"
        "Golden Axe 3.bin"
        "Golden Axe.bin"
        "Gunstar Heroes.bin"
        "Mortal Kombat 2.bin"
        "Mortal Kombat 3.bin"
        "Mortal Kombat.bin"
        "Phantasy Star 2.bin"
        "Phantasy Star 3 - Generations of Doom.bin"
        "Phantasy Star 4.bin"
        "Sonic 2.bin"
        "Sonic 3D Blast.bin"
        "Sonic Spinball.bin"
        "Sonic and Knuckles.bin"
        "Sonic the Hedgehog 2.bin"
        "Sonic the Hedgehog 3.bin"
        "Sonic.bin"
        "Streets of Rage 2.bin"
        "Streets of Rage 3.bin"
        "Streets of Rage.bin"
      ];
    };
  };

  mkDesktop = name: game:
    pkgs.makeDesktopItem {
      inherit name;
      desktopName = name;
      exec = game.exec;
      categories = ["X-retrogame"];
    };

  gameList = lib.flatten (lib.mapAttrsToList (
      platform: data:
        lib.map (rom: let
          parts = lib.splitString "." rom;
          baseName = lib.removeSuffix ("." + lib.last parts) rom;
        in {
          name = baseName;
          exec = "${data.core} \"/data/games/rom/${platform}/${rom}\"";
        })
        data.roms
    )
    platforms);

  allGames = lib.listToAttrs (map (g: lib.nameValuePair g.name g) gameList);
in {
  environment.systemPackages =
    [
      (pkgs.retroarch.withCores (cores: with cores; [mesen snes9x genesis-plus-gx]))
    ]
    ++ lib.mapAttrsToList mkDesktop allGames;

  environment.etc."retroarch-global.cfg".text = ''
    input_save_state = "f6";
    input_state_slot_decrease = "null";

    input_audio_mute = "null";
    input_load_state = "f9";

    input_menu_toggle = "f12";
  '';
}
