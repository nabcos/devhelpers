#!/bin/sh

#
# Run mvn license:check -N on the current project
# Only executes license check if:
# - project is a Maven project ( has a pom.xml in root )
# - pom.xml contains a reference to maven-license-plugin
#

if egrep -qs '<groupId>com.mycila.maven-license-plugin</groupId>' pom.xml && egrep -qs '<artifactId>maven-license-plugin</artifactId>' pom.xml
then
    exec mvn license:check -N
fi
