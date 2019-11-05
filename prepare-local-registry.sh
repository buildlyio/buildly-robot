# Create local registry
docker run -d -p 5000:5000 --restart=always --name registry registry:2

echo "Pulling Buildly Core Docker Image"
docker pull buildly/buildly
docker image tag buildly/buildly localhost:5000/buildly
echo "Pushing Buildly Core image to local registry"
docker push localhost:5000/buildly

echo "Pulling Buildly UI Docker Image"
docker pull buildly/buildly-ui
docker image tag buildly/buildly-ui localhost:5000/buildly-ui
echo "Pushing Buildly UI image to local registry"
docker push localhost:5000/buildly-ui