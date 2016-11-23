Manual for plugin "ConfigMgr"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


.. warning:: This article is under construction! Please DO NOT use any of the instructions below, yet! You may cause damage to your system. This article will be finished soon.

General assumptions:

#. Actions with ``Workflow`` prefix combine multiple actions. Workflow actions exist to standardize frequent used action combos.
#. Every action

************************************************************************************
Connection
************************************************************************************
In the computers namespace all connection relevant parameters are stored.

Authentication Methods (or integrated authentication)

a) Windows Auth: Do not set the corresponding credentials attributes *UserName, *UserPassword.

Example:

  .. literalinclude:: _static/ConnectionWinAuth.ps1
    :language: powershell

b) Clear text: Set the corresponding credentials attributes *UserName, *UserPassword.

Example:

  .. literalinclude:: _static/ConnectionClearText.ps1
    :language: powershell

c) Powershell Secure String: Will be supported in a later version.

************************************************************************************
Computers
************************************************************************************
Everthing concering computer management is stored in the ``Computers`` namespace.


==============================
Action WorkflowCreate
==============================

This worklow combines the following actions:

#. Check if computer exists (Delete if ``ComputerParameters.ComputerOverwriteExistingObject`` is true)
#. Create computer
#. Add variables to computer object
#. Add collection memberships to computer

Example (complete with connection):

.. literalinclude:: _static/WorkflowCreate.ps1
  :language: powershell

Expected output:

.. literalinclude:: _static/WorkflowCreate.log

