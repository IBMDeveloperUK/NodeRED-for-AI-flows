# NodeRED on IBMi

The following process for installing and configuring Node-RED on IBMI is based on the original [developerWorks IBMi article](https://www.ibm.com/developerworks/ibmi/library/i-running-node-red/index.html), adjusted for the new open source packaging and current versions.

## IBM 5250 terminal emulator (free)
At some point, interacting with an IBMi system will likely require a terminal login;
for this, you will need a terminal emulator that understands and implements the 
[IBM 5250 terminal datastream](https://archive.org/details/bitsavers_ibm525xGA2onDisplaySystemFunctionsReferenceManualM_8040964)
Find further information about [5250 telnet](http://www.faqs.org/rfcs/rfc1205.html) if you're interested.

IBM and other commercial organisations offer a variety of terminal emulation products -
+ IBM Personal Communications
+ IBM System i Access
+ IBM Host on Demand
+ MochaSoft
+ Rocket BlueZone
+ ASNA
to name just a few.

If these are not available to you, there is a reasonably complete free offering [tn5250](http://tn5250.sourceforge.net)
```
https://sourceforge.net/projects/xtn5250/files/xtn5250/1.19m/xtn5250_119m.jar
```
or another java-based emulator [tn5250j](http://tn5250j.org/)

## Open source setup

THE repository for all things Open Source on *IBMi* is hosted at [bitbucket](https://bitbucket.org/ibmi/opensource/wiki/Home); here, you will find information about the transformation IBM has initiated to deliver open source packages and projects to the IBMi environment.

Historically, this was through an operating system licensed program option known as [5733-OPS](https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/IBM%20i%20Technology%20Updates/page/Open%20Source%20Technologies), with additonal packages coming from a wide range of IBM and non-IBM sources.

This approach has been sunsetted in favour of a fully open approrach, based on standard utilities and packaging - [_yum_](http://yum.baseurl.org/) and [_rpm_](http://rpm.org/).

The following installation of NodeRED uses the new installation process exclusively, without any dependence on [ACS](https://www-01.ibm.com/support/docview.wss?uid=isg3T1026805)


### Download and install the IBMi open source bootstrap

From the main repository at [bitbucket](https://bitbucket.org/ibmi/opensource/src/master/docs/yum#markdown-header-offline-install-instructions-without-acs), download all _*bootstrap**_ objects to your workstation.
```
ftp://public.dhe.ibm.com/software/ibmi/products/pase/rpms/bootstrap.sh
ftp://public.dhe.ibm.com/software/ibmi/products/pase/rpms/bootstrap.tar.Z
```

(This assumes your IBMi system has not yet been set up, and does not have the _curl_ or _wget_ utilities available)

Now transfer the two files to your IBMi- host system - if the *FTP* service is enabled, something like this will do the job.

```
	ftp {{host-ibmi}} 
    		prompt
		bin
		cd /tmp 
		mput bootstrap*
	quit
```

The bootstrap process needs to be run within an QShell; from the IBM command line, ensure multi-threading support is enabled,
and launch a QShell to verify the bootstrap files are in place.

```
ADDENVVAR ENVVAR(QIBM_MULTI_THREADED) VALUE(Y) LEVEL(*SYS)
STRQSH
	touch -C 819 /tmp/bootstrap.log
	ls -l /tmp/bootstrap.*
```
You should get a listing similar to 

![ftp-ls](/img/ibmi-nr-ftp-tmp-ls.png)


### Bootstrapping the environment
Now run the bootstrap install process, which will install a set of base packages (perl, python, rpm, yum and a few others) needed to get the yum/rpm installation management capability going.

```
	/QOpenSys/usr/bin/ksh /tmp/bootstrap.sh > /tmp/bootstrap.log 2>&1
```
Assuming all goes well, you should see the last few entries in _/tmp/bootstrap.log_ indicating success:

![bootstrap log](/img/ibmi-nr-bootstrap-sh-log.png)

It is now possible to install a supported version of Node.js as a base for NodeRED.
```
	cd /QOpenSys/pkgs/bin
	
	yum install gcc-aix libstdcplusplus-devel
	
	yum install nodejs8 && nodever 8
	npm --version
	export NODE_PATH=/QOpenSys/pkgs/lib/nodejs8/lib/node_modules
```

ensure the resulting package libraries are included in the PATH for the PASE//QShell environments
```
	export PATH=/QOpenSys/pkgs/bin:/QOpenSys/pkgs/lib/nodejs8/bin:$PATH
```

Optionally, add this command to the _.profile_ file to run each time the shell is started.

Note: some npm package installations need to know where the node executable resides that relates to the runtime of npm - use the following command to help avoid most errors related to this requirement
```
	npm config set scripts-prepend-node-path true
```

Optionally, add this command to the _.profile_ file to run each time the shell is started.

### NodeRED

Now install NodeRED:
```
	npm install -g --unsafe-perm node-red

	cd /QOpenSys/pkgs/bin
	/QOpenSys/pkgs/lib/nodejs8/bin/node-red
```
#### Watson services
To exploit the [Watson Cognitive services](https://console.bluemix.net/catalog/?category=ai) directly from the IBMi environment,
install the Watson package
```
	/QOpenSys/pkgs/bin/npm install node-red-node-watson
```

#### Cloud Object Storage
To access [IBM Cloud Object Storage](https://console.bluemix.net/catalog/services/cloud-object-storage) to save images, etc,
the following command will install associated NodeRED package:
```
	/QOpenSys/pkgs/bin/npm install node-red-contrib-cos
```

#### DB2 for i support
To use DB2 for i from a javascript application (such as NodeRED) on a system which has been initialised via the open source mechanism instead of 5377-OPS, a new connector module is available - [idb-connector](https://www.npmjs.com/package/idb-connector).

```
	/QOpenSys/pkgs/bin/npm install idb-connector
	/QOpenSys/pkgs/bin/npm install node-red-contrib-db2-for-i
```
The corresponding [NodeRED DB2 for i module](https://www.npmjs.com/package/node-red-contrib-db2-for-i) can use this package in place of the 5377-OPS version, but older versions need a minor tweak: 

Modify the resulting ibmdb2fori.js file (`/QOpenSys/pkgs/lib/nodejs8/lib/node_modules/node-red-contrib-db2-for-
i/ibmdb2fori.js` ) - change

`       var db = require('/QOpenSys/QIBM/ProdData/OPS/Node6/os400/db2i/lib/db2a');` 

to 

`       var db = require('db2a');` 

## Launch NodeRED on IBMi
To launch NodeRED, restart QShell, or launch a PASE terminal (*QP2TERM*), and start NodeRED:
```
	/QOpenSys/pkgs/lib/nodejs8/bin/node-red -v
```

All being well, you should see the NodeRED console start, and get confirmation that flows have started:

```
3 Dec 14:19:54 - [info]                                                                                                          
                                                                                                                                 
Welcome to Node-RED                                                                                                              
===================                                                                                                              
                                                                                                                                 
3 Dec 14:19:54 - [info] Node-RED version: v0.18.7                                                                                
3 Dec 14:19:54 - [info] Node.js  version: v8.11.3                                                                                
3 Dec 14:19:54 - [info] OS400 7.3 ppc64 BE                                                                                       
3 Dec 14:19:55 - [info] Loading palette nodes                                                                                    
3 Dec 14:19:56 - [warn] ------------------------------------------------------                                                   
3 Dec 14:19:56 - [warn] [node-red/rpi-gpio] Info : Ignoring Raspberry Pi specific node                                           
3 Dec 14:19:56 - [warn] ------------------------------------------------------                                                   
3 Dec 14:19:56 - [info] Settings file  : /HOME/QSECOFR/.node-red/settings.js                                                     
3 Dec 14:19:56 - [info] User directory : /HOME/QSECOFR/.node-red                                                                 
3 Dec 14:19:56 - [warn] Projects disabled : editorTheme.projects.enabled=false                                                   
3 Dec 14:19:56 - [info] Flows file     : /HOME/QSECOFR/.node-red/flows_.json                                                     
(node:793) Warning: N-API is an experimental feature and could change at any time.                                               
3 Dec 14:19:56 - [info] Server now running at http://127.0.0.1:1880/                                                         
3 Dec 14:19:56 - [warn]                                                                                                      
                                                                                                                             
---------------------------------------------------------------------                                                        
Your flow credentials file is encrypted using a system-generated key.                                                        
                                                                                                                             
If the system-generated key is lost for any reason, your credentials                                                         
file will not be recoverable, you will have to delete it and re-enter                                                        
your credentials.                                                                                                            
                                                                                                                             
You should set your own key using the 'credentialSecret' option in                                                           
your settings file. Node-RED will then re-encrypt your credentials                                                           
file using your chosen key the next time you deploy a change.                                                                
---------------------------------------------------------------------                                                        
                                                                                                                             
3 Dec 14:19:56 - [info] Starting flows                                                                                       
3 Dec 14:19:56 - [info] Started flows                                                                                       

```

You should now be able to launch the NodeRED IDE from your browser on port *1880*.

If the IDE opens as expected, you can start on getting your IBMi system to perform image classification with [Watson Visual Recognition](https://github.com/IBMCodeLondon/NodeRED-for-AI-flows/blob/master/watson-cognitive-nodered.md).


(A [sample NodeRED configuration](/ibmi/ibmi-nodered-flow.json) is available to import as a quickstart)
