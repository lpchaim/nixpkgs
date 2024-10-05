{ lib
, fetchFromGitHub

, cli11
, cmake
, darwin
, file
, gdk-pixbuf
, glib
, gnumake
, gtest
, gtk3
, libei
, libgcc
, libnotify
, libportal
, libX11
, libxkbcommon
, libxkbfile
, libXtst
, meson
, ninja
, pcre
, pkg-config
, pugixml
, python3
, qt6
, stdenv
, tomlplusplus
}:

stdenv.mkDerivation rec {
  pname = "deskflow";
  version = "1.17.0";

  src = fetchFromGitHub {
    owner = "deskflow";
    repo = "deskflow";
    rev = "e3ed711b98677f506a254c12e64b7eb7550cf9b9";
    hash = "sha256-4tSNrnxf9CQCiLn1lwa37jHCz9XNen5ArR9uyZRMggg=";
  };

  depsBuildBuild = [
    pkg-config
  ];

  nativeBuildInputs = [
    cmake
    gnumake
    meson
    ninja
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    cli11
    file
    gdk-pixbuf
    glib
    gtest
    gtk3
    libei
    libgcc
    libnotify
    libportal
    libX11
    libxkbcommon
    libxkbfile
    libXtst
    pcre
    pugixml
    python3
    qt6.qtbase
    tomlplusplus
  ]
  ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  configurePhase = ''
    cmake .
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
  '';

  meta = {
    description = "Share one mouse and keyboard between multiple computers";
    homepage = "https://github.com/deskflow/deskflow";
    changelog = "https://github.com/deskflow/deskflow/releases/tag/v${version}";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.unix;
    mainProgram = "deskflow";
    maintainers = with lib.maintainers; [ lpchaim ];
  };
}
