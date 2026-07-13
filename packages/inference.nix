{
  security.pam.loginLimits = [
    {
      domain = "@users";
      type = "soft";
      item = "memlock";
      value = "unlimited";
    }
    {
      domain = "@users";
      type = "hard";
      item = "memlock";
      value = "unlimited";
    }
  ];
}
