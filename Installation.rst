Installation
=============

.. contents:: `In this article:`
    :depth: 2
    :local:
    

Requirements
----------------------------
#. For general information on system requirements see :doc:`/Requirements`.
#. Microsoft Active Directory Service Account for accessing SIM SQL DB (in this article ``sim-svc-sql``)

.. important:: Please install all requirements before beginning with this guide! 

IIS Features
----------------------------
Execute the following command to enable IIS features on the application server:

.. literalinclude:: /_static/Install-IIS-Features.cmd
  :language: batch

For easy deploymnet: :download:`Download the script </_static/Install-IIS-Features.zip>`.


Microsoft SQL Server
----------------------------
For information about supported SQL Server versions see :doc:`/SupportedConf`

The installation of the SQL Server will be described in the following steps.

Installation Setup
^^^^^^^^^^^^^^^^^^^^
Start the SQL Server installation setup.
Choose the "New SQL Server stand-alone installation..."-Option in the follwing Window:

.. image:: _static/install/SQLServerInstallation_00.png

Throughout the installation, please choose the same features as shown below:

.. image:: _static/install/SQLServerInstallation_01.png

Name the instance SIM or choose another name:

.. image:: _static/install/SQLServerInstallation_02.png

Configure the server as follows:

.. image:: _static/install/SQLServerInstallation_03.png

Customize the Database Engine

.. image:: _static/install/SQLServerInstallation_04-1.png 

Choose the Database Engine called 'SQL_Latin_General_CP1_CI_AS': 

.. image:: _static/install/SQLServerInstallation_04-2.png

Select the 'mixed mode'-authentification and add your AD service account for SQL (``sim-svc-sql``) as SQL Server administrator:

.. image:: _static/install/SQLServerInstallation_05.png

You have completed the setup!


SQL Server TCP/IP Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Open the SQL Server Configuration Manager, choose 'SQL Server Network Configuration' and then 'Protocols for [Database Name]'. Change the  TCP/IP Status to *Enabled*:

.. image:: _static/install/SQLServerInstallation_06.png

Right-click the TCP/IP line and choose 'Properties':

.. image:: _static/install/SQLServerInstallation_07.png

Choose the tab "IP Adresses" and change the 'TCP Port'-entry to 1433:

.. image:: _static/install/SQLServerInstallation_08.png

Afterwards, navigate to the SQL Server Services and restart the 'SQL Server ([Database Name]):

.. image:: _static/install/SQLServerInstallation_09.png


SIM SQL DB Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Create database ``SIM_v61_R001``
2. Grant SilverMonkey Service Account (``sim-svc-sql``) "db_owner" rights for the corresponding database

.. image:: _static/install/SQLUserMapping.png

3. Import .SQL file from installation media (.\\Database) into SQL Management Studio
4. Make sure the **USE** command aims to the correct database created above and execute script



Configure IIS
-------------


Create IIS App Pool
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Go to IIS Manager and create an AppPool with .NET CLR version set to ``No Managed Code`` :

.. image:: _static/install/IISAppPool.png

2. Go into the Advanced Settings of this AppPool and change the ``Process Model - Identity`` : 

.. image:: _static/install/IISAppPoolAdvancedSettings-1.png

3. Make sure to use a custom **Active Directory** user account, i.e. the  Service Account (``sim-svc-sql``) which has db_owner rights in the SIM v61 SQL database. This account is only used for accessing the own SQL database. Syntax: ``DOMAIN\UserName``.

.. image:: _static/install/IISAppPoolAdvancedSettings-2.png

Create SilverMonkey folder
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Create C:\\SilverMonkey
#. Copy files from installation media
#. Change connection string in file **C:\\SilverMonkey\\v61\\Config.xml** (XPath: //Configuration/DBConnection)


Create IIS Application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Go to IIS Manager, DefaultWebSite (or other Website, make sure to disable Impersonation). Impersonation is not supported for v61 and must not be inherited from Default Website to IIS application.

.. image:: _static/install/DefaultWebsiteAuth.png

2. Add application, choose SIM AppPool (created above) and target to C:\\SilverMonkey\\Web\\R001. 

.. hint:: The alias defines the later URL: http://HOSTNAME/ALIAS

.. image:: _static/install/IISApplicationCreate.png


Install Windows Service
-------------------------

1. Go to C:\\SilverMonkey\\v61\\WinService
2. Execute **Install.cmd** with administrative rights
3. Open services.msc and make sure that the Windows Service **SIMv61Service** is installed

.. image:: _static/install/SimWinService_01.png

4. Go into the properties of this service and change the Log On Account to the Service Account. This service account is used for the execution of every plugin run by the web service.

.. image:: _static/install/SimWinService_02.png


Test Installation
----------------------------------------

.. note:: For testing API download Postman: https://www.getpostman.com/ 

Test Query
^^^^^^^^^^^^^^^^^^

#. Start Postman
#. Select **GET** as option
#. Enter URL: http://SERVERNAME/APP_NAME/api/query?uniquename=TestQuery
#. Hit execute

The following result should appear:

.. image:: _static/install/APITestQuery.png

Test Queue
^^^^^^^^^^^^^^^^^^

#. Start Postman
#. Select **POST** as option
#. Enter URL: http://SERVERNAME/APP_NAME/api/Queue
#. Add following code to body:

.. code-block:: xml

    {"definition": "<Definition><Plugin>TestPlugin</Plugin><Data><ExampleString>HelloWorld</ExampleString></Data></Definition>"}

5. Hit execute

The following result should appear:

.. image:: _static/install/APITestQueue.png

.. image:: _static/install/APITestQueuePluginResult.png