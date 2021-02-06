#!/usr/bin/env bash

JAR="/home-link/software/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=/home-link/gradle "$JAVA_HOME/bin/java" \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -XX:+UseG1GC \
  -javaagent:/home-link/.m2/repository/org/projectlombok/lombok/1.18.18/lombok-1.18.18.jar \
  -noverify \
  -jar "$(echo $JAR)" \
  -configuration "/home-link/software/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux" \
  -data "/home-link/.config/eclipse.jdt.ls" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
