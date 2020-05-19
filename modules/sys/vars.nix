{ config, lib, ... }:
{
  options.vars = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config._module.args.vars = config.vars;
}
