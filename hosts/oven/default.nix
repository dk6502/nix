{config, lib, pkgs, modulesPath, ... }:
let
  sources = import ../../npins;
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (sources.disko + "/module.nix")
    (sources.impermanence + "/nixos.nix")
    ../../shared/system.nix
    ./gonic.nix
    ./caddy.nix
    ../../shared/openssh.nix
  ];

  fileSystems."/persist".neededForBoot = true;

  networking.useDHCP = true;
  networking.hostName = "oven";
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.loader.grub.enable = true;

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
        "state"
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
          "size=200M"
        ];
      };
    };
  };
  
}
