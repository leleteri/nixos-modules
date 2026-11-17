{self, ...}: {
  flake.nixosModules.niriConfig = {
    imports = [
      self.nixosModules.niriConfigEnv
      self.nixosModules.niriConfigBinds
      self.nixosModules.niriConfigExtras
      self.nixosModules.niriConfigWindows
    ];
  };
}
