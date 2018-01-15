#!/bin/bash

function java_A {
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz -P /opt/download
  tar -xzf /opt/download/jdk-8u151-linux-x64.tar.gz -C /opt/
  alternatives --install /usr/bin/java java /opt/jdk1.8.0_151/bin/java 2
  alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_151/bin/jar 2
  alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_151/bin/javac 2
  alternatives --set java /opt/jdk1.8.0_151/bin/jar
  alternatives --set jar /opt/jdk1.8.0_151/bin/jar
  alternatives --set javac /opt/jdk1.8.0_151/bin/javac
  export JAVA_HOME=/opt/jdk1.8.0_151
  export JRE_HOME=/opt/jdk1.8.0_151/jre
  export PATH=$PATH:/opt/jdk1.8.0_151/bin:/opt/jdk1.8.0_151/jre/bin
  export PATH=/opt/jdk1.8.0_151/bin:$PATH
}


function java_B {
  wget https://www.dropbox.com/s/mfbip7alldh9f5x/jdk-7u80-linux-x64.tar.gz?dl=1 -P /opt/download
  tar -xzf /opt/download/jdk-7u80-linux-x64.tar.gz?dl=1 -C /opt/
  alternatives --install /usr/bin/java java /opt/jdk1.7.0_80/bin/java 1
  alternatives --install /usr/bin/jar jar /opt/jdk1.7.0_80/bin/jar 1
  alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_80/bin/javac 1
  alternatives --set java /opt/jdk1.7.0_80/bin/java
  alternatives --set jar /opt/jdk1.7.0_80/bin/jar
  alternatives --set javac /opt/jdk1.7.0_80/bin/javac
  export JAVA_HOME=/opt/jdk1.7.0_80
  export JRE_HOME=/opt/jdk1.7.0_80/jre
  export PATH=$PATH:/opt/jdk1.7.0_80/bin:/opt/jdk1.7.0_80/jre/bin
  export PATH=/opt/jdk1.7.0_80/bin:$PATH

}

function tomcat {
	wget http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz -P /opt/download
	tar -xzvf /opt/download/apache-tomcat-8.0.23.tar.gz -C /opt/
  sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
  sudo firewall-cmd --reload
	/opt/apache-tomcat-8.0.23/bin/startup.sh
}


installs='Java Switch Tomcat Uninstall Quit'
PS3='Select options : '


select install in $installs
do
  if [[ $install == 'Quit' ]]; then
    break

elif [[ $install == 'Java' ]]; then
      echo "1) Java 7             2) Java 8"
      read -p "What Java Version you want to install ? : " jversion
        if [[ $jversion -eq 1 ]]; then
          if [[ -f /opt/jdk1.7.0_80/bin/java || -f /opt/jdk1.8.0_151/bin/java ]]; then
            echo "Java 7  is already installed"
            java -version
          else
          java_B
            echo "Please wait a while installing Java 7"
        fi
        fi

        if [[ $jversion -eq 2 ]]; then
          if [[ -f /opt/jdk1.8.0_151/bin/java || -f /opt/jdk1.7.0_80/bin/java ]]; then
            echo "Java 8 is already installed"
            java -version
          else
          java_A
            echo "Please wait while installing Java 8"
        fi
        fi

elif [[ $install == 'Tomcat' ]]; then
        if [[ -f /opt/apache-tomcat-8.0.23/bin/version.sh ]]; then
        echo "Tomcat is already installed"
        else
          tomcat
            echo "Please wait a while installing Tomcat"
        fi
elif [[ $install == 'Switch' ]]; then
    echo "1) Java 7             2) Java 8"
    read -p "What Java Version you want to switch ? : " jsversion
    if [[ $jsversion -eq 1 ]]; then
      export JAVA_HOME=/opt/jdk1.7.0_80
      export JRE_HOME=/opt/jdk1.7.0_80/jre
      export PATH=$PATH:/opt/jdk1.7.0_80/bin:/opt/jdk1.7.0_80/jre/bin
      export PATH=/opt/jdk1.7.0_80/bin:$PATH
      java -version
    fi
    if [[ $jsversion -eq 2 ]]; then
      export JAVA_HOME=/opt/jdk1.8.0_151
      export JRE_HOME=/opt/jdk1.8.0_151/jre
      export PATH=$PATH:/opt/jdk1.8.0_151/bin:/opt/jdk1.8.0_151/jre/bin
      export PATH=/opt/jdk1.8.0_151/bin:$PATH
      java -version
    fi


elif [[ $install == 'Uninstall' ]]; then
  echo "1) Java 7             2) Java 8"
  echo "3) Tomcat             4) All"

  read -p "What Java Version you want to uninstall ? : " jre
        if [[ $jre -eq 2 ]]; then
            echo "Please wait a while uninstalling Java 7"
            sudo rm -rf /opt/jdk1.7.0_80
            sudo rm -rf /opt/download/jdk-7u80-linux-x64.tar.gz?dl=1
        fi
        if [[ $jre -eq 1 ]]; then
            echo "Please wait while uninstalling Java 8"
            sudo rm -rf /opt/jdk1.8.0_151
            sudo rm -rf /opt/download/jdk-8u151-linux-x64.tar.gz
        fi

        if [[ $jre -eq 3 ]]; then
            echo "Please wait while uninstalling Tomcat"
            rm -rf /opt/apache-tomcat-8.0.23
            rm -rf /opt/download/apache-tomcat-8.0.23.tar.gz
        fi
        if [[ $jre -eq 4 ]]; then
            echo "Please wait while uninstalling all applications"
            rm -rf /opt/apache-tomcat-8.0.23
            rm -rf /opt/download
            sudo rm -rf /opt/jdk1.7.0_80
            sudo rm -rf /opt/jdk1.8.0_151
        fi
fi

echo "
1)Java
2)Ngin
3)Tomcat
4)Uninstall
5)Quit
"
done
echo  "Bye"
