if grep -qE 'ID=fedora' /etc/os-release; then
  sudo dnf -y install libfprint fprintd fprintd-pam 'dnf-command(versionlock)'
  sudo dnf versionlock libfprint
  sudo cp -r lib/* /usr/lib/
  sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
  sudo chmod +x /usr/lib64/libfprint-2*
else
  sudo cp -r lib/* /lib/
  sudo cp -r usr/* /usr/
  sudo mkdir -p /var/log/fpc
  #avoid libfprint being modified under apt upgrading
  echo "libfprint-2-2 hold" | sudo dpkg --set-selections
  sudo chmod 755 /usr/lib/x86_64-linux-gnu/libfprint-2.so.2.0.0
fi
echo "Installation completed successfully. You must reboot your system."
