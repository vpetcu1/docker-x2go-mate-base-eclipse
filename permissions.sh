echo "Change owner of home folder to $REMOTE_USER"
chown $REMOTE_USER:$REMOTE_USER -R /home/$REMOTE_USER

echo "Add user $USER to docker group"
usermod -aG docker $REMOTE_USER

