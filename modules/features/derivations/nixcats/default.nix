{inputs, ...}: {
  perSystem = {
    system,
    lib,
    ...
  }: let
    inherit (inputs.nixCats) utils;
    luaPath = "${./.}";

    categoryDefinitions = {pkgs, ...}: {
      lspsAndRuntimeDeps = {
        general = with pkgs;
          [
            ripgrep
            fd
          ]
          ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [wl-clipboard];

        git = with pkgs; [
          git
          lazygit
        ];

        lsp = with pkgs; [
          # language servers
          nil
          lua-language-server
          clang-tools
          bash-language-server
          basedpyright
          yaml-language-server
          vscode-langservers-extracted
          harper
          alejandra
          stylua
          black
          shfmt

          # TODO later: jdt-language-server (java), kotlin-language-server,
          # sqls / sqlfluff (sql), asm-lsp (assembly)
        ];
      };

      startupPlugins = {
        general = with pkgs.vimPlugins; [
          plenary-nvim
          nvim-web-devicons
          telescope-nvim
          oil-nvim
          which-key-nvim
          nvim-autopairs
          lualine-nvim
          toggleterm-nvim
          blink-cmp
          conform-nvim
          nvim-treesitter.withAllGrammars
          nvim-treesitter-context
          godbolt-nvim
          fidget-nvim
          noice-nvim
          indent-blankline-nvim
          # nvim-colorizer-lua
          cinnamon-nvim
          highlight-undo-nvim
          # nvim-navic
          otter-nvim
					nvim-notify
					markview-nvim
        ];

        lsp = with pkgs.vimPlugins; [
          nvim-lspconfig
        ];

        "theme-tokyonight" = with pkgs.vimPlugins; [tokyonight-nvim];
        "theme-gruvbox" = with pkgs.vimPlugins; [gruvbox-nvim];
        "theme-everforest" = with pkgs.vimPlugins; [everforest];
        "theme-mellow" = with pkgs.vimPlugins; [mellow-nvim];

        git = with pkgs.vimPlugins; [
          gitsigns-nvim
          neogit
        ];
      };

      optionalPlugins = {};
      sharedLibraries = {};
      environmentVariables = {};
      extraWrapperArgs = {};
    };

    base = {
      settings = {
        wrapRc = true;
        aliases = ["vim" "vi"];
      };
      categories = {
        general = true;
        lsp = true;
        git = true;
      };
      extra = {};
    };

    themeNames = ["tokyonight" "gruvbox" "everforest" "mellow"];
    capitalize = n: lib.toUpper (builtins.substring 0 1 n) + builtins.substring 1 (-1) n;

    mkTheme = name: {pkgs, ...}:
      base
      // {
        categories = base.categories // {"theme-${name}" = true;};
        extra = {colorscheme = name;};
      };

    packageDefinitions =
      {
        nvim = {pkgs, ...}: base;

        nvim-dev = {pkgs, ...}:
          base
          // {
            settings = {
              wrapRc = false;
              aliases = [];
            };
          };
      }
      // lib.genAttrs (map (n: "nvim-${n}") themeNames) (
        full: mkTheme (lib.removePrefix "nvim-" full)
      );

    builder =
      utils.baseBuilder luaPath {
        inherit system;
        nixpkgs = inputs.nixpkgs;
        dependencyOverlays = [];
        extra_pkg_config = {allowUnfree = true;};
      }
      categoryDefinitions
      packageDefinitions;
  in {
    packages =
      {
        nixcatsDefault = builder "nvim";
        nixcatsDev = builder "nvim-dev";
      }
      // lib.genAttrs (map (n: "nixcats${capitalize n}") themeNames) (
        full: builder "nvim-${lib.toLower (lib.removePrefix "nixcats" full)}"
      );
  };
}
