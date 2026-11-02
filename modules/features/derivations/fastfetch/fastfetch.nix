{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.fastfetchOwO = pkgs.fastfetch.override {
      fastfetch-unwrapped = pkgs.fastfetch-unwrapped.overrideAttrs (old: {
        patches = (old.patches or []) ++ [./create_nixowos_logo.patch];
      });
    };
  };
}
