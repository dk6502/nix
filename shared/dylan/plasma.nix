{
  enable = true;
  workspace = {
    clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
    lookAndFeel = "org.kde.breezedark.desktop";
    iconTheme = "Papirus-Dark";
  };
  kwin = {
    virtualDesktops = {
      names = [
        "Left" "Right"
      ];
      number = 2;
      rows = 1;
    };
  };
}
