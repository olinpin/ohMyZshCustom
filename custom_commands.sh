#!/bin/bash
function gs() {
   git status
}

function gc() {
   git commit $1 $2 $3 $4
}

unalias gcm
function gcm() {
    git commit -m $1 $2 $3 $4
}

function gps() {
    git push $1 $2 $3 $4
}

function gpl() {
    git pull $1 $2 $3 $4
}

unalias ga
function ga() {
    git add ${VARIABLE:-.} $2 $3 $4
}

function gch() {
    git checkout $1 $2 $3 $4
}

unalias gb
function gb() {
    git branch $1 $2 $3 $4
}

function gas() {
    git add --all 
    git status
}

function det() {
    docker exec -it $1 $2 $3 $4
}

function gchtime() {
    git commit --amend --no-edit --date=${VARIABLE:-"now"}
}

unalias gbd
function gbd() {
    git branch --merged >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches
}

function grlcs() {
    git reset --soft HEAD^
    git restore -S .
}

function grlc() {
    git reset --soft HEAD^
}

function python() {
    python3 $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function pip() {
    pip3 $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function vim() {
  nvim  $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function v() {
  nvim  $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function dcu() {
  od
  docker-compose up --build $1 $2 $3 $4 $5 $6 $7 $8 $9 
}

function dcud () {
  od
  docker-compose up -d --build $1 $2 $3 $4 $5 $6 $7 $8 $9 
}

function od() {
  PROCESS=docker
  number=$(ps aux | grep -v grep | grep -ci $PROCESS)

  if [ $number -lt 2 ]
  then
    open --background /Applications/Docker.app
    echo "Openning Docker..."
    while [ $(ps aux | grep -v grep | grep -ci $PROCESS) -lt 14 ]
    do
      sleep 1
    done
    sleep 6
  fi
}

function rutvrm () {
  docker-compose exec -T mysql mysql --host=mysql --password=deadbeef --database=vrm_testing < tests/resources/db/schema.sql
  docker-compose exec -T mysql mysql --host=mysql --password=deadbeef --database=vrm_testing < tests/resources/db/seed.sql
}

