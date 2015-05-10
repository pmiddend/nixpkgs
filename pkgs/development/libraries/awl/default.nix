{ stdenv, fetchgit, cmake-3_0, boost, fcppt, libX11 }:

stdenv.mkDerivation rec {
  name = "awl-1.0";

  src = fetchgit {
    url = https://github.com/freundlich/libawl.git;
    rev = "694963da2231dc2dc8035dfa9dad3d633a276dc8";
    sha256 = "1gpyhg8wdska3d393mlh8ps7g55pih7k41dkb8cbj8h6k31mxsv0";
  };

  buildInputs = [ cmake-3_0 boost fcppt libX11 ];
  configurePhase = ''
    modpath="$(echo "${fcppt}"/share/cmake/Modules)"
    mkdir build && cd build
    cmake \
      -DCMAKE_INSTALL_PREFIX=$out \
      -DCMAKE_MODULE_PATH=$modpath \
      ..
  '';

  meta = {
    description = "Abstract Window Library";
    longDescription = ''
    insert long description here
    '';
    homepage = https://github.com/freundlich/libawl;
    license = stdenv.lib.licenses.boost;
    /*maintainers = with stdenv.lib.maintainers; [ aforemny ];*/
  };
}
