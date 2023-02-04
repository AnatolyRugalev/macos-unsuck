#!/bin/bash

set -e

suckerID=com__logi__ghub; suckerTitle="G HUB"; declare "suckers_$suckerID=$suckerTitle"

apps="$(
  find /Applications -not -path '*/.*' -name '*.app' -maxdepth 1 | sort -h
)"

echo "$apps"

cd "$HOME/Library/Preferences"


property() {
  app=$1
  property=$2
  set +e
  output=$(/usr/libexec/plistbuddy -c "Print:$property" "$app/Contents/Info.plist" 2> /dev/null)
  exitCode=$?
  set -e
  if [[ $exitCode == 0 ]]; then
    echo "$output"
  fi
}

rebind() {
  app=$1
  title=$2
  defaults write -app "$app" NSUserKeyEquivalents -dict-add "Hide $title" '@~^$q'
  defaults write -app "$app" NSUserKeyEquivalents -dict-add "Quit $title" '@~^$q'
}

menuNameProperties=(
'CFBundleExecutable'
'CFBundleDisplayName'
'CFBundleName'
)

IFS=$'\n' read -a customMenuApps <<< $(defaults read ./com.apple.universalaccess.plist "com.apple.custommenu.apps" | sed -E -e 's/[[:blank:]",]//g' -e '1d' -e '$d' )
while IFS= read -r app; do
  echo $app
  bundleID=$(property "$app" "CFBundleIdentifier")
  if [[ -z "$bundleID" ]]; then
    continue
  fi
  sucker="suckers_${bundleID//./__}"
  suckerTitle="${!sucker}"
  if [[ -n "$suckerTitle" ]]; then
    rebind "$app" "$suckerTitle"
    continue
  fi
  for prop in "${menuNameProperties[@]}"; do
    title=$(property "$app" "$prop")
    if [[ -n "$title" ]]; then
      rebind "$app" "$title"
    fi
  done

  if [[ ! " ${customMenuApps[*]} " =~ " ${bundleID} " ]]; then
    defaults write "./com.apple.universalaccess.plist" "com.apple.custommenu.apps" -array-add "$bundleID"
  fi
done <<<"$apps"

defaults write -g NSUserKeyEquivalents -dict-add "Hide Others" '@~^$q'
if [[ ! " ${customMenuApps[*]} " =~ " NSGlobalDomain " ]]; then
  defaults write "./com.apple.universalaccess.plist" "com.apple.custommenu.apps" -array-add "NSGlobalDomain"
fi
