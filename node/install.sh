echo "› npm install spoof -g"

if test ! $(which spoof)
then
  sudo npm install spoof -g
fi
