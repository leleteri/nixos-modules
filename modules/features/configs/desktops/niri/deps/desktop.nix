{self, ...}: {
  flake.nixosModules.niriDesktop = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = [
      pkgs.xdg-terminal-exec

      pkgs.gsettings-desktop-schemas
      pkgs.gnome-themes-extra

      pkgs.wl-clipboard
      pkgs.wl-gammarelay-rs
      pkgs.wl-mirror

      self.packages.${pkgs.stdenv.hostPlatform.system}.mikuCursorLinux
    ];
    programs.dconf = {
      enable = true;
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    # gtk
    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };
      }
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.niri.default = lib.mkForce "gtk";
    };

    environment.sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
    };
  };
}
