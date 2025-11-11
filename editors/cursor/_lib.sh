if ! type cursor &>/dev/null; then
  # Temporarily add Visual Studio code to the path.
  export PATH="$PATH:/Applications/Cursor.app/Contents/Resources/app/bin"
fi

if ! type cursor &>/dev/null; then
  echo "No command 'cursor' found."
  echo "Please make sure you have Cursor installed"
  echo "and that you executed this procedure: https://cursor.com/"
  exit 1
fi
