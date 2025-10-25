{
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["dylan"];
    };
  };

  services.fail2ban.enable = true;
}
