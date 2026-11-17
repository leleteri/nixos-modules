{self, ...}: {
  flake.homeModules.lutris = {pkgs, ...}: {
    programs.lutris = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.lutrisTempFix;
      defaultWinePackage = pkgs.wineWow64Packages.stagingFull;
      steamPackage = self.packages.${pkgs.stdenv.hostPlatform.system}.mySteam;
      # winePackages = [
      #   pkgs.wineWow64Packages.stagingFull
      # ];
    };
  };
}
