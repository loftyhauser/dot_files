sudo -i

# add contrib
echo "deb http://ftp.debian.org/debian stretch main contrib" > /etc/apt/sources.list
apt update

# install utilities
apt install --yes debootstrap gdisk linux-headers-$(uname -r)
apt install --yes zfs-dkms

# clear previous partitions
apt install --yes mdadm
mdadm --zero-superblock --force /dev/disk/by-id/scsi-SATA_disk1
sgdisk --zap-all /dev/disk/by-id/scsi-SATA_disk1

# BIOS boot
# gdisk -a1 -n2:34:2047  -t2:EF02 /dev/disk/by-id/scsi-SATA_disk1
# EFI boot
# sgdisk     -n3:1M:+512M -t3:EF00 /dev/disk/by-id/scsi-SATA_disk1

# unencrypted
# sgdisk     -n1:0:0      -t1:BF01 /dev/disk/by-id/scsi-SATA_disk1
# zpool create -o ashift=12 -O atime=off -O canmount=off -O compression=lz4 -O normalization=formD -O mountpoint=/ -R /mnt rpool /dev/disk/by-id/scsi-SATA_disk1-part1


# LUKS
# sgdisk     -n4:0:+512M  -t4:8300 /dev/disk/by-id/scsi-SATA_disk1
# sgdisk     -n1:0:0      -t1:8300 /dev/disk/by-id/scsi-SATA_disk1
# cryptsetup luksFormat -c aes-xts-plain64 -s 256 -h sha256 \
      /dev/disk/by-id/scsi-SATA_disk1-part1
# cryptsetup luksOpen /dev/disk/by-id/scsi-SATA_disk1-part1 luks1
# zpool create -o ashift=12 -O atime=off -O canmount=off -O compression=lz4 -O normalization=formD -O mountpoint=/ -R /mnt rpool /dev/mapper/luks1

# System Installation
# zfs create -o canmount=off -o mountpoint=none rpool/ROOT

# zfs create -o canmount=noauto -o mountpoint=/ rpool/ROOT/debian
# zfs mount rpool/ROOT/debian
# zpool set bootfs=rpool/ROOT/debian rpool

# zfs create                 -o setuid=off              rpool/home
# zfs create -o mountpoint=/root                        rpool/home/root
# zfs create -o canmount=off -o setuid=off  -o exec=off rpool/var
# zfs create -o com.sun:auto-snapshot=false             rpool/var/cache
# zfs create                                            rpool/var/log
# zfs create                                            rpool/var/spool
# zfs create -o com.sun:auto-snapshot=false -o exec=on  rpool/var/tmp

#If you use /srv on this system:
# zfs create                                            rpool/srv

#If this system will have games installed:
# zfs create                                            rpool/var/games

#If this system will store local email in /var/mail:
# zfs create                                            rpool/var/mail

#If this system will use NFS (locking):
# zfs create -o com.sun:auto-snapshot=false \
             -o mountpoint=/var/lib/nfs                 rpool/var/nfs

