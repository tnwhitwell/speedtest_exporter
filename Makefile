DOCKER_REPO=tnwhitwell/speedtest_exporter
IMAGE_NAME=${DOCKER_REPO}:latest

build:
	IMAGE_NAME=${IMAGE_NAME} bash hooks/build

push:
	IMAGE_NAME=${IMAGE_NAME} DOCKER_REPO=${DOCKER_REPO} bash hooks/post_push

update-pipeline:
	fly -t mine set-pipeline -c concourse/pipelines/update_submodule.yml -p speedtest_exporter

run-pipeline:
	fly -t mine trigger-job -j speedtest_exporter/update_submodule
