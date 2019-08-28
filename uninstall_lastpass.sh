#!/bin/bash
if [ -d ~/.mozilla/firefox ]
then
  for i in ~/.mozilla/firefox/*
  do
    if [ -d "$i" ]
    then
      rm -rf "$i/extensions/support@lastpass.com";
    fi
  done
fi

sudo rm -f /opt/google/chrome/extensions/hdokiejnpimakedhajhdlcegeplioahd.json
sudo rm -f /usr/share/chromium/extensions/hdokiejnpimakedhajhdlcegeplioahd.json
sudo rm -f /opt/google/chrome/lpchrome.crx
sudo rm -f /etc/opt/chrome/native-messaging-hosts/com.lastpass.nplastpass.json
sudo rm -f /etc/opt/chrome/native-messaging-hosts/nplastpass
sudo rm -f /etc/opt/chrome/native-messaging-hosts/nplastpass64
sudo rm -f /etc/chromium/native-messaging-hosts/com.lastpass.nplastpass.json
sudo rm -f /etc/chromium/native-messaging-hosts/nplastpass
sudo rm -f /etc/chromium/native-messaging-hosts/nplastpass64
sudo rm -f /usr/lib/mozilla/native-messaging-hosts/com.lastpass.nplastpass.json
sudo rm -f /usr/lib/mozilla/native-messaging-hosts/nplastpass
sudo rm -f /usr/lib/mozilla/native-messaging-hosts/nplastpass64
sudo rm -f /usr/lib64/mozilla/native-messaging-hosts/com.lastpass.nplastpass.json
sudo rm -f /usr/lib64/mozilla/native-messaging-hosts/nplastpass
sudo rm -f /usr/lib64/mozilla/native-messaging-hosts/nplastpass64
sudo rm -f /usr/share/mozilla/native-messaging-hosts/com.lastpass.nplastpass.json
sudo rm -f /usr/share/mozilla/native-messaging-hosts/nplastpass
sudo rm -f /usr/share/mozilla/native-messaging-hosts/nplastpass64
rm -f ~/.config/google-chrome/NativeMessagingHosts/com.lastpass.nplastpass.json
rm -f ~/.config/google-chrome/NativeMessagingHosts/nplastpass
rm -f ~/.config/google-chrome/NativeMessagingHosts/nplastpass64
rm -f ~/.config/chromium/NativeMessagingHosts/com.lastpass.nplastpass.json
rm -f ~/.config/chromium/NativeMessagingHosts/nplastpass
rm -f ~/.config/chromium/NativeMessagingHosts/nplastpass64
sudo rm -f ~/.mozilla/native-messaging-hosts/com.lastpass.nplastpass.json
sudo rm -f ~/.mozilla/native-messaging-hosts/nplastpass
sudo rm -f ~/.mozilla/native-messaging-hosts/nplastpass64
sudo rm -f /usr/lib64/opera/plugins/libnplastpass64.so
sudo rm -f /usr/lib64/opera-next/plugins/libnplastpass64.so
sudo rm -f /usr/lib64/operanext/plugins/libnplastpass64.so
sudo rm -f /usr/lib64/mozilla/plugins/libnplastpass64.so
sudo rm -f /usr/lib/opera/plugins/libnplastpass*.so
sudo rm -f /usr/lib/opera-next/plugins/libnplastpass*.so
sudo rm -f /usr/lib/operanext/plugins/libnplastpass*.so
sudo rm -f /usr/lib/mozilla/plugins/libnplastpass*.so

rm -rf ~/.lastpass

echo ""
echo "LastPass uninstallation complete!"
