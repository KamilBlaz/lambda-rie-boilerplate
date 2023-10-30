
ARG RUNTIME_LANG
ARG RUNTIME_VERSION

FROM public.ecr.aws/lambda/${RUNTIME_LANG}:${RUNTIME_VERSION}

RUN yum upgrade -y \
    && yum groupinstall "Development Tools" -y \
    && yum -y install \
    wget \
    tar \
    xz \
    && yum clean all


RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && source ${HOME}/.cargo/env \
    && cargo install watchexec-cli \
    && mv ${HOME}/.cargo/bin/watchexec /usr/local/bin/watchexec

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

ENV POETRY_VERSION=1.4.1
RUN pip install --no-cache-dir  "poetry==${POETRY_VERSION}"

WORKDIR ${LAMBDA_TASK_ROOT}

COPY ../poetry.lock pyproject.toml ${LAMBDA_TASK_ROOT}/

RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root \
    && poetry config virtualenvs.create true

COPY ../entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "lambda/handlers.handler" ]
