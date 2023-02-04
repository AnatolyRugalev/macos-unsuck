# MacOS Unsuck

This is a collection of scripts and workarounds to improve UX of MacOS.

## Contents

### `scripts/unbind-quit-and-hide.sh`

This script unbinds <kbd>Command</kbd> + <kbd>Q</kbd> and <kbd>Command</kbd> + <kbd>H</kbd>
keys from all applications.

You can see the results of this script in `System Preferences` -> `Keyboard` -> `Shortcuts` -> `App Shortcuts`.

The script binds "Hide Others", "Hide" and "Quit" menu actions to <kbd>Control</kbd> + <kbd>Option</kbd> + 
<kbd>Shift</kbd> + <kbd>Command</kbd> + <kbd>Q</kbd>. This results in "Hide" and "Quit" actions to be completely 
unbound because of duplicate key.

<img width="326" alt="image" src="https://user-images.githubusercontent.com/1397674/216779367-686bdc75-8fa7-4a60-9079-f618f08b4512.png">

Some apps' titles may not be recognized correctly, and that's their developers' fault. You can add more apps that suck
to the top section of the script with a correct menu title (app name after "Quit " in the menu")

