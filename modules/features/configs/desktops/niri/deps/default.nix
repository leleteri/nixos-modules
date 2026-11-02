{self, ...}: {
  flake.nixosModules.niriDeps = {
    imports = [
      self.nixosModules.noctaliaDeps
      self.nixosModules.niriExtraDeps
      self.nixosModules.niriDesktop
      self.nixosModules.niriDisksUtil
      self.nixosModules.niriGuiApps
    ];
  };
}
