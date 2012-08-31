#!/bin/sh

#
# Run mvn license:check -N on the current project
# Only executes license check if:
# - project is a Maven project ( has a pom.xml in root )
# - pom.xml contains a reference to maven-license-plugin
#

missingHeaders() {
    mvn license:check -N | grep "Missing header in:"
    return $?
}

if egrep -qs '<groupId>com.mycila.maven-license-plugin</groupId>' pom.xml && egrep -qs '<artifactId>maven-license-plugin</artifactId>' pom.xml
then
    if missingHeaders
    then
	if [ -e /dev/tty ]
	then
	    exec < /dev/tty

	    echo "Missing license headers found! Should we run license:format? (y/n)"
	    read check
	    if [ "$check" = "y" ]
	    then
		mvn license:format -N
		if missingHeaders
		then
		    return 1
		fi
	    fi
	else
	    echo -e "Missing license headers found! Run\n  mvn license:format -N\nto add headers."
	fi

	return 1
    fi

fi
