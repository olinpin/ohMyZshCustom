#!/bin/bash
function gs() {
   git status
}

function gc() {
   git commit $1 $2 $3 $4
}

unalias gcm 2>/dev/null
function gcm() {
    git commit -m $1 $2 $3 $4
}

function gps() {
    git push $1 $2 $3 $4
}

function gpl() {
    git pull $1 $2 $3 $4
}

unalias ga 2>/dev/null
function ga() {
    git add $1 $2 $3 $4
}

function gch() {
    git checkout $1 $2 $3 $4
}
unalias gb 2>/dev/null
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

unalias gbd 2>/dev/null
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

function yas () {
  yarn serve $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function yai () {
  yarn install $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function cds() {
  cd $1 && ls
}

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

function tat() {
  tmux attach -t $1
}

function t() {
  tmux
}

function tls() {
  tmux ls
}

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

