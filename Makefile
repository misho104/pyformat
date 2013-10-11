check:
	pep8 pyformat pyformat.py setup.py
	pep257 pyformat pyformat.py setup.py
	pylint \
		--reports=no \
		--disable=invalid-name \
		--rcfile=/dev/null \
		pyformat.py setup.py
	check-manifest
	python setup.py --long-description | rst2html --strict > /dev/null
	scspell pyformat pyformat.py setup.py test_pyformat.py README.rst

coverage:
	@rm -f .coverage
	@coverage run test_pyformat.py
	@coverage report
	@coverage html
	@rm -f .coverage
	@python -m webbrowser -n "file://${PWD}/htmlcov/index.html"

mutant:
	@mut.py -t pyformat -u test_pyformat -mc

readme:
	@restview --long-description --strict
