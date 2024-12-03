FROM public.ecr.aws/docker/library/python:3.12-bookworm@sha256:b6cffb3fd45a309ad4b224ffb3f0db1bda5171de9398dcc708e5d841f87bc74e

LABEL IsArtifexImage=true

RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf pip install -U pip
COPY requirements.txt .
RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf pip install -r requirements.txt
COPY . .
