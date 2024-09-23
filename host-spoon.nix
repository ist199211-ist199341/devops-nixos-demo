{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./disk-config.nix
    ./hardware.nix
  ];

  # Automatically performs configuration of nginx, redis and postgresql as well
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29; # force specific version of nextcloud
    hostName = "nextcloud.acme-bnss.pt";
    database.createLocally = true; # automatically uses postgresql through sockets
    configureRedis = true;
    maxUploadSize = "2G";

    config = {
      adminpassFile = toString (pkgs.writeText "nc-first-install-pwd" "demo-password");
      dbtype = "pgsql";
    };

    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar notes tasks;
    };
  };

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
  };

  # Allow connections to nginx through firewall
  networking.firewall.allowedTCPPorts = [80];

  # Set static IP (mainly for demo purposes)
  networking.interfaces.enp1s0 = {
    useDHCP = true; # for gateway and dns
    ipv4.addresses = [
      {
        address = "192.168.122.10";
        prefixLength = 24;
      }
    ];
  };

  networking.hostName = "spoon";

  system.stateVersion = "24.05";
}
