{
  # free up to 20GiB whenever there is less than 20GB left: 
  nix = {
    binaryCaches = [
      "https://idempotent-desktop.cachix.org"
    ];
    binaryCachePublicKeys = [
      "idempotent-desktop.cachix.org-1:OkWDud90b2/k/k1yIUg1lxZdNRWEvCfv6zSSRQ75lVM="
    ];

    daemonNiceLevel = 19;
    daemonIONiceLevel = 7;

    extraOptions = ''
      min-free = ${toString (20 * 1024 * 1024 * 1024)}
      max-free = ${toString (20 * 1024 * 1024 * 1024)}
    '';

  };
}
