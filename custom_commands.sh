#!/bin/bash
alias gs="git status"

alias gc="git commit"

unalias gcm 2>/dev/null
alias gcm="git commit -m"

alias gps="git push"

alias gpl="git pull"

unalias ga 2>/dev/null
alias ga="git add"

alias gch="git checkout"

function gas() {
    git add --all 
    git status
}

alias det="docker exec -it"

function gchtime() {
    git commit --amend --no-edit --date=${VARIABLE:-"now"}
}

unalias gbd 2>/dev/null
function gbd() {
    git branch --merged >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches
}

function grlcs() {
    git reset --soft HEAD^
    git restore -S .
}

alias grlc="git reset --soft HEAD^"

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
    while [ $(ps aux | grep -v grep | grep -ci $PROCESS) -lt 2 ]
    do
      sleep 1
    done
    sleep 3
  fi
}

function rutvrm () {
  docker-compose exec -T mysql mysql --host=mysql --password=deadbeef --database=vrm_testing < tests/resources/db/schema.sql
  docker-compose exec -T mysql mysql --host=mysql --password=deadbeef --database=vrm_testing < tests/resources/db/seed.sql
}

alias yas="yarn serve"

alias yai="yarn install"

function kfpa() {
  kubectl port-forward -n acceptance svc/victron-mysql-master 3306:3306
}


function kfp() {
  #!/bin/bash
  function pause(){
    echo "$*"
    read
  }

  kubectl port-forward --namespace production svc/mysql-shared 3307:3306 &
  kubectl port-forward --namespace acceptance svc/mysql-shared 3308:3306 &
  kubectl port-forward --namespace dev svc/mysql-shared 3309:3306 &
  sleep 2
  pause 'Press [Enter] key to stop the port forwards...'
  pkill -9 kubectl
}

function cmpl() {
  file=$1
  result=${file%%.*}
  gcc -ggdb -o $result $file
}

function cmple() {
  file=$1
  result=${file%%.*}
  gcc -ggdb -o $result $file
  ./$result
}

function ccd() {
  pwd | pbcopy
}

alias tat="tmux attach -t"

alias t="tmux"

alias tls="tmux ls"

function ip() {
  dig +short myip.opendns.com @resolver1.opendns.com
}

private function get_ip_sha1_hash() {
  if [[ -z $1 ]];
  then
    echo "Include string"
  else
    input_string=$1;
  fi;


  hash=$(echo -n "$input_string" | shasum -a 1 | awk '{print $1}')

  echo $hash
}

function delratelimit() {
  ssh vrm "redis-cli -n 5 KEYS ratelimit_$(get_ip_sha1_hash $(ip))_* | xargs redis-cli -n 5 DEL" && ssh vrm "redis-cli -n 4 KEYS ratelimit_$(get_ip_sha1_hash $(ip))_* | xargs redis-cli -n 4 DEL"
}

function gollum() {
  /opt/homebrew/lib/ruby/gems/3.2.0/bin/gollum
}

function dbar() {
  od
  name=$1
  docker build -t name .
  docker run $1
}


function cmr() {
  if [[ "$*" == "--draft" ]]
  then
    draft="--draft"
  else
    draft=""
  fi

  if [[ $1 =~ .*",".* ]]; then 
    reviewers=$1;
  else
    echo "Needs at least two reviewers, only assigned"
    return
  fi;

  current_branch=$(git branch --show-current)
  if [[ $current_branch == "master" ]] || [[  $current_branch == "beta" ]] || [[ $current_branch == "acceptance" ]] || [[ $current_branch == "main" ]] || [[ $current_branch == "release" ]] ;
    then echo "Checkout a feature branch" && return;
  fi;

    # Check if 'main' branch exists in the remote repository
  current_project=$(basename $(pwd))

  if [[ ! -z $2 ]]; then
    target_branch=$2
  elif [[ $current_project =~ "vrm-(front|api)" ]]; then
    target_branch="release"
  else
    target_branch="master"
  fi

  glab mr create -a oliver --reviewer=$reviewers --target-branch=$target_branch -t "Merge branch: '$(git branch --show-current)' into $target_branch" $draft
}


function branchname() {
  if [[ -z $1 ]];
  then
    echo "No issue number supplied"
  fi;
  project=$(basename $(pwd))
  issue_project=$(echo $project | sed 's/api/front/')
  id=$1
  if [[ -z $2 ]];
  then
    >&2 echo "No branch supplied, using issue title"
    url="https://gitlab.elnino.tech/elnino/snooze/$issue_project/-/issues/$id"
    title=$(glab issue view $url);
    title=$(echo $title | sed -n '1 p' | sed 's/title://' | sed 's/^[[:space:]] *//g' | sed -e 's/ /-/g' | sed -e 's/\[//g' | sed -e 's/\]//g' )
  fi;

  if [[ ! -z $2 ]];
  then 
    branchname="$2"
  else
    branchname="$issue_project#$id-$title"
  fi;
  echo $branchname
}


function gbi() {
  current_branch=$(git branch --show-current)
  if [[ $current_branch != "master" ]];
    then echo "Checkout master" && return;
  fi;
  if [[ -z $1 ]];
  then
    echo "No issue number supplied"
    return 1
  fi;

  newbranch=$(branchname $1 $2)
  git switch -c $newbranch
}


unalias gl 2>/dev/null
alias gl="glab"

alias glci="glab ci view"
