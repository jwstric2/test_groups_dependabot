FROM public.ecr.aws/lambda/python:3.13@sha256:5e7e09c5bf735a8e824511117bb0e9f335b778ac2e17a07161ee1542509b98f4

LABEL IsArtifexImage=true

RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -U pip
COPY . ${LAMBDA_TASK_ROOT}
RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -r requirements.txt
