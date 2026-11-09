.. _klayout:

Installing KLayout
------------------

Download and install KLayout from https://www.klayout.de/build.html. Builds
should exist there for most common operating systems, choose the correct one
for your OS.

An important consideration when choosing an installation package is how
a python interpreter is linked into the KLayout compilation. For linux builds,
it will always link the system python of the OS. For windows, a copy of python executable
is packaged with the installation. For macOS see the options in the notes below.

**KQCircuits requires Python 3.11 minimum.** This is not a problem for sufficiently
recent linux distributions (Ubuntu 24.04), as well as Windows and ``HW-*`` macOS installations
since pre-packaged python executables fulfill the requirement.

.. warning::
    Do note that updating system python executable to later version is **NOT** recommended
    and may risk breaking your operating system.

Wherever the python executable happens to be, make sure that ``pip`` package
manager is installed for that python executable.

.. note::
    For mac users:

    The ``arm64ST-*`` and ``ST-*`` packages are problematic for most macOS distributions because they
    have Python version 3.9.6 as the system python, which is not supported by KQCircuits code.
    Below are multiple alternative ways to install the KLayout.

    If you pick one of the two ``arm64LW-*`` options, make sure to download the installation
    package, open it, double click the ``ReadMeFirst`` folder, then open the ``*-ReadMeFirst.txt``
    file. You can follow the guide there, or our guide below. In the readme file keep note
    which python, qt and ruby versions to install, because KLayout will expect a specific version.

    .. collapse:: arm64LW-* MacPorts development environment

        Install the Apple Command Line Tools::

            xcode-select --install

        Make sure MacPorts is installed in your system from `MacPorts site <https://www.macports.org/>`_ or
        from `github releases <https://github.com/macports/macports-base/releases/>`_. Update MacPorts::

            sudo port -v selfupdate

        Following ``port`` commands are needed for KLayout GUI executable to link correctly.
        Check from the readme file which python, qt and ruby versions to install::

            sudo port install coreutils findutils qt5 ruby34 python314 py314-pip libgit2
            sudo port select --set python3 python314
            sudo port select --set python python314
            sudo port select --set pip3 pip314
            sudo port select --set pip pip314
            sudo port select --set ruby ruby34

        Proceed with installing ``arm64LW-* MacPorts development environment`` by following below instructions.

    .. collapse:: arm64LW-* Anaconda3 development environment

        We will use ``Miniforge`` so there is no need for any licensing agreements.
        If you have `HomeBrew <https://brew.sh/>`_ you can install miniforge with::

            brew update
            brew install --cask miniforge

        Initialize conda for your shell::

            /opt/homebrew/Caskroom/miniforge/base/bin/conda init zsh
            source ~/.zshrc

        You might need to fix some folder permissions. Try running::

            ls -ld "$HOME/.conda"

        If the output shows ``root``, fix it with::

            sudo chown -R $(whoami) "$HOME/.conda"

        Update conda to protect yourself from recent security vulnerabilities::

            conda install -n base -y --override-channels -c conda-forge "conda>=26.9.4" "certifi>=2026.10.19" ca-certificates
            conda --version

        Set up needed conda channels::

            conda config --env --add channels conda-forge
            conda config --env --set channel_priority strict

        Following conda configuration needed for KLayout GUI executable to link correctly.
        Check from the readme file which python, qt and ruby versions to install::

            conda create -n klayout-qt6 -y --override-channels -c conda-forge \
              "python=3.14" "pip>=26.2.2" "certifi>=2026.10.19" ca-certificates \
              "qt6-main=6.9.3" "qt6-multimedia=6.9.3" "ruby=3.4.7" "libgit2=1.9.1"
            conda activate klayout-qt6

        Add a symbolic link to conda python::

            sudo ln -s /opt/homebrew/Caskroom/miniforge/base /opt/anaconda3

        Proceed with installing ``arm64LW-* Anaconda3 development environment`` by following below instructions.

    .. collapse:: Using x86_64 compilation

        If you have an intel mac device, you should use ``x86_64`` compilation instead of ``arm64``.
        However, you can also use ``x86_64`` KLayout installation for Apple Silicon devices as well.
        You can then use the ``HW-*`` installation, which embeds a working python installation,
        thus KLayout GUI will work with no further configuration needed.
        For Apple Silicon devices it is dependent on Rosetta to recompile the KLayout executable during launch.
        This slows down KLayout startup, and also at some macOS release in the future
        Rosetta support will be deprecated.

    .. collapse:: Compiling KLayout from source

        KLayout can be compiled manually using your macOS device. We recommend
        `Guide 6C. Fully Homebrew-flavored build with Homebrew Ruby 3.4 and Homebrew Python 3.13 <https://github.com/KLayout/klayout/tree/master/macbuild#6c-fully-homebrew-flavored-build-with-homebrew-ruby-34-and-homebrew-python-313>`_,
        which we have tested to work for us. At the time of writing, the compilation seems to be
        `incompatible with Qt version 6.12.0 <https://github.com/KLayout/klayout/issues/2515>`_. A workaround is to disable
        Qt binding using the ``--noqtbinding`` option when running ``./build4mac.py``.
        If you wish to use Qt binding features, consider using some other Qt version.

    After downloading or acquiring the KLayout GUI installation package of your choice,
    open the package, in the opened window drag the klayout icon to
    the ``Applications`` folder. Close the window and eject the disk image.
    Now use ``Finder`` to open ``Applications`` folder,
    try opening the ``klayout`` app. MacOS will most likely prevent opening the application
    with ``"klayout" cannot be opened because the developer cannot be verified``.
    Open ``System Settings > Privacy & Security``, scroll down
    until you see a section mentioning KLayout and click button ``Open anyway``.

You can also build KLayout yourself, which allows you to link the python
executable of your choosing.

We recommend installing
KLayout without changing the installation directory location from default,
as many KQCircuits features assume that KLayout specific files can be found there.

.. note::
    If problems with linking python executable to KLayout installation seem insurmountable,
    do remember that it doesn't affect the :ref:`standalone`, in case you only care about
    such use case of KQCircuits.

KLayout is an actively maintained project with regular feature updates, bugfixes and
stability improvements. We recommend using the latest version. KQCircuits is automatically
tested using KLayout versions:

- 0.28.17
- 0.29.12
- latest version of 0.30

on the following platforms:

- Linux: Ubuntu 24.04 LTS, 64-bit
- MacOS: latest github image
- Microsoft Windows Server 2025, OS version 10
