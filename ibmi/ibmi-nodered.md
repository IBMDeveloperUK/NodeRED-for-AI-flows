### IBM 5250 terminal emulator (free)
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

### 
https://bitbucket.org/ibmi/opensource/src/master/docs/yum/
	download bootstrap*

```
	ftp {{host-ibmi}} 
    prompt
		bin
		cd /tmp 
		mput bootstrap*
	quit
```

```
ADDENVVAR ENVVAR(QIBM_MULTI_THREADED) VALUE(Y) LEVEL(*SYS)
STRQSH
```

```
	touch -C 819 /tmp/bootstrap.log
	/QOpenSys/usr/bin/ksh /tmp/bootstrap.sh > /tmp/bootstrap.log 2>&1

	cd /QOpenSys/pkgs/bin
	
	yum install nodejs8 && nodever 8
	npm --version
	
	yum install gcc-aix libstdcplusplus-devel
```

https://www.ibm.com/developerworks/ibmi/library/i-running-node-red/index.html

```
	npm install -g --unsafe-perm node-red

	cd /QOpenSys/pkgs/bin
	/QOpenSys/pkgs/lib/nodejs8/bin/node-red
```


/QOpenSys/pkgs/bin/npm install node-red-node-watson
/QOpenSys/pkgs/bin/npm install node-red-contrib-cos


