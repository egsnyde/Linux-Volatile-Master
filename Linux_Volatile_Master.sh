#!/bin/bash
#comments here - Local/system binary dependent volatile data collection script. Not to be used in applications which require a strict forensic procedure/statically compile binaries.
exec 2>/dev/null
irfname=`uname -n`.`date +%Y%m%d.%H%M%S`.volatile
date +"##### THIS SCRIPT STARTED RUNNING ON %Y-%m-%d AT %H:%M:%S %Z #####" >$irfname
date +"##### THIS SCRIPT STARTED RUNNING ON %Y-%m-%d AT %H:%M:%S %Z #####"
echo "##### HOSTNAME #####" >>$irfname
hostname >>$irfname
echo "##### DATE #####" >>$irfname
date >>$irfname
echo "##### UPTIME #####" >>$irfname
uptime >>$irfname
echo "##### UNAME #####" >>$irfname
uname -a >>$irfname
echo "##### CHASSIS/SERVICE TAG/SERIAL NUMBER #####" >>$irfname
dmidecode -s system-serial-number >>$irfname
echo "##### LSB_RELEASE -A #####" >>$irfname
lsb_release -a >>$irfname
echo "##### MOUNT #####" >>$irfname
mount >> $irfname
echo "##### /ETC/MTAB #####" >>$irfname
cat /etc/mtab >>$irfname
echo "##### /ETC/FSTAB #####" >>$irfname
cat /etc/fstab >>$irfname
echo "##### FDISK -L #####" >>$irfname
fdisk -l >>$irfname
echo "##### LVMDISKSCAN #####" >>$irfname
lvmdiskscan >>$irfname
echo "##### PVDISPLAY #####" >>$irfname
pvdisplay >>$irfname
echo "##### VGDISPLAY #####" >>$irfname
vgdisplay >>$irfname
echo "##### DF -H #####" >>$irfname
df -h >>$irfname
echo "##### DF -AT #####" >>$irfname
df -aT >>$irfname
echo "##### IFCONFIG #####" >>$irfname
ifconfig -a >>$irfname
echo "##### ROUTE INFO #####" >>$irfname
route -n >>$irfname
echo "##### CACHED ROUTE INFO #####" >>$irfname
route -Cn >>$irfname
echo "##### NETSTAT -AN #####" >>$irfname
netstat -an >>$irfname
echo "##### NETSTAT -IN #####" >>$irfname
netstat -in >>$irfname
echo "##### NETSTAT -RN #####" >>$irfname
netstat -rn >>$irfname
echo "##### RUNNING PROCESSES #####" >>$irfname
ps -eF >>$irfname
echo "##### LSOF -n #####" >>$irfname
lsof -n >>$irfname
echo "##### WHO #####" >>$irfname
who >> $irfname
echo "##### W #####" >>$irfname
w >>$irfname
echo "##### LAST #####" >>$irfname
last -ax >>$irfname
echo "##### LASTLOG #####" >>$irfname
lastlog >>$irfname
echo "##### DMESG #####" >>$irfname
dmesg >>$irfname
echo "##### ENV #####" >>$irfname
env >>$irfname
echo "##### DUMP CRONTAB ALL USERS #####" >>$irfname
getent passwd | awk -F: '{ print $1 }' | sudo xargs -n1 crontab -l -u 2>/dev/null >>$irfname
echo "##### SYSTEMD TIMERS #####" >>$irfname
systemctl list-timers -all >>$irfname
echo "##### LSMOD -V #####" >>$irfname
lsmod -v >>$irfname
echo "##### LSPCI -V #####" >>$irfname
lspci -v >>$irfname
echo "##### LSUSB -V #####" >>$irfname
lsusb -v >>$irfname
echo "##### /ETC/PASSWD #####" >>$irfname
cat /etc/passwd >>$irfname
echo "##### /ETC/PASSWD OLD #####" >>$irfname
cat /etc/passwd- >>$irfname
echo "##### /ETC/SHADOW #####" >>$irfname
cat /etc/shadow >>$irfname
echo "##### /ETC/SHADOW OLD #####" >>$irfname
cat /etc/shadow- >>$irfname
echo "##### /ETC/GROUP #####" >>$irfname
cat /etc/group >>$irfname
echo "##### /ETC/GROUP OLD #####" >>$irfname
cat /etc/group- >>$irfname
echo "##### /ETC/HOSTS #####" >>$irfname
cat /etc/hosts >>$irfname
echo "##### /ETC/HOSTS.ALLOW #####" >>$irfname
cat /etc/hosts.allow >>$irfname
echo "##### /ETC/HOSTS.DENY #####" >>$irfname
cat /etc/hosts.deny >>$irfname
echo "##### IPTABLES -N -L #####" >>$irfname
iptables -n -L >>$irfname
echo "##### /ETC/MOTD #####" >>$irfname
cat /etc/motd >>$irfname
echo "##### /ETC/ISSUE #####" >>$irfname
cat /etc/issue >>$irfname
tar cSzvvf `uname -n`.etc.tar.gz /etc
tar cSzvvf `uname -n`.tmp.tar.gz /tmp
tar cSzvvf `uname -n`.dev.shm.tar.gz /dev/shm
tar cSzvvf `uname -n`.var.tmp.tar.gz /var/tmp
# Certain files in var log cause issues as they are sparse files and can cause
# the below command to hang, hence the dash S.  If you still find this to be the case
# the script takes a exceptionally long time tarring var log,  then consider editing the below
# command to include "--exclude='lastlog' --exclude='faillog'"
# e.g. #tar cSzvvf `uname -n`.var.log.tar.gz --exclude='lastlog' --exclude='faillog' /var/log
tar cSzvvf `uname -n`.var.log.tar.gz /var/log
echo "##### BASH HISTORY FILES #####" >>$irfname
find / -name .bash_history | grep -v `pwd` >>$irfname
find / -name .bash_history -type f | while IFS= read -r NAME;do cp -v "$NAME" "`uname -n`${NAME//\//_}"; done
date +"##### THIS SCRIPT FINISHED RUNNING ON %Y-%m-%d AT %H:%M:%S %Z #####" >>$irfname
date +"##### THIS SCRIPT FINISHED RUNNING ON %Y-%m-%d AT %H:%M:%S %Z #####"
