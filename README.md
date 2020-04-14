# PlatON-Go-ci

> Build PlatON-Go Image Automatically.

## Install

- Jenkins 2.x
- Jenkins Plugin: `Git plugin` / `Git Parameter` / `Pipeline` / `ansiColor` / `Timestamper` / `buildDescription` / `Build Timeout` / `Blue Ocean`, etc.
- Docker Support

## New Pipeline

- New Pipeline Job.
- Choose `Pipeline script`.
- Copy the contents of the Jenkinsfile to the blank.

## Run

**First Run will be failed due to the parameters.**

Run with the parameters: docker_tag & git branch.

## How to Run the image

```bash
# fast run Archive Node
docker run -d dolphintwo/platon-go:${DOCKER_TAG}

```
