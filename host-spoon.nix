{...}: {
  imports = [
    ./common.nix
    ./disk-config.nix
    ./hardware.nix
  ];

  system.stateVersion = "24.05";
}
