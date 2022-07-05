# rpi4-xeno3

Full guide can be found at http://www.simplerobot.net/2019/12/xenomai-3-for-raspberry-pi-4.html

scripts, guide, pre-built kernel with xenomai 3 for raspberry pi 4

[scripts](https://github.com/thanhtam-h/rpi4-xeno3/tree/master/scripts)

------------
# prebuilt kernel and xenomai for rpi4
built 4.19.y ipipe patched kernel + prebuilt xenomai user-space libraries and tool. Pull down and deploy

Download prebuilt kernel
------------
Download and transfer all files in this directory to rpi4:

     git clone https://github.com/thanhtam-h/rpi4-xeno3.git
	 cd rpi4-xeno3/prebuilt
     
Automatically deploy
------------
Run these commands and deploy automatically, your rasperry pi will be updated and rebooted 
	
	 chmod +x deploy.sh
	 ./deploy.sh
	 	 
Post processing
------------ 
1. We need to fix Linux header before we can use it to build module native on rpi in future:
	```
	 cd /usr/src/linux-headers-4.19.86-v7l-ipipe
	 sudo make -i modules_prepare
	```
In this step, you may see many errors or even strange printing, just ignore them, your kernel header will work fine. 

2. Disable DWC features which may cause problem for ipipe kernel, add to the end of /boot/cmdline.txt (on a **SINGLE** line)
	```
	dwc_otg.fiq_enable=0 dwc_otg.fiq_fsm_enable=0 dwc_otg.nak_holdoff=0 
	```
3. CPU affinity, adding to the end of /boot/cmdline.txt file (on a **SINGLE** line)
	```
	isolcpus=0,1 xenomai.supported_cpus=0x3
	```
So finally your cmdline.txt file looks like this:
```
...rootwait splash plymouth.ignore-serial-consoles dwc_otg.fiq_enable=0 dwc_otg.fiq_fsm_enable=0 dwc_otg.nak_holdoff=0 isolcpus=0,1 xenomai.supported_cpus=0x3
```
4. There is a big issue found on 4G RAM version raspberry pi 4, although LPAE (Large Physical Address Extensions) allows Linux 32 bit can access fully 4G memory, the pcie DMA controller can only access up to 3G RAM. This usually causes problem for USB hub (connected via pcie) especially when user set large GPU memory (GPU always use low memory portion). This become serious on ipipe kernel. 
Workaround for this issue is to limit usable memory to 3G, add follow line to around beginning of **/boot/config.txt** file:
	```
	total_mem=3072
	```
* OpenGL driver won't work with Xenomai on raspberry pi, in order to get HDMI display we should disable OpenGL driver, comment out line "dtoverlay=vc4-fkms-v3d" in config.txt file

Finally, reboot raspberry pi.

