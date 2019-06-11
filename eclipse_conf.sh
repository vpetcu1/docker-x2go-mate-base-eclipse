ln -s "/opt/eclipse/eclipse" /home/$REMOTE_USER/Desktop/eclipse
chmod +x /home/$REMOTE_USER/Desktop/eclipse
echo "Change owner of eclipse shortcut"
chown $REMOTE_USER:$REMOTE_USER /home/$REMOTE_USER/Desktop/eclipse