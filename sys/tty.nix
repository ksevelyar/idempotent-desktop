{
  pkgs,
  lib,
  ...
}: {
  services.getty.greetingLine = lib.mkForce ''\l'';
  services.getty.helpLine = lib.mkForce ''
    .     .       .  .   . .   .   . .    +  .
      .     .  :     .    .. :. .___---------___.
           .  .   .    .  :.:. _".^ .^ ^.  '.. :"-_. .
        .  :       .  .  .:../:            . .^  :.:\.
            .   . :: +. :.:/: .   .    .        . . .:\
     .  :    .     . _ :::/:               .  ^ .  . .:\
      .. . .   . - : :.:./.                        .  .:\
      .      .     . :..|:                    .  .  ^. .:|
        .       . : : ..||        .                . . !:|
      .     . . . ::. ::\(                           . :)/
     .   .     : . : .:.|. ######              .#######::|
      :.. .  :-  : .:  ::|.#######           ..########:|
     .  .  .  ..  .  .. :\ ########          :######## :/
      .        .+ :: : -.:\ ########       . ########.:/
        .  .+   . . . . :.:\. #######       #######..:/
          :: . . . . ::.:..:.\           .   .   ..:/
       .   .   .  .. :  -::::.\.       | |     . .:/
          .  :  .  .  .-:.":.::.\             ..:/
     .      -.   . . . .: .:::.:.\.           .:/
    .   .   .  :      : ....::_:..:\   ___.  :/
       .   .  .   .:. .. .  .: :.:.:\       :/
         +   .   .   : . ::. :.:. .:.|\  .:/|
         .         +   .  .  ...:: ..|  --.:|
    .      . . .   .  .  . ... :..:.."(  ..)"
     .   .       .      :  .   .: ::/  .  .::\
  '';

  console = {
    earlySetup = true;
    colors = [
      "1b161f" # black
      "ff5555" # red
      "54c6b5" # green
      "d5aa2a" # yellow
      "bd93f9" # blue
      "ff79c6" # magenta
      "8be9fd" # cyan
      "f8f8f2" # white

      "44475a" # bright_black
      "ff6e67" # bright_red
      "5af78e" # bright_green
      "ffce50" # bright_yellow
      "caa9fa" # bright_blue
      "ff92d0" # bright_magenta
      "9aedfe" # bright_cyan
      "e6e6e6" # bright_white
    ];
    packages = with pkgs; [terminus_font];
  };
}
