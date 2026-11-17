{self, ...}: {
  flake.nixosModules.niriDeps = {
    imports = [
      self.nixosModules.noctaliaDeps
      self.nixosModules.niriDepsExtras
      self.nixosModules.niriDepsEnvironment
      self.nixosModules.niriDepsDisksUtil
      self.nixosModules.niriDepsGuiApps
    ];
  };
}
