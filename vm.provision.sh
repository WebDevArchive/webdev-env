echo 'Start "vm.provision.sh"'
vmip=192.168.33.33

echo '[1] Init apache vhosts'
for vhFile in /var/www/*.conf
do
    sudo cp /var/www/*.conf /etc/apache2/sites-available/ -R
    vhConf=${vhFile##*/}
    sudo a2ensite ${vhConf}
    vhost=${vhConf%.*}
    sudo sed -i "2i${vmip}    ${vhost}" /etc/hosts
done
sudo chmod -R 755 /var/www
sudo service apache2 restart
echo '--------'

echo '[2] Install MC'
sudo apt-get --assume-yes install mc
echo '--------'

# echo '[3] Update NPM'
# sudo npm cache clean -f
# sudo npm install -g n
# sudo n stable
# echo '--------'