{...}: {
  flake.nixosModules.documentation = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.man-pages
      pkgs.man-pages-posix
    ];

    documentation = {
      enable = true;
      dev.enable = true;
      man.cache.enable = true;
    };
  };
}
