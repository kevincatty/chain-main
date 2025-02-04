{
  system ? builtins.currentSystem,
  pkgs ? import ../nix { inherit system; },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # build tools
    go_1_22
    rocksdb

    # lint tools
    test-env
    nixfmt
    lint-ci

    # tools
    cosmovisor
    hermes
    solomachine

    # chain-maind for testing
    chain-maind-test
  ];
  shellHook = ''
    export PYTHONPATH=$PWD/pystarport/proto_python/:$PYTHONPATH
    mkdir -p "$PWD/coverage"
    export GOCOVERDIR="$PWD/coverage"
  '';
}
