#!/bin/bash

command -v sudo > /dev/null || {
  echo "This script requires sudo.  Please install sudo."
  exit 1
}
command -v wget > /dev/null || {
  command -v apt-get > /dev/null && sudo apt-get install wget
  command -v yum > /dev/null && sudo yum install wget
  command -v zypper > /dev/null && sudo zypper install wget
}
command -v wget > /dev/null || {
  echo "This script requires wget.  Please install wget."
  exit 1
}
command -v unzip > /dev/null || {
  command -v apt-get > /dev/null && sudo apt-get install unzip
  command -v yum > /dev/null && sudo yum install unzip
  command -v zypper > /dev/null && sudo zypper install unzip
}
command -v unzip > /dev/null || {
  echo "This script requires unzip.  Please install unzip."
  exit 1
}

TDIR=$(mktemp -d);
if [ $? != 0 ]; then
  echo "Failed to create temporary directory using mktemp (install mktemp?):  $TDIR, abort"
  exit 1
fi

cp -f nplastpass nplastpass64 "$TDIR"
if [ $? != 0 ]; then
   echo "Failed to copy nplastpass and nplastpass64 to tempoary directory $TDIR, abort"
   exit 1
fi

cd "$TDIR" || exit
if [ $? != 0 ]; then
   echo "Failed to change to tempoary directory $TDIR, abort"
   exit 1
fi

rm -f lpchrome_linux.crx
wget -O lpchrome_linux.crx "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=68.0.3440.75&x=id%3Dhdokiejnpimakedhajhdlcegeplioahd%26uc"
if [ $? != 0 ]
then
  echo "Failed to download Chrome extension!"
  exit 1
fi

if [ $(uname -m) = "x86_64" ]
then
  NPLASTPASS=nplastpass64
else
  NPLASTPASS=nplastpass
fi

HOME=~

if [ -d ~/.mozilla ]
then
  for LIBDIR in lib lib64 share
  do
    if [ -d /usr/$LIBDIR/mozilla ]
    then
      echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"/usr/$LIBDIR/mozilla/native-messaging-hosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_extensions\": [ \"support@lastpass.com\" ] }" > com.lastpass.nplastpass.json
      sudo mkdir -p  /usr/$LIBDIR/mozilla/native-messaging-hosts/
      sudo chmod a+rx  /usr/$LIBDIR/mozilla/native-messaging-hosts/
      sudo cp -f $NPLASTPASS /usr/$LIBDIR/mozilla/native-messaging-hosts/
      sudo chmod a+rx /usr/$LIBDIR/mozilla/native-messaging-hosts/$NPLASTPASS
      sudo mv -f com.lastpass.nplastpass.json /usr/$LIBDIR/mozilla/native-messaging-hosts/
      sudo chmod a+r /usr/$LIBDIR/mozilla/native-messaging-hosts/com.lastpass.nplastpass.json
    fi
  done

  echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"$HOME/.mozilla/native-messaging-hosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_extensions\": [ \"support@lastpass.com\" ] }" > com.lastpass.nplastpass.json
  mkdir -p  ~/.mozilla/native-messaging-hosts/
  chmod a+rx  ~/.mozilla/native-messaging-hosts/
  cp -f $NPLASTPASS ~/.mozilla/native-messaging-hosts/
  chmod a+rx ~/.mozilla/native-messaging-hosts/$NPLASTPASS
  mv -f com.lastpass.nplastpass.json ~/.mozilla/native-messaging-hosts/
  chmod a+r ~/.mozilla/native-messaging-hosts/com.lastpass.nplastpass.json
fi

if [ -d ~/.config/google-chrome -o -d ~/.config/chromium -o -d ~/.config/opera -o -d ~/.config/opera-beta ]
then
  mkdir -p ~/.lastpass/tmp
  #sudo mkdir -p /opt/google/chrome/
  #CRX=/opt/google/chrome/lpchrome.crx
  #sudo cp lpchrome_linux.crx $CRX
  #VERSION=`unzip -c $CRX manifest.json 2>/dev/null | egrep "\"version\"" | egrep -o [0-9.]+`
  #echo "{ \"external_crx\": \"$CRX\", \"external_version\": \"$VERSION\" }" > hdokiejnpimakedhajhdlcegeplioahd.json
  #sudo mkdir -p /opt/google/chrome/extensions/
  #sudo chmod a+rx /opt/google/chrome/extensions/
  #sudo cp -f hdokiejnpimakedhajhdlcegeplioahd.json /opt/google/chrome/extensions/
  #sudo chmod a+r /opt/google/chrome/extensions/hdokiejnpimakedhajhdlcegeplioahd.json
  #sudo mkdir -p /usr/share/chromium/extensions/
  #sudo chmod a+rx /usr/share/chromium/extensions/
  #sudo mv -f hdokiejnpimakedhajhdlcegeplioahd.json /usr/share/chromium/extensions/
  #sudo chmod a+r /usr/share/chromium/extensions/hdokiejnpimakedhajhdlcegeplioahd.json

  echo "{ \"ExtensionInstallSources\": [\"https://lastpass.com/*\", \"https://*.lastpass.com/*\", \"https://d1jxck0p3rkj0.cloudfront.net/lastpass/*\"] }" > lastpass_policy.json
  sudo mkdir -p /etc/opt/chrome/policies/managed/
  sudo chmod a+rx /etc/opt/chrome/policies/managed/
  sudo cp -f lastpass_policy.json /etc/opt/chrome/policies/managed/
  sudo chmod a+r /etc/opt/chrome/policies/managed/lastpass_policy.json
  sudo mkdir -p /etc/chromium/policies/managed/
  sudo chmod a+rx /etc/chromium/policies/managed/
  sudo mv -f lastpass_policy.json /etc/chromium/policies/managed/
  sudo chmod a+r /etc/chromium/policies/managed/lastpass_policy.json

  echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"/etc/opt/chrome/native-messaging-hosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_origins\": [ \"chrome-extension://hdokiejnpimakedhajhdlcegeplioahd/\", \"chrome-extension://debgaelkhoipmbjnhpoblmbacnmmgbeg/\", \"chrome-extension://hnjalnkldgigidggphhmacmimbdlafdo/\", \"chrome-extension://hgnkdfamjgnljokmokheijphenjjhkjc/\" ] }" > com.lastpass.nplastpass.json
  sudo mkdir -p  /etc/opt/chrome/native-messaging-hosts/
  sudo chmod a+rx  /etc/opt/chrome/native-messaging-hosts/
  sudo cp -f $NPLASTPASS /etc/opt/chrome/native-messaging-hosts/
  sudo chmod a+rx /etc/opt/chrome/native-messaging-hosts/$NPLASTPASS
  sudo mv -f com.lastpass.nplastpass.json /etc/opt/chrome/native-messaging-hosts/
  sudo chmod a+r /etc/opt/chrome/native-messaging-hosts/com.lastpass.nplastpass.json

  echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"/etc/chromium/native-messaging-hosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_origins\": [ \"chrome-extension://hdokiejnpimakedhajhdlcegeplioahd/\", \"chrome-extension://debgaelkhoipmbjnhpoblmbacnmmgbeg/\", \"chrome-extension://hgnkdfamjgnljokmokheijphenjjhkjc/\" ] }" > com.lastpass.nplastpass.json
  sudo mkdir -p /etc/chromium/native-messaging-hosts/
  sudo chmod a+rx /etc/chromium/native-messaging-hosts/
  sudo cp -f $NPLASTPASS /etc/chromium/native-messaging-hosts/
  sudo chmod a+rx /etc/chromium/native-messaging-hosts/$NPLASTPASS
  sudo mv -f com.lastpass.nplastpass.json /etc/chromium/native-messaging-hosts/
  sudo chmod a+r /etc/chromium/native-messaging-hosts/com.lastpass.nplastpass.json

  echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"$HOME/.config/google-chrome/NativeMessagingHosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_origins\": [ \"chrome-extension://hdokiejnpimakedhajhdlcegeplioahd/\", \"chrome-extension://debgaelkhoipmbjnhpoblmbacnmmgbeg/\", \"chrome-extension://hnjalnkldgigidggphhmacmimbdlafdo/\", \"chrome-extension://hgnkdfamjgnljokmokheijphenjjhkjc/\" ] }" > com.lastpass.nplastpass.json
  mkdir -p  ~/.config/google-chrome/NativeMessagingHosts/
  chmod a+rx  ~/.config/google-chrome/NativeMessagingHosts/
  cp -f $NPLASTPASS ~/.config/google-chrome/NativeMessagingHosts/
  chmod a+rx ~/.config/google-chrome/NativeMessagingHosts/$NPLASTPASS
  mv -f com.lastpass.nplastpass.json ~/.config/google-chrome/NativeMessagingHosts/
  chmod a+r ~/.config/google-chrome/NativeMessagingHosts/com.lastpass.nplastpass.json

  echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"$HOME/.config/chromium/NativeMessagingHosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_origins\": [ \"chrome-extension://hdokiejnpimakedhajhdlcegeplioahd/\", \"chrome-extension://debgaelkhoipmbjnhpoblmbacnmmgbeg/\", \"chrome-extension://hgnkdfamjgnljokmokheijphenjjhkjc/\" ] }" > com.lastpass.nplastpass.json
  mkdir -p ~/.config/chromium/NativeMessagingHosts/
  chmod a+rx ~/.config/chromium/NativeMessagingHosts/
  cp -f $NPLASTPASS ~/.config/chromium/NativeMessagingHosts/
  chmod a+rx ~/.config/chromium/NativeMessagingHosts/$NPLASTPASS
  mv -f com.lastpass.nplastpass.json ~/.config/chromium/NativeMessagingHosts/
  chmod a+r ~/.config/chromium/NativeMessagingHosts/com.lastpass.nplastpass.json
fi

mkdir -p chrome
unzip -o "lpchrome_linux.crx" -d "chrome" 2>/dev/null
if [ -d /usr/lib64/opera/plugins/ ]
then
  sudo cp -f chrome/libnplastpass64.so /usr/lib64/opera/plugins/
  sudo chmod a+r /usr/lib64/opera/plugins/libnplastpass64.so
fi
if [ -d /usr/lib64/opera-next/plugins/ ]
then
  sudo cp -f chrome/libnplastpass64.so /usr/lib64/opera-next/plugins/
  sudo chmod a+r /usr/lib64/opera-next/plugins/libnplastpass64.so
fi
if [ -d /usr/lib64/operanext/plugins/ ]
then
  sudo cp -f chrome/libnplastpass64.so /usr/lib64/operanext/plugins/
  sudo chmod a+r /usr/lib64/operanext/plugins/libnplastpass64.so
fi
if [ -d /usr/lib64/ ]
then
  sudo mkdir -p /usr/lib64/mozilla/plugins/
  sudo cp -f chrome/libnplastpass64.so /usr/lib64/mozilla/plugins/
  sudo chmod a+r /usr/lib64/mozilla/plugins/libnplastpass64.so
fi
if [ $(uname -m) = "x86_64" ]
then
  NPLASTPASS=libnplastpass64.so
else
  NPLASTPASS=libnplastpass.so
fi
if [ -d /usr/lib/opera/plugins/ ]
then
  sudo cp -f chrome/$NPLASTPASS /usr/lib/opera/plugins/
  sudo chmod a+r /usr/lib/opera/plugins/$NPLASTPASS
fi
if [ -d /usr/lib/opera-next/plugins/ ]
then
  sudo cp -f chrome/$NPLASTPASS /usr/lib/opera-next/plugins/
  sudo chmod a+r /usr/lib/opera-next/plugins/$NPLASTPASS
fi
if [ -d /usr/lib/operanext/plugins/ ]
then
  sudo cp -f chrome/$NPLASTPASS /usr/lib/operanext/plugins/
  sudo chmod a+r /usr/lib/operanext/plugins/$NPLASTPASS
fi
if [ -d /usr/lib/ -a ! -d /usr/lib64/ ]
then
  sudo mkdir -p /usr/lib/mozilla/plugins/
  sudo cp -f chrome/$NPLASTPASS /usr/lib/mozilla/plugins/
  sudo chmod a+r /usr/lib/mozilla/plugins/$NPLASTPASS
else
  sudo rm -f /usr/lib/mozilla/plugins/libnplastpass64.so
fi

command -v opera > /dev/null && {
  opera https://lastpass.com/dl/ >/dev/null 2>&1 &
}

command -v google-chrome > /dev/null && {
  google-chrome https://lastpass.com/dl/inline/?full=1 >/dev/null 2>&1 &
}

command -v chromium-browser > /dev/null && {
  chromium-browser https://lastpass.com/dl/inline/?full=1 >/dev/null 2>&1 &
}

command -v firefox > /dev/null && {
  firefox https://lastpass.com/lastpassffx/ >/dev/null 2>&1 &
}

echo ""
echo "LastPass software components installed!"
echo ""
echo "Note: some browsers have disabled pre-loaded extensions."
echo "Please visit the browser window to complete LastPass installation."
echo ""
