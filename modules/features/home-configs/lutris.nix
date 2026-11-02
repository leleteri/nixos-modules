{self, ...}: {
  flake.homeModules.lutris = {
    pkgs,
    lib,
    ...
  }: {
    programs.lutris = {
      enable = true;
      defaultWinePackage = pkgs.wineWow64Packages.stagingFull;
      steamPackage = self.packages.${pkgs.stdenv.hostPlatform.system}.mySteam;
      # winePackages = [
      #   pkgs.wineWow64Packages.stagingFull
      # ];
    };
  };
}
