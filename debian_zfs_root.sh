
## 1. Prepare the install environment

## 1.1 Boot the livecd, username user and password live

## 1.2 Optional start OpenSSH server in LiveCD env

#$ sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
#$ sudo service ssh restart

## 1.3 Become root
sudo -i

## 1.4 add contrib
echo "deb http://ftp.debian.org/debian stretch main contrib" > /etc/apt/sources.list
apt update

## 1.5 install ZFS in the Live CD env
apt install --yes debootstrap gdisk linux-headers-$(uname -r)
apt install --yes zfs-dkms zfs-initramfs

## 2. Disk Formatting

## clear previous partitions
apt install --yes mdadm
mdadm --zero-superblock --force /dev/disk/by-id/scsi-SATA_disk1
sgdisk --zap-all /dev/disk/by-id/scsi-SATA_disk1

## BIOS boot
# gdisk -a1 -n2:34:2047  -t2:EF02 /dev/disk/by-id/scsi-SATA_disk1
## EFI boot
 sgdisk     -n3:1M:+512M -t3:EF00 /dev/disk/by-id/scsi-SATA_disk1

## unencrypted or cCryptfs
# sgdisk     -n1:0:0      -t1:BF01 /dev/disk/by-id/scsi-SATA_disk1
# zpool create -o ashift=12 -O atime=off -O canmount=off -O compression=lz4 -O normalization=formD -O mountpoint=/ -R /mnt rpool /dev/disk/by-id/scsi-SATA_disk1-part1


## LUKS
sgdisk     -n4:0:+512M  -t4:8300 /dev/disk/by-id/scsi-SATA_disk1
sgdisk     -n1:0:0      -t1:8300 /dev/disk/by-id/scsi-SATA_disk1
cryptsetup luksFormat -c aes-xts-plain64 -s 256 -h sha256 /dev/disk/by-id/scsi-SATA_disk1-part1
cryptsetup luksOpen /dev/disk/by-id/scsi-SATA_disk1-part1 luks1


zpool create -o ashift=12 -O atime=off -O canmount=off -O compression=lz4 -O normalization=formD -O mountpoint=/ -R /mnt rpool /dev/mapper/luks1

## 3. System Installation

## 3.1 create container
zfs create -o canmount=off -o mountpoint=none rpool/ROOT

## 3.2 filesystem dataset
zfs create -o canmount=noauto -o mountpoint=/ rpool/ROOT/debian
zfs mount rpool/ROOT/debian
## Not sure if this is needed...
#zpool set bootfs=rpool/ROOT/debian rpool

## 3.3 Create datasets
zfs create                 -o setuid=off              rpool/home
zfs create -o mountpoint=/root                        rpool/home/root
zfs create -o canmount=off -o setuid=off  -o exec=off rpool/var
zfs create -o com.sun:auto-snapshot=false             rpool/var/cache
zfs create                                            rpool/var/log
zfs create                                            rpool/var/spool
zfs create -o com.sun:auto-snapshot=false -o exec=on  rpool/var/tmp

#If you use /srv on this system:
# zfs create                                            rpool/srv

#If this system will have games installed:
# zfs create                                            rpool/var/games

#If this system will store local email in /var/mail:
# zfs create                                            rpool/var/mail

#If this system will use NFS (locking):
# zfs create -o com.sun:auto-snapshot=false -o mountpoint=/var/lib/nfs                 rpool/var/nfs

## For LUKS install only
# mke2fs -t ext2 /dev/disk/by-id/scsi-SATA_disk1-part4
# mkdir /mnt/boot
# mount /dev/disk/by-id/scsi-SATA_disk1-part4 /mnt/boot

## 3.5 Install the minimal system
chmod 1777 /mnt/var/tmp
debootstrap stretch /mnt
zfs set devices=off rpool

## 4 System Configuration

## 4.1 Configure the hostname
echo debian > /mnt/etc/hostname

## 4.2 Configure the network interface
echo "127.0.1.1       debian" >> /etc/hosts
echo "auto enp0s3" > /mnt/etc/network/interfaces.d/enp0s3
echo "iface enp0s3 inet dhcp" >> /mnt/etc/network/interfaces.d/enp0s3

## 4.3 Bind mount virtual filesystems to new system and chroot

mount --rbind /dev  /mnt/dev
mount --rbind /proc /mnt/proc
mount --rbind /sys  /mnt/sys
chroot /mnt /bin/bash --login

## 4.4 Configure basic system environment

echo "deb http://ftp.debian.org/debian stretch main contrib" >> /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian stretch main contrib" >> /etc/apt/sources.list

ln -s /proc/self/mounts /etc/mtab
apt update

apt install --yes locales
dpkg-reconfigure locales
# or locale-gen en_US.UTF-8
# echo LANG=en_US.UTF-8 > /etc/default/locale

dpkg-reconfigure tzdata

apt install --yes gdisk linux-headers-$(uname -r) linux-image-amd64

## 4.5 Install ZFS in chroot env

apt install --yes zfs-dkms zfs-initramfs

### LUKS ONLY
# echo UUID=$(blkid -s UUID -o value /dev/disk/by-id/scsi-SATA_disk1-part4) /boot ext2 defaults 0 2 >> /etc/fstab

# apt install --yes cryptsetup

# echo luks1 UUID=$(blkid -s UUID -o value /dev/disk/by-id/scsi-SATA_disk1-part1) none luks,discard,initramfs > /etc/crypttab

## 4.6 Install GRUB

## MBR booting
# apt install --yes grub-pc

## EFI booting
# apt install dosfstools
# mkdosfs -F 32 -n EFI /dev/disk/by-id/scsi-SATA_disk1-part3
# mkdir /boot/efi
# echo PARTUUID=$(blkid -s PARTUUID -o value /dev/disk/by-id/scsi-SATA_disk1-part3) /boot/efi vfat defaults 0 1 >> /etc/fstab
# mount /boot/efi
# apt install --yes grub-efi-amd64

## 4.7 Set root password
passwd

## 4.8 Filesystem mount ordering (not sure if needed in Debian)
# zfs set mountpoint=legacy rpool/var/log
# zfs set mountpoint=legacy rpool/var/tmp
# cat >> /etc/fstab << EOF
#rpool/var/log /var/log zfs defaults 0 0
#rpool/var/tmp /var/tmp zfs defaults 0 0
#EOF

## 5. GRUB installation

## 5.1 Verify that ZFS root is recognized
grub-probe /
# should return: zfs

## 5.2 Refresh initrd
# update-initramfs -u -k all
# or
# update-initramfs -c -k all

## 5.3 (Optional) make debugging GRUB easier
# vi /etc/default/grub
#Remove quiet from: GRUB_CMDLINE_LINUX_DEFAULT
#Uncomment: GRUB_TERMINAL=console
#Save and quit.

## 5.4 Update the boot configuration
update-grub

## 5.5 Install boot loader

## MBR booting
# grub-install /dev/disk/by-id/scsi-SATA_disk1

## UEFI booting
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=debian --recheck --no-floppy

## 5.6 Verify that ZFS module is installed
# ls /boot/grub/*/zfs.mod

## 6. First Boot

## 6.1 Snapshot initial installation
# zfs snapshot rpool/ROOT/debian@install

## 6.2 Exit from chroot
# exit

## 6.3 Unmount filesystems
# mount | grep -v zfs | tac | awk '/\/mnt/ {print $3}' | xargs -i{} umount -lf {}
# zpool export rpool

## 6.4 Reboot
# reboot

## 6.5 Wait for system to boot.  Log in as root.

## 6.6 Create user account
# zfs create rpool/home/YOURUSERNAME
# adduser YOURUSERNAME
# cp -a /etc/skel/.[!.]* /home/YOURUSERNAME
# chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME

## eCryptfs
# apt install ecryptfs-utils
# zfs create -o compression=off -o mountpoint=/home/.ecryptfs/YOURUSERNAME rpool/home/temp-YOURUSERNAME
# adduser --encrypt-home YOURUSERNAME
# zfs rename rpool/home/temp-YOURUSERNAME rpool/home/YOURUSERNAME

## 6.7 Add user account to defaults for admin
# usermod -a -G audio,cdrom,dip,floppy,netdev,plugdev,sudo,video YOURUSERNAME

## 7. Configure swap

## 7.1 Create zvol for swap
# zfs create -V 4G -b $(getconf PAGESIZE) -o compression=zle -o logbias=throughput -o sync=always -o primarycache=metadata -o secondarycache=none -o com.sun:auto-snapshot=false rpool/swap

## 7.2 Configure swap device

## Unencrypted
# mkswap -f /dev/zvol/rpool/swap
# echo /dev/zvol/rpool/swap none swap defaults 0 0 >> /etc/fstab

## Encrypted (if using encrypted $HOME)
# echo cryptswap1 /dev/zvol/rpool/swap /dev/urandom swap,cipher=aes-xts-plain64:sha256,size=256 >> /etc/crypttab
# systemctl daemon-reload
# systemctl start systemd-cryptsetup@cryptswap1.service
# echo /dev/mapper/cryptswap1 none swap defaults 0 0 >> /etc/fstab

## 7.3 Enable swap device
# swapon -av

## 8. Full Software Installation

## 8.1 upgrade minimal system
# apt dist-upgrade --yes

## 8.2 (Optional) Disable log compression
#for file in /etc/logrotate.d/* ; do
#    if grep -Eq "(^|[^#y])compress" "$file" ; then
#        sed -i -r "s/(^|[^#y])(compress)/\1#\2/" "$file"
#    fi
#done

## 8.3 Reboot
# reboot

## 9. Final Cleanup

## 9.1 Wait for system to boot normally.  Log in as normal user.  Ensure system works (including networking.

## 9.2 (Optional) Delete snapshot of initial installation
# sudo zfs destroy rpool/ROOT/debian@install

## 9.3 (Optional) Disable root password

#sudo usermod -p '*' root

## 9.4 (Optional) Graphical boot process
#$ sudo vi /etc/default/grub
#Add quiet to GRUB_CMDLINE_LINUX_DEFAULT
#Comment out GRUB_TERMINAL=console
#Save and quit.

#$ sudo update-grub

####### TROUBLESHOOTING #########

## Become root and install ZFS utilities
#echo "deb http://ftp.debian.org/debian stretch main contrib" > /etc/apt/sources.list
#apt update
#apt install --yes debootstrap gdisk linux-headers-$(uname -r)
#apt install --yes zfs-dkms

## Export ZFS and reimport to get mounts right
# zpool export -a
# zpool import -N -R /mnt rpool
# zfs mount rpool/ROOT/debian
# zfs mount -a

## Chroot
# mount --rbind /dev  /mnt/dev
# mount --rbind /proc /mnt/proc
# mount --rbind /sys  /mnt/sys
# chroot /mnt /bin/bash --login

## Once finished, cleanup
# mount | grep -v zfs | tac | awk '/\/mnt/ {print $3}' | xargs -i{} umount -lf {}
# zpool export rpool
# reboot
