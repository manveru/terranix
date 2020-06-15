# the package
# -----------
{
  stdenv,
  symlinkJoin,
  writeShellScriptBin,
  writeText,
  pandoc,
  callPackage,
  ...
}:

let
  libTerranix = (import ./lib.nix) { inherit writeShellScriptBin stdenv pandoc writeText; };
in

symlinkJoin rec {
  version = "2.2.3";
  name = "terranix-${version}";
  paths = [
    libTerranix.terranix
    libTerranix.terranixDocJson
    libTerranix.terranixDocMan
    (callPackage ./doc/default.nix {}).manPages
  ];
  meta = with stdenv.lib; {
    description = "A NixOS like terraform-json generator";
    homepage = https://github.com/mrVanDalo/terranix;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ mrVanDalo ];
  };
}
