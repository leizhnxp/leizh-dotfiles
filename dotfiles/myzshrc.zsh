
export LANG=en_US.UTF-8

# ref https://gist.github.com/emreberge/1424710, trick bash help in zsh
function help(){
  bash -c "help $@"
}

# my screen -r alias
function scr-r(){

  if [ $# -ne 0 ]; then
    screen -S $1 -X setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK && screen -r $1
  else
    screen -S console -X setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK && screen -r console
  fi
}
