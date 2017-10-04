#!/bin/bash

# print help
help(){
  echo
  echo "Enter commands by typing the numbers sepparated with single space."
  echo
  echo "Supported commands list: "
  echo "1 => perform environment initialization for hammerhead"
  echo "2 => perform environment initialization for bullhead"
  echo "3 => build lockscreen and update system image"
  echo "4 => build ArielOS platform code"
  echo "5 => build ArielOS sdk"
  echo "6 => clean ariel platform"
  echo "7 => sync platform code with device"
  echo "8 => re-create system image (snod)"
  echo
}

# perform initialization of environment
init-hammerhead(){
   echo "Initializing environment..."
   echo "***************************"
   . build/envsetup.sh && export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 && lunch aosp_hammerhead-userdebug
   echo "***************************"
   echo "Environment initialization done"
}

init-bullhead(){
   echo "Initializing environment..."
   echo "***************************"
   . build/envsetup.sh && export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 && lunch aosp_bullhead-userdebug
   echo "***************************"
   echo "Environment initialization done"
}

# build losckreen and snod
lockscreen(){
   make Keyguard && make SystemUI
}

# build arielplatform and snod
arielplatform(){
   make com.ariel.platform && make com.ariel.platform.internal
}

# clean arielplatform
cleanarielplatform(){
   make clean-com.ariel.platform && make clean-com.ariel.platform.internal
}

# build arielsdk and snod
arielsdk(){
   make com.ariel.platform.sdk && make com.ariel.platform.sdk.aar
}

# sync build with device
sync(){
   adb root && adb remount && adb sync && adb remount && adb reboot
}

# rebuild system image
snod(){
   make snod
}

# if no command line arg given
# print error message

# if [ -z $1 ]
# then
#   command="*** Unknown command ***"
# elif [ -n $1 ]
# then
#   # otherwise make first arg as a command
#   command=$1
# fi
eval help

echo -n "Enter your commands and then press ENTER: "
read commands
echo "You selected: $commands"

for var in $commands
do
  case $var in
     "1") eval init-hammerhead;;
     "2") eval init-bullhead;;
     "3") eval lockscreen;;
     "4") eval arielplatform;;
     "5") eval arielsdk;;
     "6") eval cleanarielplatform;;
     "7") eval sync;;
     "8") eval snod;;
     *) echo "$var";;
  esac
done

# use case statement to make decision for rental
# case $command in
#    "init") eval init;;
#    "lockscreen") eval lockscreen;;
#    "arielplatform") eval arielplatform;;
#    "arielsdk") eval arielsdk;;
#    "help") eval help;;
#    "sync") eval sync;;
#    *) echo "$command";;
# esac
