---
layout: post
---

## Gcloud and PHP

Python 2.7 needs to be installed to run the GAE app server.

Check the installed gcloud components

	C:\>gcloud components list
	Your current Cloud SDK version is: 223.0.0
	The latest available version is: 224.0.0
	+----------------------------------------------------------------------------------------------------------------+
	|                                                   Components                                                   |
	+------------------+------------------------------------------------------+--------------------------+-----------+
	|      Status      |                         Name                         |            ID            |    Size   |
	+------------------+------------------------------------------------------+--------------------------+-----------+
	| Update Available | Cloud SDK Core Libraries                             | core                     |   8.8 MiB |
	| Update Available | gcloud app Python Extensions                         | app-engine-python        |   6.2 MiB |
	| Not Installed    | App Engine Go Extensions                             | app-engine-go            |  56.9 MiB |
	| Not Installed    | Cloud Bigtable Command Line Tool                     | cbt                      |   6.2 MiB |
	| Not Installed    | Cloud Bigtable Emulator                              | bigtable                 |   4.2 MiB |
	| Not Installed    | Cloud Datalab Command Line Tool                      | datalab                  |   < 1 MiB |
	| Not Installed    | Cloud Datastore Emulator (Legacy)                    | gcd-emulator             |  38.1 MiB |
	| Not Installed    | Cloud Pub/Sub Emulator                               | pubsub-emulator          |  33.4 MiB |
	| Not Installed    | Cloud SQL Proxy                                      | cloud_sql_proxy          |   3.5 MiB |
	| Not Installed    | Emulator Reverse Proxy                               | emulator-reverse-proxy   |  14.5 MiB |
	| Not Installed    | Google Container Registry's Docker credential helper | docker-credential-gcr    |   1.8 MiB |
	| Not Installed    | gcloud Alpha Commands                                | alpha                    |   < 1 MiB |
	| Not Installed    | gcloud Beta Commands                                 | beta                     |   < 1 MiB |
	| Not Installed    | gcloud app Java Extensions                           | app-engine-java          | 108.8 MiB |
	| Not Installed    | gcloud app PHP Extensions                            | app-engine-php           |  19.1 MiB |
	| Not Installed    | gcloud app Python Extensions (Extra Libraries)       | app-engine-python-extras |  28.5 MiB |
	| Not Installed    | kubectl                                              | kubectl                  |   < 1 MiB |
	| Installed        | BigQuery Command Line Tool                           | bq                       |   < 1 MiB |
	| Installed        | Cloud Datastore Emulator                             | cloud-datastore-emulator |  17.7 MiB |
	| Installed        | Cloud Storage Command Line Tool                      | gsutil                   |   3.5 MiB |
	+------------------+------------------------------------------------------+--------------------------+-----------+
	
and install the PHP Extensions if necessary.

	C:>gcloud components install app-engine-php

Install the same version of PHP 7.2 that is used on Azure Web Apps. 

	choco install php --version 7.2.10

## Windows Only

Check if it runs with the built in PHP server using the code from <https://github.com/joejcollins/ColonelWhite>.

	php -S localhost:8080

## Windows and GAE

Then test with the GAE app server (which shouldn't work, since the sqlite drivers cannot be found to be loaded).

	dev_appserver.py --php_executable_path=C:\tools\php72\php-cgi.exe --support_datastore_emulator=False app.yaml

GAE expects a local php.ini in development so rename `php.ini.WindowsGAE` to `php.ini` and edit appropriately.  Then the sqlite error should disappear.

## Windows Azure.

Commits to the develop branch are deployed to <https://colonel-white.azurewebsites.net/>.  This is an Azure App Service running PHP 7.2.  The PHP 7.2 versions does not come with the sqlite drivers.  (The PHP 5.6 version does, go figure).  The sqlite extensions are in /ext and /ini contains an additional extensions.ini file which locates the two dll's on with Windows Azure file system <https://docs.microsoft.com/en-gb/azure/app-service/web-sites-php-configure#how-to-enable-extensions-in-the-default-php-runtime>.  The Web App Service configuration `PHP_INI_SCAN_DIR=d:\home\site\wwwroot\ini`.  Be advised that the extensions (dll's) come from (<https://windows.php.net/downloads/releases/archives/> php-7.2.10-nts-Win32-VC15-x86.zip) and are:

* for PHP version 7.2.10 to match the Azure version
* Non Thread Safe (nts) for reasons I don't understand
* Win32-x86 not 64-bit
* VC15

Details and logs for the Azure App Service and be seen at <https://colonel-white.scm.azurewebsites.net/>.
