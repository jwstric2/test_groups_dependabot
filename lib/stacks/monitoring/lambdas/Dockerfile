FROM public.ecr.aws/lambda/python:3.13@sha256:63811c90432ba7a9e4de4fe1e9797a48dae0762f1d56cb68636c3d0a7239ff68

LABEL IsArtifexImage=true

RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -U pip
COPY . ${LAMBDA_TASK_ROOT}
RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -r requirements.txt
