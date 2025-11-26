if grep -qE 'ID=fedora' /etc/os-release; then
  sudo cp ./libfpcbep.so /usr/lib64/
  sudo chmod +x /usr/lib64/libfpcbep.so
else
  sudo cp ./libfpcbep.so /usr/lib/x86_64-linux-gnu/
fi;
