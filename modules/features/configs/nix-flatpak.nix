{inputs, ...}: {
  flake.nixosModules.nixFlatpak = {pkgs, ...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
    services.flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      overrides.global = {
        Context.sockets = ["wayland" "!x11" "!fallback-x11"];
        Context.filesystem = [
          "xdg-config/gtk-3.0:ro"
          "xdg-config/gtk-4.0:ro"
        ];
        Environment = {
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          TZ = "Asia/Jakarta";
        };
      };
    };
  };
}
