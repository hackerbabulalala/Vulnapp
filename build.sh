#!/usr/bin/env bash
set -e

#
# Note: It is assumed that the build script will be run as the root user.
#

echo "[+] Building P1YUSH-1"
echo "[+] OS: Ubuntu 22.04 LTS"
echo "[+] Author: Piyush Sharma"
echo "[+] Date: 2022-06-13"
echo "[+] Point Value: '5'"
echo " "

echo "[+] Starting The Installation Engine.."
echo ""
echo ""


echo "[+] Installing All The utilities"
apt install -y net-tools vim open-vm-tools
echo ""
echo "Done"
echo ""
echo ""

echo "[+] Configuring first vector"

echo ""
echo ""
echo ""


echo "[+] Installing Apache and PHP"
sudo apt update
apt install -y apache2 
sudo apt-get update
apt install software-properties-common -y
sudo apt-get update
sudo apt install -y php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath
sudo apt-get update
echo ""
echo "Done"
echo ""
echo ""


echo "[+]Enabling services at boot"
sudo systemctl enable apache2
sudo systemctl enable ssh
sudo systemctl start apache2
sudo systemctl start ssh
echo ""
echo "Done"
echo ""
echo ""

echo "[+] Installing fire-wall"
apt install ufw
echo "[+] Cheacking Fire-wall Status"
ufw status
echo "[+] Enabling Fire-wall"
ufw enable
echo "[+] Enabled Fire-wall"
ufw status
echo "[+] Enabling Firewall rules"
ufw allow ssh
ufw allow http
ufw status
echo ""
echo "Done"
echo ""
echo ""


echo "[+] Creating vulnerable website"
echo "."
echo ".."
echo "..."
echo "...."
echo "....."
echo "......"
echo "[+] Working On WebSite"
rm -rf /var/www/html/index.html
sudo apt install zip -y
sudo apt install unzip -y
unzip ./web_files.zip -d /var/www/html/
echo ""
echo "Done"
echo ""
echo ""

echo "[+] Configuring second vector"
echo '<?php phpinfo(); ?>' > /var/www/html/data.php
chown -R www-data:www-data /var/www/html/
chown -R www-data:www-data /var/log/apache2/
chown -R www-data:www-data /var/log/apache2/access.log
echo ""
echo "Done"
echo ""
echo ""

echo "[+] Configuring firewall"
echo "[+] Installing iptables"
echo "iptables-persistent iptables-persistent/autosave_v4 boolean false" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean false" | debconf-set-selections
apt install -y iptables-persistent
echo ""
echo "Done"
echo ""
echo ""
#
# Note: Unless specifically required as part of the exploitation path, please
#       ensure that inbound ICMP and SSH on port 22 are permitted.
#

echo "[+] Applying inbound firewall rules"
iptables -I INPUT 1 -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A INPUT -j DROP
echo ""
echo "Done"
echo ""
echo ""
#
# Note: Unless specifically required as part of the exploitation path, please
#       ensure that outbound ICMP, DNS (TCP & UDP) on port 53 and SSH on port 22
#       are permitted.
#

echo "[+] Applying outbound firewall rules"
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -j DROP
echo "[+] Saving firewall rules"
service netfilter-persistent save
echo ""
echo "Done"
echo ""
echo ""
echo "[+] Disabling IPv6"
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=""/GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"/' /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
update-grub
echo ""
echo "Done"
echo ""
echo ""
echo "[+] Configuring hostname"
hostnamectl set-hostname P1YUSH-1
cat << EOF > /etc/hosts
127.0.0.1 localhost
127.0.0.1 piyush-1
EOF
echo "Done"
echo ""
echo "[+] Creating users if they don't already exist"
id -u piyush &>/dev/null || useradd -m piyush
echo "[+] Modifying permissions for /etc/sudoers"
echo "piyush ALL=(ALL) NOPASSWD: /usr/bin/apt" >> /etc/sudoers
sudo deluser piyush sudo
echo "  www-data P1YUSH-1 = (piyush) NOPASSWD: /usr/bin/git"
echo ""
echo "Done"
echo ""
echo ""
echo "[+] Disabling history files"
ln -sf /dev/null /root/.bash_history
ln -sf /dev/null /home/piyush/.bash_history
echo ""
echo "Done"
echo ""
echo ""
#
# Note: Unless specifically required as part of the exploitation path, please
#       ensure that root login via SSH is permitted.
#

echo "[+] Enabling root SSH login"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
echo ""
echo "Done"
echo ""
echo ""

echo "[+] Setting passwords"
echo "root:P1yushHasAV@lidR00t" | chpasswd
echo 'piyush:PiyushHasAV@lidU$er' | chpasswd
echo ""
echo "Done"
echo ""
echo ""
echo ""

echo "[+] Dropping flags"
echo "41bab9633a20cd4a82ab4fd3f8703b59" > /root/proof.txt
echo "1316bf5401c3ea33de8805916116254e" > /home/piyush/local.txt
chmod 0600 /root/proof.txt
chmod 0644 /home/piyush/local.txt
chown piyush: /home/piyush/local.txt 
chmod 755 /home/piyush
echo ""
echo "Done"
echo ""
echo ""


#
# Note: Please ensure that any artefacts and log files created by the build script or
#       while running the build script are removed afterwards.
#
echo "================Thats The End Of This Script================="
echo ""
echo ""
echo "[+] Cleaning up"
rm -rf /root/build.sh
rm -rf /root/web_files.zip
rm -rf /root/.cache
rm -rf /root/.viminfo
rm -rf /home/piyush/.sudo_as_admin_successful
rm -rf /home/piyush/.cache
rm -rf /home/piyush/.viminfo
find /var/log -type f -exec sh -c "cat /dev/null > {}" \;
echo "Every Thing Done"
echo ""
echo ""
echo ""
echo "============Thank you For Your Precious Time============= "
echo ""
echo ""
echo ""
echo ""
echo "======================Happy-Hacking======================"
echo ""
echo ""
echo ""
echo ""
