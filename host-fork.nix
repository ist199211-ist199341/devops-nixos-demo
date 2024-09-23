{...}: {
  imports = [
    ./common.nix
    ./disk-config.nix
    ./hardware.nix
  ];

  # Set static IP (mainly for demo purposes)
  networking.interfaces.enp1s0 = {
    useDHCP = true; # for gateway and dns
    ipv4.addresses = [
      {
        address = "192.168.122.20";
        prefixLength = 24;
      }
    ];
  };

  system.stateVersion = "24.05";
}
