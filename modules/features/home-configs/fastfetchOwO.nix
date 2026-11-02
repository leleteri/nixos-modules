{self, ...}: {
  flake.homeModules.fastfetchOwO = {pkgs, ...}: {
    programs.fastfetch = {
      enable = true;
      package =
        self.packages.${pkgs.stdenv.hostPlatform.system}.fastfetchOwO;
      settings = {
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "bios"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "de"
          "wm"
          "wmtheme"
          "theme"
          "icons"
          "font"
          "cursor"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          "battery"
          "poweradapter"
          "locale"
          "break"
          "colors"
        ];
        display.disableLinewrap = true;
      };
    };
  };
}
