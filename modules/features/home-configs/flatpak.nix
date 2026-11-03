{inputs, ...}: {
  flake.homeModules.flatpak = {
    osConfig,
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

    services.flatpak = {
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
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
