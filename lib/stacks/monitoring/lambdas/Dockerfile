FROM public.ecr.aws/lambda/python:3.13@sha256:f5b51b377b80bd303fe8055084e2763336ea8920d12955b23ef8cb99dda56112

LABEL IsArtifexImage=true

RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -U pip
COPY . ${LAMBDA_TASK_ROOT}
RUN --mount=type=secret,id=pipconf PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -r requirements.txt
