{ stdenv, lib, buildPythonApplication, python3, fetchFromGitHub }:

let
  python = python3.override {
    packageOverrides = self: super: {
      # pyCA is incompatible with SQLAlchemy 2.0
      sqlalchemy = super.sqlalchemy.overridePythonAttrs (old: rec {
        version = "1.4.46";
        src = self.fetchPypi {
          pname = "SQLAlchemy";
          inherit version;
          hash = "sha256-aRO4JH2KKS74MVFipRkx4rQM6RaB8bbxj2lwRSAMSjA=";
        };
      });
    };
  };
in
buildPythonApplication rec {
  pname = "pyca";
  version = "4.5";

  src = fetchFromGitHub {
    owner = "opencast";
    repo = "pyCA";
    rev = "v${version}";
    sha256 = "sha256-cTkWkOmgxJZlddqaSYKva2wih4Mvsdrd7LD4NggxKQk=";
  };

  propagatedBuildInputs = with python.pkgs; [
    pycurl
    python-dateutil
    configobj
    sqlalchemy
    sdnotify
    psutil
    flask
    prometheus-client
  ];

  meta = with lib; {
    broken = stdenv.isDarwin;
    description = "A fully functional Opencast capture agent written in Python";
    homepage = "https://github.com/opencast/pyCA";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ pmiddend ];
  };
}

