{...}: {
  flake.nixosModules.noctaliaGeneral = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.psmisc
      pkgs.nix-search-tv
      pkgs.fzf
      pkgs.fd
      pkgs.bat
    ];

    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    security.polkit.enable = true;
  };
}
