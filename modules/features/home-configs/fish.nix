{...}: {
  flake.homeModules.fish = {
    config,
    pkgs,
    lib,
    ...
  }: {
    programs.fish = {
      enable = true;
      shellAliases = config.home.shellAliases;
      interactiveShellInit = "set -g fish_greeting";
      plugins = [
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };

    home.packages = [
      pkgs.fzf
      pkgs.fd
      pkgs.bat
    ];

    programs.lsd = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
