{ lib, config, pkgs, ... }:
let
  cfg = config.plusultra.virtualisation.podman;
in
{
  options.plusultra.virtualisation.podman = {
    enable = lib.mkEnableOption "Podman";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ podman-compose ];

    plusultra.home.extraOptions = {
      home.shellAliases = {
        "docker-compose" = "podman-compose";
      };
    };

    # NixOS 22.05 moved NixOS Containers to a new state directory and the old
    # directory is taken over by OCI Containers (eg. podman). For systems with
    # system.stateVersion < 22.05, it is not possible to have both enabled.
    # This option disables NixOS Containers, leaving OCI Containers available.
    boot.enableContainers = false;

    virtualisation = {
      podman = {
        enable = cfg.enable;
        dockerCompat = true;
      };
    };
  };
}
