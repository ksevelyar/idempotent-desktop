{lib, ...}: {
  home.file.".pi/agent/AGENTS.md".source = lib.mkDefault ./pi/AGENTS.md;
  home.file.".pi/agent/extensions".source = lib.mkDefault ./pi/extensions;
  home.file.".pi/agent/settings.json".source = lib.mkDefault ./pi/settings.json;
  home.file.".pi/agent/models.json".source = lib.mkDefault ./pi/models.json;
  home.file.".pi/agent/keybindings.json".source = lib.mkDefault ./pi/keybindings.json;
}
