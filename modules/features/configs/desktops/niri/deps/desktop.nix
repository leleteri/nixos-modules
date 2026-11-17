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

      pkgs.wlinhibit
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
      NIXOS_OZONE_WL = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
    };

    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
      "/share/gsettings-schemas"
    ];
  };
}
