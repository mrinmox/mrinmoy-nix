
{
  description = "Mrinmoy's reproducible development environments";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

      python = pkgs.python313.withPackages (ps: [
        ps.west
        ps.jsonschema
        ps.pyelftools
      ]);
    in {
      devShells.${system} = {

        # General workstation development
        tooling = pkgs.mkShell {
          packages = [
            pkgs.tmux
            pkgs.helix
            pkgs.julia
          ];

          shellHook = ''
            echo "Mrinmoy tooling environment"
            echo "tmux:  $(tmux -V)"
            echo "helix: $(hx --version | head -n1)"
            echo "julia: $(julia --version)"
          '';
        };

        # General C development
        c = pkgs.mkShell {
          packages = [
            pkgs.gcc
            pkgs.gdb
            pkgs.cmake
            pkgs.ninja
            pkgs.gnumake
            pkgs.pkg-config
            pkgs.clang-tools
            pkgs.cppcheck
          ];

          shellHook = ''
            echo "Mrinmoy C development environment"
            echo "GCC:    $(gcc --version | head -n1)"
            echo "CMake:  $(cmake --version | head -n1)"
            echo "Clangd: $(clangd --version | head -n1)"
          '';
        };

        # Zephyr development
        zephyr = pkgs.mkShell {
          packages = [
            python
            pkgs.cmake
            pkgs.ninja
            pkgs.qemu
            pkgs.gcc
            pkgs.gdb
          ];

          shellHook = ''
            export ZEPHYR_BASE="$HOME/projects/zephyr-workspace/zephyr"
            export ZEPHYR_SDK_INSTALL_DIR="$HOME/zephyr-sdk-1.0.1"

            echo "Mrinmoy Zephyr environment"
            echo "ZEPHYR_BASE=$ZEPHYR_BASE"
            echo "ZEPHYR_SDK_INSTALL_DIR=$ZEPHYR_SDK_INSTALL_DIR"
          '';
        };
      };
    };
}
