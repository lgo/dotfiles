{pkgs, ...}: let
  localFonts = pkgs.stdenvNoCC.mkDerivation {
    pname = "local-fonts";
    version = "1.0";
    src = ../../fonts;
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      fontDir="$out/share/fonts/truetype"
      mkdir -p "$fontDir"
      shopt -s nullglob
      for font in "$src"/*.ttf "$src"/*.otf; do
        install -m444 "$font" "$fontDir/$(basename "$font")"
      done
      runHook postInstall
    '';
  };
in {
  fonts.packages = [localFonts];
}
