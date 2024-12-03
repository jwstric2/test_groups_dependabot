FROM public.ecr.aws/docker/library/python:3.12-bookworm@sha256:78409b7acdc408ff1dbdc936e246edcb07bba423581db47399f7db3ecad68852

LABEL IsArtifexImage=true

RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  jq \
  && rm -rf /var/lib/apt/lists/*.

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

ENV NODE_MAJOR=18
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt-get update && apt-get install -y \
  nodejs \
  && rm -rf /var/lib/apt/lists/*.

RUN useradd --create-home vscode

# mkdir -p like this so the VOLUME mount point ends up being owned by the vscode user instead of root
RUN mkdir -p /usr/src/app/node_modules && chown -R vscode:vscode /usr/src/app

USER vscode
WORKDIR /usr/src/app

COPY --chown=vscode:vscode requirements.txt ./
RUN --mount=type=secret,id=pipconf,uid=1000 PIP_CONFIG_FILE=/run/secrets/pipconf python -m pip install -U pip
RUN --mount=type=secret,id=pipconf,uid=1000 PIP_CONFIG_FILE=/run/secrets/pipconf pip install pip-tools
RUN --mount=type=secret,id=pipconf,uid=1000 PIP_CONFIG_FILE=/run/secrets/pipconf pip install -r requirements.txt


COPY --chown=vscode:vscode package.json .
COPY --chown=vscode:vscode package-lock.json .
RUN --mount=type=secret,id=npmrc,uid=1000 NPM_CONFIG_GLOBALCONFIG=/run/secrets/npmrc npm install

COPY --chown=vscode:vscode . .

CMD /bin/bash
