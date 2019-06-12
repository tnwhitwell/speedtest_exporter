DOCKER_REPO=tnwhitwell/speedtest_exporter
IMAGE_NAME=${DOCKER_REPO}:latest

build:
	IMAGE_NAME=${IMAGE_NAME} bash hooks/build

push:
	IMAGE_NAME=${IMAGE_NAME} DOCKER_REPO=${DOCKER_REPO} bash hooks/post_push

pipeline:
	fly -t mine set-pipeline -c concourse/pipelines/update_submodule.yml -p speedtest_exporter

unpause-pipeline:
	fly -t mine unpause-pipeline -p speedtest_exporter
