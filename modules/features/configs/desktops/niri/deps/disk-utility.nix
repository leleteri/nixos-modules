{...}: {
  flake.nixosModules.niriDisksUtil = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.gnome-disk-utility
    ];
    services.udisks2.enable = true;
    services.udisks2.mountOnMedia = true;
    services.gvfs.enable = true;
  };
}
