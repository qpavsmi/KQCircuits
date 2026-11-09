#!/bin/sh
mkdir -p "$HOME"/.klayout/python .pip-cache

# This script's original intention was to be a CI platform agnostic set up script
# of KQC environment. Nowadays it is not really used, but if needed
# again could be used again, as long as venv is used correctly.

# shellcheck disable=SC1091
. /usr/local/ci-env/bin/activate
# Due to eMudhra (https://emudhra.we-have-a-problem.com/) we must use pip version 26.2.2
python -m pip install --cache-dir=.pip-cache \
    -r ci/requirements/pip-requirements.txt
python -m pip install --cache-dir=.pip-cache \
    -r klayout_package/python/requirements/linux/requirements.txt \
    -r klayout_package/python/requirements/linux/dev-requirements.txt
ret=$?
if [ $ret -ne 0 ]; then
    echo "Can't install KQCircuits: installing requirements.txt failed"
    exit $ret
fi
pip --cache-dir=.pip-cache install --no-deps --no-build-isolation -e "klayout_package/python/"
ret=$?
if [ $ret -ne 0 ]; then
    echo "Can't install KQCircuits: pip install --no-deps failed"
    exit $ret
fi
python setup_within_klayout.py
ret=$?
if [ $ret -ne 0 ]; then
    echo "Can't install KQCircuits: couldn't set it up for KLayout app"
    exit $ret
fi
