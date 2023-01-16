.. _salt_package:

Salt Package Guide
==================

A stable version of KQCircuits is often released as an easily accessible KLayout Salt Package.

Installing KQCircuits Salt Package
----------------------------------

Select "Tools -> Manage Packages" in the KLayout menu to install the KQCircuits package:

.. image:: images/install.gif

Note that KLayout was started in edit mode, see :ref:`usage`.

.. note::
   If KQCircuits is not working properly after installation (KQC libraries
   not visible, running any macro gives an error, etc.), there might be some
   problem with the specific KLayout version/build you are using, see
   :ref:`installation_issues` section for possible solutions.

User Specific Content
---------------------

Users may extend KQCircuits with their own Python packages containing additional elements, chips
etc. Use the `KQCircuits -> Add User Package` menu entry. Then user content may be added under the
individual library directories using your favourite code editor.

For example create a `user` package, this (by default) will be linked to a `user` directory in your
home folder. Copy KQC's `finger_capacitor_square.py` to `user\elements\my_capacitor.py` then edit
this file and change the `FingerCapacitorSquare` class name to `MyCapacitor`.

After restarting KLayout the newly added `MyCapacitor` element will be available together with the
standard KQCircuits elements.

Packages may be removed with the adjacent `KQCircuits -> Remove User Package` menu entry.

Upgrading or Removing Salt Package
----------------------------------

After upgrading KQCircuits package KLayout needs to be restarted. See the release notes
for further details.

Downgrading or upgrading several steps at once is not guaranteed to always work. Upgrading KQC
usually works but the safest approach is to uninstall KQC and then install a new version.

Remove the KQC Salt package before trying the :ref:`developer_setup`.

Release Notes
-------------

Here we list particular quirks of specific KQCircuits Salt packages. For a full list of changes see
the code repository.

* Version 4.5.0 is broken
* Version 4.1.0 requires full reinstall of KQC. Qubits directory has moved, to remove the earlier
  version we need to first remove KQC then install the new version.
* Version 4.0.0 requires full reinstall of KQC. Several files have been relocated, without a full
  reinstall multiple versions of the same file will be left behind.
* Version 3.3.0 needs manual install of ``tqdm`` Python module.

Manually Modifying or Creating Elements or Chips
------------------------------------------------

KLayout Salt packages are read-only. The user may open a chosen chip (say, ``[Package
KQCircuits]/kqcircuits/chips/simple``) with the embedded macro editor (``F5``) but it can not be
directly changed here. Of course, external code editors may be used to change these files or their
copies. On the downside, package upgrades may override these changes.

An other option is to copy (drag-and-drop) the Simple chip to the ``[Local]`` folder with the
embedded macro editor. This copy may be freely changed with the macro editor. First suggested change
would be to rename the chip. This is still not part of KQC. To make it visible in KLayout we need to
create a *symbolic link* to it from the designated chip folder in ``[Package
KQCircuits]/kqcircuits/chips/``. Finally, KLayout should re-read the now update KQC library, this
may be achieved by restarting or with the ``KQCircuits -> Reload libraries`` menu entry.

It may take a bit of effort to find where these folders are in a particular OS, in Linux::

    cd $HOME/.klayout/salt/KQCircuits/python/kqcircuits/chips
    ln -s $HOME/.klayout/pymacros/simple.py simpler.py

or in Windows::

    cd %HOME%/KLayout/salt/KQCircuits/python/kqcircuits/chips
    mklink simpler.py "%HOME%/KLayout/pymacros/simple.py"

Naturally, the same approach would work to copy/create other elements, qubits etc. Creating macros or
masks is even easier, no need to fumble with external editors or symlinks the default ``[Local]``
folder may be directly used to run the copied and modified macro or mask generation script. But for
serious development work we suggest following the :ref:`developer_setup`.
