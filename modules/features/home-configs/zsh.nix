{...}: {
  flake.homeModules.zsh = {
    pkgs,
    lib,
    ...
  }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        strategy = ["history" "completion"];
      };

      historySubstringSearch = {
        enable = true;
        searchUpKey = ["^[[A" "^[OA"];
        searchDownKey = ["^[[B" "^[OB"];
      };

      history = {
        size = 100000;
        save = 100000;
        share = true; # share history between open shells, like fish
        ignoreAllDups = true;
        ignoreSpace = true;
        extended = true;
      };

      initContent = ''
        zmodload zsh/complist
        autoload -Uz edit-command-line
        zle -N edit-command-line

        # ---- options ----
        setopt autocd interactivecomments no_beep
        setopt auto_pushd pushd_ignore_dups pushd_silent
        setopt complete_in_word always_to_end

        # ---- word movement / deletion ----
        bindkey '^[[1;5D' backward-word      # Ctrl+Left
        bindkey '^[[1;5C' forward-word       # Ctrl+Right (also accepts one suggestion word)
        bindkey '^[[1;3D' backward-word      # Alt+Left
        bindkey '^[[1;3C' forward-word       # Alt+Right
        bindkey '^H'      backward-kill-word # Ctrl+Backspace
        bindkey '^[^?'    backward-kill-word # Alt+Backspace (same as fish)
        bindkey '^[[3;5~' kill-word          # Ctrl+Delete

        # ---- Home / End / Delete via terminfo (works across terminals) ----
        bindkey "''${terminfo[khome]}" beginning-of-line
        bindkey "''${terminfo[kend]}"  end-of-line
        bindkey "''${terminfo[kdch1]}" delete-char

        # ---- fish extras ----
        bindkey '^[e' edit-command-line      # Alt+E: edit line in $EDITOR

        # Alt+S: toggle sudo at start of line
        _sudo_toggle() {
          [[ $BUFFER == sudo\ * ]] && BUFFER="''${BUFFER#sudo }" || BUFFER="sudo $BUFFER"
          CURSOR=''${#BUFFER}
        }
        zle -N _sudo_toggle
        bindkey '^[s' _sudo_toggle

        # ---- word characters: stop at / . - _ etc. ----
        WORDCHARS='''

        # ---- completion ----
        # case-insensitive, then partial-word (f.b -> foo.bar), then substring
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' group-name '''
        zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' use-cache yes
        zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

        bindkey -M menuselect '^[[Z' reverse-menu-complete   # Shift+Tab
      '';

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings.status = {
        disabled = false;
        format = "[$status]($style) ";
        style = "bold red";
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.lsd = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.nix-your-shell = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
