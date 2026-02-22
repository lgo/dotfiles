{
  config,
  lib,
  pkgs,
  ...
}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  vscodeExtensions = import ./extensions/vscode.nix;
  cursorExtensions = import ./extensions/cursor.nix;
  mkExtensionsListFile = name: extensions:
    pkgs.writeText name "${lib.concatStringsSep "\n" extensions}\n";
  vscodeExtensionsFile = mkExtensionsListFile "vscode-extensions.txt" vscodeExtensions;
  cursorExtensionsFile = mkExtensionsListFile "cursor-extensions.txt" cursorExtensions;
  customVimPlugins = {
    sparkup = pkgs.vimUtils.buildVimPlugin {
      pname = "sparkup";
      version = "d400a570";
      src = pkgs.fetchFromGitHub {
        owner = "rstacruz";
        repo = "sparkup";
        rev = "d400a570bf64b0c216aa7c8e1795820b911a7404";
        hash = "sha256-HIL79Ibz5fgjky19j/t1x/uXczb/roH1hQ7X9XKkhNM=";
      };
      rtp = "vim";
    };
    l9 = pkgs.vimUtils.buildVimPlugin {
      pname = "L9";
      version = "c822b05e";
      src = pkgs.fetchFromGitHub {
        owner = "vim-scripts";
        repo = "L9";
        rev = "c822b05ee0886f9a9703227dc85a6d47612c4bf1";
        hash = "sha256-5cy7bfflLgv+1sG7ZPbSpmX2J/e+ZBomGWt0xVqC0rw=";
      };
    };
    fuzzyfinder = pkgs.vimUtils.buildVimPlugin {
      pname = "FuzzyFinder";
      version = "b9f16597";
      src = pkgs.fetchFromGitHub {
        owner = "vim-scripts";
        repo = "FuzzyFinder";
        rev = "b9f165970346df55862853dd83c8a4f2b2b70262";
        hash = "sha256-+FZBqaTAK4aZozK/HBFfsMA0zLWudO5yCsKCHhdbpxQ=";
      };
    };
    lightline = pkgs.vimUtils.buildVimPlugin {
      pname = "lightline.vim";
      version = "e358557e";
      src = pkgs.fetchFromGitHub {
        owner = "itchyny";
        repo = "lightline.vim";
        rev = "e358557e1a9f9fc860416c8eb2e34c0404078155";
        hash = "sha256-bNOp5CFD1+bkAgjxggiPQb6pOK3xBIlUd/WROZoNph0=";
      };
    };
    csv = pkgs.vimUtils.buildVimPlugin {
      pname = "csv.vim";
      version = "ab776a62";
      src = pkgs.fetchFromGitHub {
        owner = "chrisbra";
        repo = "csv.vim";
        rev = "ab776a6266593e9e0d8643cdb7e577f81c0eab7d";
        hash = "sha256-t3a9Qa5eMZuK+kg27hbeiW4GrQqxMMIMqd+xh/Spvws=";
      };
    };
    unite = pkgs.vimUtils.buildVimPlugin {
      pname = "unite.vim";
      version = "0ccb3f79";
      src = pkgs.fetchFromGitHub {
        owner = "Shougo";
        repo = "unite.vim";
        rev = "0ccb3f7988d61a9a86525374be97360bd20db6bc";
        hash = "sha256-nKbDaZU6zRGr11OelunXgwvvYQD4og2sk3dVB1YxoX0=";
      };
    };
    vimVirtualenv = pkgs.vimUtils.buildVimPlugin {
      pname = "vim-virtualenv";
      version = "b81912f0";
      src = pkgs.fetchFromGitHub {
        owner = "jmcantrell";
        repo = "vim-virtualenv";
        rev = "b81912f090918ec63b98d0f41117fb44c0afe646";
        hash = "sha256-IZcOtXiU7vy+zKZ2arByWTlWk12gLh4jP7YDwzYFblA=";
      };
    };
    promptline = pkgs.vimUtils.buildVimPlugin {
      pname = "promptline.vim";
      version = "10641857";
      src = pkgs.fetchFromGitHub {
        owner = "edkolev";
        repo = "promptline.vim";
        rev = "106418570a0ecc33b35439e24b051be34f829b94";
        hash = "sha256-bVbLg4w2j3K52c2qQ0XJJOzDflH4h5HlBMhEbD2nkrc=";
      };
    };
    jshint = pkgs.vimUtils.buildVimPlugin {
      pname = "jshint.vim";
      version = "68a9a7c0";
      src = pkgs.fetchFromGitHub {
        owner = "walm";
        repo = "jshint.vim";
        rev = "68a9a7c0fea24ddbbd9beecab1fa68f9bf3d7dc2";
        hash = "sha256-yEJJIQKqRWx7wqG7a9M7Zk7RAitNUmOEwWrob8H9CJ0=";
      };
    };
  };
in {
  home.file.".editorconfig".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/editorconfig/.editorconfig";
  home.file.".spacemacs".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/emacs/.spacemacs";
  home.file.".spacemacs_layers".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/emacs/.spacemacs_layers";
  home.file.".pdbrc".source =
    mkOutOfStoreSymlink "${dotfilesDir}/languages/.pdbrc";

  home.file."Library/Application Support/Code/User/settings.json".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/vscode/settings.json";
  home.file."Library/Application Support/Code/User/keybindings.json".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/vscode/keybindings.json";
  home.file."Library/Application Support/Code/User/snippets".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/vscode/snippets";

  home.file."Library/Application Support/Cursor/User/settings.json".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/cursor/settings.json";
  home.file."Library/Application Support/Cursor/User/keybindings.json".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/cursor/keybindings.json";
  home.file."Library/Application Support/Cursor/User/snippets".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/editors/cursor/snippets";

  home.activation.installEditorExtensions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    install_extensions() {
      local cli="$1"
      local list_file="$2"
      local label="$3"

      if ! command -v "$cli" >/dev/null 2>&1; then
        echo "warning: $label CLI '$cli' not found; skipping extension install" >&2
        return 0
      fi

      while IFS= read -r extension || [ -n "$extension" ]; do
        [ -z "$extension" ] && continue
        "$cli" --install-extension "$extension" >/dev/null 2>&1 || \
          echo "warning: failed to install $label extension '$extension'" >&2
      done < "$list_file"
    }

    install_extensions code "${vscodeExtensionsFile}" "VS Code"
    install_extensions code-cursor "${cursorExtensionsFile}" "Cursor"
  '';

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins;
      [
        vim-fugitive
        vim-easymotion
        vim-colorschemes
        tagbar
        syntastic
        vim-gitgutter
        vim-signify
        vim-racket
        ultisnips
      ]
      ++ [
        customVimPlugins.sparkup
        customVimPlugins.l9
        customVimPlugins.fuzzyfinder
        customVimPlugins.lightline
        customVimPlugins.csv
        customVimPlugins.unite
        customVimPlugins.vimVirtualenv
        customVimPlugins.promptline
        customVimPlugins.jshint
      ];
    extraConfig = lib.fileContents ../../../../tools/editors/vim/.vimrc;
  };
}
