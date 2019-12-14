# prebuilt kernel and xenomai for rpi4
built 4.19.y ipipe patched kernel + prebuilt xenomai user-space libraries and tool. Pull down and deploy

Download prebuilt kernel
------------
Download and transfer all files in this directory to rpi4:

     git clone https://github.com/thanhtam-h/rpi4-xeno3.git
	 cd rpi4-xeno3/prebuit
     
Automatically deploy
------------
Run these commands and deploy automatically, your rasperry pi will be updated and rebooted 
	
	 chmod +x deploy.sh
	 ./deploy.sh
	 	 
Post processing
------------ 
We need to fix Linux header before we can use it to build module native on rpi in future:

	 cd /usr/src/linux-headers-4.19.86-v7l-ipipe
	 sudo make -i modules_prepare