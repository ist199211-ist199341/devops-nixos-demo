{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio (with pkgs ; [
    curl
    gitMinimal
  ]);


  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0r4o+OjJ18Ue3L0KfNh7dyMQ+MsFLWAraBuUhH0mDM tomas@dragonfly"
  ];

  system.stateVersion = "23.11";
}
