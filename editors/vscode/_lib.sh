if ! type code &>/dev/null; then
  # Temporarily add Visual Studio code to the path.
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

if ! type code &>/dev/null; then
  echo "No command 'code' found."
  echo "Please make sure you have Visual Studio Code installed"
  echo "and that you executed this procedure: https://code.visualstudio.com/docs/setup/mac"
  exit 1
fi
