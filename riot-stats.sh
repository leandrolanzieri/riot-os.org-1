#!/bin/bash

RIOTCODE="https://github.com/RIOT-OS/RIOT.git"
GITWORKSPACE="_RIOT"

CDIR=`pwd`

gitupdate () {
  if [ -d $GITWORKSPACE ]; then
    cd $GITWORKSPACE
    git pull
  else 
    git clone $RIOTCODE $GITWORKSPACE
  fi
  cd - > /dev/null
}

countboards () {
  cd $GITWORKSPACE
  make info-boards | tr " " "\n" | wc -l | xargs printf "boards: %d\n" 
  cd - > /dev/null
}

countcpus () {
  cd $GITWORKSPACE
  git grep "config CPU_FAM_" | grep "Kconfig" | wc -l | xargs printf "cpus: %d\n"
  cd - > /dev/null
}

countcommits () {
  cd $GITWORKSPACE
  git rev-list --count master | xargs printf "commits: %d\n" 
  cd - > /dev/null
}

contributors () {
  echo
}

gitupdate
countboards
countcpus
countcommits

