# Games

## Definitions
Declare games in the host where their files are available. Game definitions support portable and installable Wine games, plus RetroArch games for NES, SNES, and Genesis.

A desktop entry for each game is available in the launcher with `Win`.

Games that require installation install automatically on first run.

```nix
home-manager.users.ksevelyar.games = {
  atomic-heart = {
    type = "wine";
    gameDirectory = "/data/games/atomic-heart";
    runtime = "proton-ge-11-1";
    executable = "AtomicHeart.exe";
    installation = {
      type = "inno-setup";
      source = "/data/games/Atomic Heart/Setup.exe";
    };
  };

  clive-barkers-hellraiser-revival = {
    type = "wine";
    gameDirectory = "/home/ksevelyar/games/Clive.Barkers.Hellraiser.Revival";
    runtime = "proton-ge-11-1";
    executable = "Hellraiser.exe";
    installation.type = "portable";
  };

  battle-city = {
    type = "retroarch";
    platform = "nes";
    rom = "/data/games/rom/nes/Battle City.nes";
  };

  legend-of-zelda-a-link-to-the-past = {
    type = "retroarch";
    platform = "snes";
    rom = "/data/games/rom/snes/Legend of Zelda, The - A Link to the Past.smc";
  };

  mortal-kombat = {
    type = "retroarch";
    platform = "genesis";
    rom = "/data/games/rom/genesis/Mortal Kombat.bin";
  };
};
```

Users may declare the same game directory. They share game files, while each user receives a Wine prefix and logs at these paths:

```text
<gameDirectory>/prefix/<user>/<runtime-version>
<gameDirectory>/logs/<user>
```

RetroArch saves use the user's XDG directories.
