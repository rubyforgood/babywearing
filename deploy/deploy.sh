set -ev

echo "$TRAVIS_COMMIT" > ./deploy/deploy_hash
echo "$MASTER_KEY" > ./config/master.key

# build and push images
docker build -f ./docker/app/Dockerfile.prod -t babywearing.azurecr.io/babywearing:prod .
docker build -f ./docker/web/Dockerfile -t babywearing.azurecr.io/nginx:prod .
docker login babywearing.azurecr.io --username $DOCKER_USERNAME --password $DOCKER_PASSWORD
docker push babywearing.azurecr.io/babywearing:prod
docker push babywearing.azurecr.io/nginx:prod

# deploy to vm - we set vars below and not just in Travis web ui because they can't be set in build phase above,
# otherwise the image would try to be built on the vm and we do not want that
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="$REMOTE_DOCKER_HOST"
export DOCKER_CERT_PATH="$REMOTE_DOCKER_CERT_PATH"
export DOCKER_MACHINE_NAME="$REMOTE_DOCKER_MACHINE_NAME"
docker stack deploy -c ./docker/docker-stack.yml babywearing_stage --with-registry-auth

