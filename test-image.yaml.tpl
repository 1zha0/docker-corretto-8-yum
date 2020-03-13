schemaVersion: "2.0.0"

metadataTest:
  env:
    - key: JAVA_HOME
      value: /usr/lib/jvm/java-%AMAZON_CORRETTO_VERSION%-amazon-corretto

commandTests:
  - name: "java command is registered using alternatives."
    command: "java"
    args: ["-version"]
    expectedError: ["OpenJDK Runtime Environment Corretto-%AMAZON_CORRETTO_VERSION%.*"]

  - name: "javac command is registered using alternatives."
    command: "javac"
    args: ["-version"]
    expectedError: ["javac 1.*"]

  - name: "JAVA_HOME points to the correct directory."
    command: "$JAVA_HOME/bin/java"
    args: ["-version"]
    expectedError: ["OpenJDK Runtime Environment Corretto-%AMAZON_CORRETTO_VERSION%.*"]
