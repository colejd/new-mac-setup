# Finds the given UDID in the embedded.mobileprovision of the given IPA file.
function check_udid() {
  local COLOR_RED='\033[0;31m'          # Red
  local COLOR_GREEN='\033[0;32m'        # Green
  local COLOR_OFF='\033[0m'       # Text Reset

  # We want exactly two arguments: <path_to.ipa> <UDID>
  if [ "$#" -ne 2 ]; then
    echo "Usage: check_udid <path_to.ipa> <UDID>"
    return 1
  fi

  local ipa_path="$1"
  local udid="$2"

  # Use 'unzip -p' to read the embedded provisioning profile from the IPA
  # and pipe to 'security cms -D' to convert from CMS to XML,
  # then grep for the UDID.  
  if unzip -p "$ipa_path" "Payload/*.app/embedded.mobileprovision" \
    | security cms -D \
    | grep -q "$udid"; then
      echo "UDID $udid ${COLOR_GREEN}found${COLOR_OFF} in $ipa_path."
      return 0
  else
      echo "UDID $udid ${COLOR_RED}not found${COLOR_OFF} in $ipa_path!"
      return 1
  fi
}

# This function tells zsh how to complete arguments for 'check_udid'.
# - For the first argument, we only suggest .ipa files.
# - For the second argument, there's no file-suggestion, just plain text.
function _check_udid() {
  _arguments \
    '1:Select .ipa file:_files -g "*.ipa"' \
    '2:Enter UDID: '
}

# Bind the completion function to the command name
compdef _check_udid check_udid