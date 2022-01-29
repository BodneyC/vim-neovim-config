#!/usr/bin/env bash

SOFTWARE_DIR="$HOME/software"
JDTLS_DIR="$SOFTWARE_DIR/eclipse.jdt.ls"

cd "$SOFTWARE_DIR" || { echo "Couldn't cd $SOFTWARE_DIR" && exit 1; }
git clone https://github.com/eclipse/eclipse.jdt.ls.git
cd "$JDTLS_DIR" || { echo "Couldn't cd $JDTLS_DIR" && exit 1; }
./mvnw clean verify

CONFIG_DIR="$HOME/.config/eclipse.jdt.ls"
mkdir -p "$CONFIG_DIR"

STARTUP_SCRIPT="$HOME/.local/bin/jdt.ls.sh"

cat << EOF > "$STARTUP_SCRIPT"
#!/usr/bin/env bash

JAR="$JDTLS_DIR/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle "\$JAVA_HOME/bin/java" \\
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \\
  -Dosgi.bundles.defaultStartLevel=4 \\
  -Declipse.product=org.eclipse.jdt.ls.core.product \\
  -Dlog.protocol=true \\
  -Dlog.level=ALL \\
  -Xms1g \\
  -Xmx2G \\
  -jar "\$(echo \$JAR)" \\
  -configuration "$JDTLS_DIR/org.eclipse.jdt.ls.product/target/repository/config_linux" \\
  -data "$CONFIG_DIR" \\
  --add-modules=ALL-SYSTEM \\
  --add-opens java.base/java.util=ALL-UNNAMED \\
  --add-opens java.base/java.lang=ALL-UNNAMED
EOF

chmod +x "$STARTUP_SCRIPT"

############## Debug

JDBG_DIR="$SOFTWARE_DIR/java-debug"

cd "$SOFTWARE_DIR" || { echo "Couldn't cd $SOFTWARE_DIR" && exit 1; }
git clone https://github.com/microsoft/java-debug.git
cd "$JDBG_DIR" || { echo "Couldn't cd $JDBG_DIR" && exit 1; }
./mvnw clean verify

############## JUnit

JUNIT_DIR="$SOFTWARE_DIR/vscode-java-test"

cd "$SOFTWARE_DIR" || { echo "Couldn't cd $SOFTWARE_DIR" && exit 1; }
git clone https://github.com/microsoft/vscode-java-test
cd "$JUNIT_DIR" || { echo "Couldn't cd $JUNIT_DIR" && exit 1; }
npm i && npm run build-plugin
