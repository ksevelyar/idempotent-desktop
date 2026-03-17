{
  pkgs,
  lib,
  ...
}: let
  platforms = {
    nes = {
      core = "${pkgs.retroarch}/bin/retroarch -f -L ${pkgs.libretro.mesen}/lib/retroarch/cores/mesen_libretro.so";
      roms = [
        "Battletoads (U) [!].nes"
        "Bomberman (U) [!].nes"
        "Bubble Bobble (U) [!].nes"
        "Castlevania III - Dracula's Curse (U) [!].nes"
        "Castlevania II - Simon's Quest (U) [!].nes"
        "Castlevania (U) (PRG0) [!].nes"
        "contra.nes"
        "Darkwing Duck (U) [!].nes"
        "Dr. Mario (U) (PRG1) [!].nes"
        "Duck Tales (U) [!].nes"
        "ghosts-n-goblins.nes"
        "gradius.nes"
        "Legend of Zelda, The (U) (PRG1) [!].nes"
        "Megaman VI (U) [!].nes"
        "super-mario-bros-1.nes"
        "super-mario-bros-2.nes"
        "super-mario-bros-3.nes"
      ];
    };

    snes = {
      core = "${pkgs.retroarch}/bin/retroarch -f -L ${pkgs.libretro.snes9x}/lib/retroarch/cores/snes9x_libretro.so";
      roms = [
        "contra-3.smc"
        "Contra III - The Alien Wars (U) [!].smc"
        "Donkey Kong Country (U) (V1.2) [!].smc"
        "Final Fantasy III (U) (V1.1) [!].smc"
        "Final Fantasy II (U) (V1.1).smc"
        "final-fight.smc"
        "F-ZERO (E).smc"
        "Harvest Moon (E) [!].smc"
        "Kirby Super Star (U) [!].smc"
        "Legend of Zelda, The - A Link to the Past (E) [!].smc"
        "Mega Man X 2 (E) [b2].smc"
        "Mega Man X 3 (E) [b1].smc"
        "Mega Man X (E).smc"
        "Secret of Mana (E) (V1.1) [!].smc"
        "Star Fox (U) (V1.2) [!].smc"
        "street-fighter-2.smc"
        "Street Fighter II - The World Warrior (E) [!].smc"
        "Street Fighter II Turbo - Hyper Fighting (E) (V1.1) [!].smc"
        "Super Mario All-Stars + Super Mario World (E) [!].smc"
        "Super Mario World 2 - Yoshi's Island (E) (M3) (V1.1).smc"
        "Super Mario World (E) (V1.1) [!].smc"
        "super-mario-world.smc"
      ];
    };

    genesis = {
      core = "${pkgs.retroarch}/bin/retroarch -f -L ${pkgs.libretro.genesis-plus-gx}/lib/retroarch/cores/genesis_plus_gx_libretro.so";
      roms = [
        "Castlevania - Bloodlines (U) [!].bin"
        "golden-axe.bin"
        "Golden Axe III (J) [!].bin"
        "Golden Axe II (JUE) [!].bin"
        "Golden Axe (JUE) (REV 01) [!].bin"
        "gunstar-heroes.bin"
        "Mortal Kombat 3 (4) [!].bin"
        "Mortal Kombat II (JUE) [!].bin"
        "Mortal Kombat (JUE) (REV 01) (prototype) [c][!].bin"
        "Phantasy Star III - Generations of Doom (UE) [!].bin"
        "Phantasy Star II (UE) (REV 01).bin"
        "Phantasy Star IV (4) [!].bin"
        "sonic-1.bin"
        "sonic-2.bin"
        "Sonic 3D Blast (F) [!].bin"
        "Sonic and Knuckles (JUE) [!].bin"
        "Sonic Spinball (U) [!].bin"
        "Sonic the Hedgehog 2 (JUE) [!].bin"
        "Sonic the Hedgehog 3 (U) [!].bin"
        "Streets of Rage 2 (U) [!].bin"
        "Streets of Rage 3 (U) [!].bin"
        "Streets of Rage (JUE) (REV 01) [!].bin"
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
}
