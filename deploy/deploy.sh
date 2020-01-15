set -ev

echo "$TRAVIS_COMMIT" > ./deploy/deploy_hash
echo "$MASTER_KEY" > ./config/master.key

# build and push image
docker build -f Dockerfile.prod -t babywearing.azurecr.io/babywearing:prod .
docker login babywearing.azurecr.io --username $DOCKER_USERNAME --password $DOCKER_PASSWORD
docker push babywearing.azurecr.io/babywearing:prod

# deploy to vm - we set vars below and not just in Travis web ui because they can't be set in build phase above,
# otherwise the image would try to be built on the vm and we do not want that
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="$REMOTE_DOCKER_HOST"
export DOCKER_CERT_PATH="$REMOTE_DOCKER_CERT_PATH"
export DOCKER_MACHINE_NAME="$REMOTE_DOCKER_MACHINE_NAME"
docker stack deploy -c docker-stack.yml babywearing_stage --with-registry-auth

