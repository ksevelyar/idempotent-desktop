{
  pkgs,
  lib,
  ...
}: let
  mkDesktop = name: game:
    pkgs.makeDesktopItem {
      inherit name;
      desktopName = name;
      exec = game.exec;
      categories = ["Game" "Emulator"];
    };

  nesCore = "${pkgs.libretro.mesen}/lib/retroarch/cores/mesen_libretro.so";
  snesCore = "${pkgs.libretro.snes9x}/lib/retroarch/cores/snes9x_libretro.so";
  genesisCore = "${pkgs.libretro.genesis-plus-gx}/lib/retroarch/cores/genesis_plus_gx_libretro.so";

  raNES = "${pkgs.retroarch}/bin/retroarch -f -L ${nesCore}";
  raSNES = "${pkgs.retroarch}/bin/retroarch -f -L ${snesCore}";
  raGenesis = "${pkgs.retroarch}/bin/retroarch -f -L ${genesisCore}";

  games = {
    # NES
    super-mario-bros-1 = {
      exec = "${raNES} /data/rom/nes/super-mario-bros-1.nes";
    };
    super-mario-bros-2 = {
      exec = "${raNES} /data/rom/nes/super-mario-bros-2.nes";
    };
    super-mario-bros-3 = {
      exec = "${raNES} /data/rom/nes/super-mario-bros-3.nes";
    };
    contra = {
      exec = "${raNES} /data/rom/nes/contra.nes";
    };
    ghosts-n-goblins = {
      exec = "${raNES} /data/rom/nes/ghosts-n-goblins.nes";
    };
    gradius = {
      exec = "${raNES} /data/rom/nes/gradius.nes";
    };

    # SNES
    super-mario-world = {
      exec = "${raSNES} /data/rom/snes/super-mario-world.smc";
    };
    street-fighter-2 = {
      exec = "${raSNES} /data/rom/snes/street-fighter-2.smc";
    };
    final-fight = {
      exec = "${raSNES} /data/rom/snes/final-fight.smc";
    };
    contra-3 = {
      exec = "${raSNES} /data/rom/snes/contra-3.smc";
    };

    # Genesis
    sonic-1 = {
      exec = "${raGenesis} /data/rom/genesis/sonic-1.bin";
    };
    sonic-2 = {
      exec = "${raGenesis} /data/rom/genesis/sonic-2.bin";
    };
    golden-axe = {
      exec = "${raGenesis} /data/rom/genesis/golden-axe.bin";
    };
    gunstar-heroes = {
      exec = "${raGenesis} /data/rom/genesis/gunstar-heroes.bin";
    };
  };
in {
  environment.systemPackages =
    [
      (pkgs.retroarch.withCores (cores: with cores; [mesen snes9x genesis-plus-gx]))
    ]
    ++ lib.mapAttrsToList mkDesktop games;
}
