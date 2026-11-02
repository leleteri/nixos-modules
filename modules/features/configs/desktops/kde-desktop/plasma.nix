{
  self,
  inputs,
  ...
}: {
  flake.homeModules.plasma = {
    pkgs,
    lib,
    ...
  }: {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.plasma = {
      enable = true;
    };
  };
}
