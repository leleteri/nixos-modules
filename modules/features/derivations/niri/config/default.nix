{self, ...}: {
  flake.nixosModules.niriConfig = {
    imports = [
      self.nixosModules.niriEnv
      self.nixosModules.niriBinds
      self.nixosModules.niriExtras
      self.nixosModules.niriWindows
    ];
  };
}
