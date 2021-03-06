#!/system/bin/sh
export PATH=/system/xbin:$PATH

if [ ! -f /cache/pds-CM.img ]
then
    #make a copy of pds in /cache
    /system/xbin/dd if=/dev/block/platform/msm_sdcc.1/by-name/pds of=/cache/pds-CM.img
    echo "Backed up PDS"
fi

#mount the fake pds
/system/xbin/losetup /dev/block/loop0 /cache/pds-CM10.img
/system/bin/e2fsck -y /dev/block/loop0
/system/xbin/busybox mount -o rw /dev/block/loop0 /pds
/system/bin/restorecon -R /pds
/system/xbin/losetup /dev/block/loop0 /cache/pds-CM.img
/system/bin/mount -o rw -t ext3 /dev/block/loop0 /pds
echo "Mounted PDS"
