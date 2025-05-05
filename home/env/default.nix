{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      zlib
      pkg-config
      flex
      cmake
      python3
      postgresql
      nodejs
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      darwin.apple_sdk.frameworks.SystemConfiguration
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.Foundation
      darwin.apple_sdk.frameworks.Metal
    ];

  # c setup
  home.sessionVariables = {
    #LIBCLANG_PATH="${llvmPackages.libclang.lib}/lib";
    #C_INCLUDE_PATH="${lib.makeSearchPathOutput "dev" "include" [ glibc.dev stdenv.cc.cc ]}:$C_INCLUDE_PATH";
    #CPLUS_INCLUDE_PATH="${lib.makeSearchPathOutput "dev" "include" [ glibc.dev stdenv.cc.cc ]}:$CPLUS_INCLUDE_PATH";
    #LIBRARY_PATH="${lib.makeLibraryPath [ stdenv.cc.cc.lib ]}:$LIBRARY_PATH";
    #LD_LIBRARY_PATH="${lib.makeLibraryPath [ stdenv.cc.cc.lib ]}:$LD_LIBRARY_PATH";
  };
}
