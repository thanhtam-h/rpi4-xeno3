sudo rm /boot/*4.19.86-v7l-ipipe
sudo rm -rf /usr/src/linux-headers-4.19.86-v7l-ipipe
sudo dpkg -i linux-image*
sudo dpkg -i linux-headers*
tar -xjvf linux-dts-4.19.86-ipipe.tar.bz2
cd dts
sudo cp -rf * /boot/
sudo mv /boot/vmlinuz-4.19.86-v7l-ipipe /boot/kernel7l.img
cd ..
sudo tar -xjvf xenomai-rpi4-deploy.tar.bz2 -C /
sudo cp xenomai.conf /etc/ld.so.conf.d/
sudo ldconfig
#sudo reboot
