let
  sources = import ../npins;
  pkgs = import sources.nixpkgs {};
  winePkg = pkgs.wineWowPackages.stable;
  wine = "${winePkg}/bin/wine64";
  so = "${pkgs.wineasio}/lib/wine/x86_64-unix/wineasio64.dll.so";
  dest = "$WINEPREFIX/drive_c/windows/system32/wineasio64.dll";
in
{
  environment.persistence."/persist".users.dylan.directories = [
    ".wine"
    ".local/share/applications"
  ];
  environment.systemPackages = with pkgs; [
    wineWowPackages.full
    wineasio
    (pkgs.writeShellScriptBin "register-wineasio" ''
      cp -v ${so} ${dest}
      chmod +w ${dest}
      ${wine} regsvr32 ${so}
    '')
  ];
}
  
