{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./disk-config.nix
  ];

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio (with pkgs; [
    curl
    gitMinimal
  ]);

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlaWu32ANU+sWFcwKrPlqD/oW3lC3/hrA1Z3+ubuh5A dtc@bacchus"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0r4o+OjJ18Ue3L0KfNh7dyMQ+MsFLWAraBuUhH0mDM tomas@dragonfly"
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  system.stateVersion = "24.05";
}
