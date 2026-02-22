{config, ...}: let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  # Keyboard layouts live in tools/; desktop backgrounds are referenced directly by
  # system defaults (nixos/modules/system/apps.nix).
  home.file."Library/Keyboard Layouts/US_disabled_option_keys.keylayout".source =
    mkOutOfStoreSymlink "${dotfilesDir}/tools/macos/keyboard_layouts/US_disabled_option_keys.keylayout";
}
