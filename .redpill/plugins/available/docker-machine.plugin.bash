cite about-plugin
about-plugin 'Helpers to get Docker setup correctly for docker-machine'

[ -z ${REDPILL_DOCKER_MACHINE+x} ] && REDPILL_DOCKER_MACHINE='dev'

# Note, this might need to be different if you use a machine other than 'dev'
if [[ `uname -s` == "Darwin" ]]; then
  # check if dev machine is running
  docker-machine ls | grep --quiet "$REDPILL_DOCKER_MACHINE.*Running"
  if [[ "$?" = "0" ]]; then
    eval "$(docker-machine env $REDPILL_DOCKER_MACHINE)"
  fi
fi
