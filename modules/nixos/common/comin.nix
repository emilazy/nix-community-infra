{ inputs, ... }:
{
  imports = [
    inputs.comin.nixosModules.comin
  ];

  services.telegraf.extraConfig.inputs.prometheus.urls = [
    "http://localhost:4243/metrics"
  ];

  services.comin = {
    enable = true;
    remotes = [
      {
        url = "https://github.com/nix-community/infra.git";
        name = "origin";
        poller.period = 300; # every 5 minutes
        branches.main.name = "master";
        branches.testing.name = ""; # disable testing branch
      }
    ];
  };
}
