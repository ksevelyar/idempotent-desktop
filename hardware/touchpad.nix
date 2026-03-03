{
  services = {
    libinput = {
      enable = true;
      touchpad = {
        accelProfile = "adaptive";
        naturalScrolling = false;
        accelSpeed = "0.3";
        disableWhileTyping = true;
        scrollMethod = "twofinger";
      };
    };
  };
}
