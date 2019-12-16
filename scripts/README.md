# rpi4-4.19.86-xeno3-scripts
Set of scripts and guide to build realtime kernel 4.19.86 with xenomai 3 for raspberry pi 4

References
------------
Xenomai 3: https://xenomai.org/installing-xenomai-3-x/
Raspberry pi linux: https://github.com/raspberrypi/linux

Here what I did:
- Modify ipipe patch (4.9.51) to adapt rpi kernel version of 4.9.80

Preparation on host PC
------------
      sudo apt-get install gcc-arm-linux-gnueabihf
      sudo apt-get install --no-install-recommends ncurses-dev bc

* Download xenomai-3:

      wget https://xenomai.org/downloads/xenomai/stable/xenomai-3.0.9.tar.bz2
      tar -xjvf xenomai-3.0.9.tar.bz2
      ln -s xenomai-3.0.9 xenomai
MODIFY 'xenomai/scripts/prepare-kernel.sh' file
Replace 'ln -sf' by 'cp'  so that it will copy all neccessary xenomai files to linux source

* Download rpi-linux-4.19.86:

	  git clone git://github.com/raspberrypi/linux.git linux-rpi-4.19.86-xeno3
	  cd linux-rpi-4.19.86-xeno3
	  git reset --hard c078c64fecb325ee86da705b91ed286c90aae3f6
	  ln -s linux-rpi-4.19.86-xeno3 linux
    
* Download patches set from:

	  mkdir xeno3-patches
Download all files in this directory and save them to *xeno3-patches* directory

	  https://github.com/thanhtam-h/rpi4-xeno3/tree/master/scripts	  
	
Patching
------------
	 cd linux
    
1. Pre-patch:
		patch -p1 <../pre-rpi4-4.19.86-xenomai3-simplerobot.patch
2. Xenomai patching:	
	  	../xenomai/scripts/prepare-kernel.sh --linux=./  --arch=arm  --ipipe=../xeno3-patches/ipipe-core-4.19.82-arm-6-mod-4.49.86.patch
      

Building kernel
------------
	  
	Refer to rpi3 case: https://github.com/thanhtam-h/rpi23-4.9.80-xeno3/blob/master/scripts/README.md
           
      
Prosprocessing
------------  
	**Disable DWC features which may cause ipipe issue: adding to the end of single-line in */boot/cmdline.txt* file**
	dwc_otg.fiq_enable=0 dwc_otg.fiq_fsm_enable=0 dwc_otg.nak_holdoff=0
	
	**CPU affinity**
	isolcpus=0,1 xenomai.supported_cpus=0x3
	
Test xenomai on rpi
------------      
In order to test whether your kernel is really patched with xenomai, run the latency test from xenomai tool:

      sudo /usr/xenomai/bin/latency
If latency tool get start and show some result, you are now have realtime kernel for your rpi

      

