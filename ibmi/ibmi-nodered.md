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

https://sourceforge.net/projects/xtn5250/files/xtn5250/1.19m/xtn5250_119m.jar

xtn5250_119m.jar
172.19.83.238
cfgtcp - set DNS server 	nameserver 10.99.254.254,10.99.254.240
	CHGTCPDMN INTNETADR('10.99.254.254' '10.99.254.240' *SAME)

## Open source setup

THE repository for all things Open Source on *IBMi* is hosted at [bitbucket](https://bitbucket.org/ibmi/opensource/wiki/Home); here, you will find information about the transformation IBM has initiated to deliver open source packages and projects to the IBMi environment.

Historically, this was through an operating system licensed program option known as [5733-OPS](https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/IBM%20i%20Technology%20Updates/page/Open%20Source%20Technologies), with additonal packages coming from a wide range of IBM and non-IBM sources.

This approach has been sunsetted in favour of a fully open approrach, based on standard utilities and packaging - [_yum_](http://yum.baseurl.org/) and [_rpm_](http://rpm.org/).

The following installation of NodeRED uses the new installation process exclusively.


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

Now run the bootstrap install process, which will install a set of base packages (perl, python, rpm, yum and a few others) needed to get the yum/rpm installation management capability going.

```
	/QOpenSys/usr/bin/ksh /tmp/bootstrap.sh > /tmp/bootstrap.log 2>&1
```
Assuming all goes well, you should see the last few entries in _/tmp/bootstrap.log_ indicating success:

![bootstrap log](/imgs/ibmi-nr-boostrap-sh-log.png)

It is now possible to install a supported version of Node.js as a base for NodeRED:
```
	cd /QOpenSys/pkgs/bin
	
	yum install gcc-aix libstdcplusplus-devel
	
	yum install nodejs8 && nodever 8
	npm --version
	
```

https://www.ibm.com/developerworks/ibmi/library/i-running-node-red/index.html

```
	npm install -g --unsafe-perm node-red

	cd /QOpenSys/pkgs/bin
	/QOpenSys/pkgs/lib/nodejs8/bin/node-red
```


/QOpenSys/pkgs/bin/npm install node-red-node-watson
/QOpenSys/pkgs/bin/npm install node-red-contrib-cos

