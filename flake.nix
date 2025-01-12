{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      mkNodejsApp = name: text: {
        type = "app";
        program = nixpkgs.lib.getExe (pkgs.writeShellApplication {
          inherit name text;
          runtimeInputs = [ pkgs.nodejs_20 ];
        });
      };

    in
    {
      apps.x86_64-linux.build = mkNodejsApp
        "build" "npx quartz build --directory ~/Muistiinpanot";
      apps.x86_64-linux.serve = mkNodejsApp
        "build" "npx quartz build --directory ~/Muistiinpanot --serve";
      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          packages = [ pkgs.nodejs_20 ];
        };
      };
    };
}
