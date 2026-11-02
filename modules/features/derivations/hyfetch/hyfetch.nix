{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.hyfetchOwO = pkgs.hyfetch.overrideAttrs (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          substituteInPlace neofetch \
            --replace-fail 'distro="NixOS $(' 'distro="NixOwOS $(' \
            --replace-fail 'tiny) distro="NixOS"' 'tiny) distro="NixOwOS"'

          awk -v snip=${./nixowos-neofetch.txt} '
            /^ *"nixos_small"\)/ && !done { while ((getline l < snip) > 0) print l; done = 1 }
            { print }
          ' neofetch > neofetch.new
          cat neofetch.new > neofetch
          rm neofetch.new
          grep -q '"nixowos"\*)' neofetch || { echo "nixos_small anchor not found in neofetch" >&2; exit 1; }
        '';
    });
  };
}
