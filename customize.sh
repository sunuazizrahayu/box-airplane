SKIPUNZIP=1
ASH_STANDALONE=1
arch=$(getprop ro.product.cpu.abi)
api_level=$(getprop ro.build.version.sdk)

if [ $BOOTMODE != true ]; then
  abort "Error: please install from Magisk Manager!"
fi
if ! command -v busybox &> /dev/null; then
  abort "BusyBox not found. Please install BusyBox first!"
fi

unzip -o "${ZIPFILE}" -x 'META-INF/*' -d $MODPATH >&2
if [ "${api_level}" -ge 26 ]; then
  case "${arch}" in
    "arm64-v8a")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/dynamic/curl-arm64"
      ;;
    "armeabi-v7a")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/dynamic/curl-arm"
      ;;
    "x86_64")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/dynamic/curl-x64"
      ;;
    "x86")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/dynamic/curl-x86"
      ;;
    *)
      echo "Unknown architecture: ${arch}"
      ;;
  esac
else
  case "${arch}" in
    "arm64-v8a")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/curl-arm64"
      ;;
    "armeabi-v7a")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/curl-arm"
      ;;
    "x86_64")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/curl-x64"
      ;;
    "x86")
      url="https://raw.githubusercontent.com/Zackptg5/Cross-Compiled-Binaries-Android/refs/heads/master/curl/curl-x86"
      ;;
    *)
      echo "Unknown architecture: ${arch}"
      ;;
  esac
fi
busybox wget -qO ${MODPATH}/curl ${url}
set_perm ${MODPATH}/curl 0 0 0755
set_perm ${MODPATH}/config.ini 0 0 0644
set_perm ${MODPATH}/iptables 0 0 0755
set_perm ${MODPATH}/modpes 0 0 0755
set_perm ${MODPATH}/action.sh 0 0 0755
set_perm ${MODPATH}/service.sh 0 0 0755
set_perm ${MODPATH}/sepolicy.rule 0 0 0644
ui_print "- Force enable module..."
rm -Rf ${MODPATH}/disable
