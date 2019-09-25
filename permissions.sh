echo "Change owner of home folder to $REMOTE_USER"
chown $REMOTE_USER:$REMOTE_USER -R /home/$REMOTE_USER

echo "Change permission to installation folder /opt"
chmod -R 777 /opt/

echo "Add user $REMOTE_USER to docker group"
usermod -aG docker $REMOTE_USER

