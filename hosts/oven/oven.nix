let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs { };
in
{

  fileSystems."/persist".neededForBoot = true;

  networking.useDHCP = true;
  networking.hostName = "oven";
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.loader.grub.enable = true;

  system.stateVersion = "25.11";

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/media" = {
    device = "//u502897.your-storagebox.de/backup";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/smb-secrets" ];
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/log"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
      "/etc/smb-secrets"
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
        device = "/dev/sda";
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
          "size=16G"
        ];
      };
    };
  };

}
