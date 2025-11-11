setup_java8() {
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
  export PATH=$JAVA_HOME/bin:$PATH
}

setup_java11() {
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home"
  export PATH=$JAVA_HOME/bin:$PATH
}

setup_java17() {
  export JAVA_HOME="/usr/local/opt/openjdk@17"
  export PATH=$JAVA_HOME/bin:$PATH
}