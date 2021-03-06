{ stdenv, lib, meson, ninja, fetchFromGitHub
, pkgconfig, zathura_core, cairo , gtk-mac-integration, girara, mupdf }:

stdenv.mkDerivation rec {
  version = "0.3.4";
  name = "zathura-pdf-mupdf-${version}";

  # pwmt.org server was down at the time of last update
  # src = fetchurl {
  #   url = "https://pwmt.org/projects/zathura-pdf-mupdf/download/${name}.tar.xz";
  #   sha256 = "1zbaqimav4wfgimpy3nfzl10qj7vyv23rdy2z5z7z93jwbp2rc2j";
  # };
  src = fetchFromGitHub {
    owner = "pwmt";
    repo = "zathura-pdf-mupdf";
    rev = version;
    sha256 = "1m4w4jrybpjmx6pi33a5saxzmfd8rrym2k13jpd1fv543s17d9dy";
  };

  nativeBuildInputs = [ meson ninja pkgconfig ];

  buildInputs = [
    zathura_core girara mupdf cairo
  ] ++ lib.optional stdenv.isDarwin gtk-mac-integration;

  PKG_CONFIG_ZATHURA_PLUGINDIR= "lib/zathura";

  meta = with lib; {
    homepage = https://pwmt.org/projects/zathura-pdf-mupdf/;
    description = "A zathura PDF plugin (mupdf)";
    longDescription = ''
      The zathura-pdf-mupdf plugin adds PDF support to zathura by
      using the mupdf rendering library.
    '';
    license = licenses.zlib;
    platforms = platforms.unix;
    maintainers = with maintainers; [ cstrahan ];
  };
}
