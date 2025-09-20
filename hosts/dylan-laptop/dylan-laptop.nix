{

  fileSystems."/persist".neededForBoot = true;

  time.timeZone = "America/Chicago";
  networking.hostName = "dylan-laptop";
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.loader.systemd-boot.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

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
      ];
    };
  };
  
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
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
            linux = {
              size = "500g";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/persist".mountpoint = "/persist";
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions  = [ "noatime"];
                  };
                };
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
