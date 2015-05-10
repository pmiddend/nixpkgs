{ stdenv, fetchgit, cmake-3_0, boost, fcppt }:

stdenv.mkDerivation rec {
  name = "mizuiro-1.0";

  src = fetchgit {
    url = https://github.com/freundlich/mizuiro.git;
    rev = "54d6fa04e6053fa56b89f6f2d51b9b8ea005d79c";
    sha256 = "1xdwvmapra793ccqykqj683vbaq65nwxfi31wnpifxmk1glhiz0c";
  };

  buildInputs = [ cmake-3_0 boost fcppt ];
  configurePhase = ''
    modpath="$(echo "${fcppt}"/share/cmake/Modules)"
    mkdir build && cd build
    cmake \
      -DCMAKE_INSTALL_PREFIX=$out \
      -DCMAKE_MODULE_PATH=$modpath \
      ..
  '';

  meta = {
    description = "insert description here";
    longDescription = ''
    insert long description here
    '';
    homepage = https://github.com/freundlich/mizuiro;
    license = stdenv.lib.licenses.boost;
    /*maintainers = with stdenv.lib.maintainers; [ aforemny ];*/
  };
}
