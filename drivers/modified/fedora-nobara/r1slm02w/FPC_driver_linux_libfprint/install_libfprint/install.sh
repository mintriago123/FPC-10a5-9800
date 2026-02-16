  sudo dnf -y install libfprint fprintd fprintd-pam 
  sudo cp -r lib/* /usr/lib/
  sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
  sudo chmod +x /usr/lib64/libfprint-2*


