{ lib
, buildPythonPackage
, django
, djangorestframework
, fetchPypi
, pyjwt
, python-jose
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "djangorestframework-simplejwt";
  version = "5.2.1";

  src = fetchPypi {
    pname = "djangorestframework_simplejwt";
    inherit version;
    sha256 = "sha256-dhOHTDIqP24zDMEY+fAKPblX/qf4477YG6RRhTzR29U=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    django
    djangorestframework
    pyjwt
    python-jose
  ];

  # Test raises django.core.exceptions.ImproperlyConfigured
  doCheck = false;

  pythonImportsCheck = [
    "rest_framework_simplejwt"
  ];

  meta = with lib; {
    description = "JSON Web Token authentication plugin for Django REST Framework";
    homepage = "https://github.com/davesque/django-rest-framework-simplejwt";
    license = licenses.mit;
    maintainers = with maintainers; [ arnoldfarkas ];
  };
}
