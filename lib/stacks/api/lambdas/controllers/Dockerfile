FROM public.ecr.aws/lambda/python:3.12@sha256:92c88c1adc374b073b07b12bd4045497af7da68230d47c2b330423115c5850dc

LABEL IsArtifexImage=true

RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -U pip
COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -r requirements.txt
COPY . ${LAMBDA_TASK_ROOT}
