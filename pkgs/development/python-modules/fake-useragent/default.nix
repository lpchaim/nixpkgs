{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  importlib-metadata,
  importlib-resources,
  setuptools,
  pythonOlder,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "fake-useragent";
  version = "1.5.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "fake-useragent";
    repo = "fake-useragent";
    rev = "refs/tags/${version}";
    hash = "sha256-BDXJJeT29GWkN9DoVl8sxXFpV/eMqu3mqlvMr2lzJM8=";
  };

  postPatch = ''
    sed -i '/addopts/d' pytest.ini
  '';

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs =
    [ ]
    ++ lib.optionals (pythonOlder "3.10") [ importlib-resources ]
    ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "fake_useragent" ];

  meta = with lib; {
    description = "Up to date simple useragent faker with real world database";
    homepage = "https://github.com/hellysmile/fake-useragent";
    changelog = "https://github.com/fake-useragent/fake-useragent/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ evanjs ];
  };
}
