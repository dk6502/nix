let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs {};
in
{
  wsl = {
    enable = true;
    defaultUser = "dylan";
  };

  environment.systemPackages = with pkgs; [
     # (pkgs.callPackage sources.snix {}).snix.cli
  ];
  
  networking.hostName = "wsl";
  time.timeZone = "America/Chicago";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    directories = [
      "/var/log"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.dylan = {
      directories = [
        "state"
        ".gcm"
      ];
    };
  };
  
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sde";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
              priority = 1;
            };
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            nix = {
              size = "40G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };
            persist = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/persist";
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=200M"
        ];
      };
    };
  };
}
