
ARG RUNTIME_LANG
ARG RUNTIME_VERSION
FROM public.ecr.aws/lambda/${RUNTIME_LANG}:${RUNTIME_VERSION} as build

RUN yum upgrade -y \
    && yum groupinstall "Development Tools" -y \
    && yum -y install wget tar xz \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && source ${HOME}/.cargo/env \
    && cargo install watchexec-cli \
    && mv ${HOME}/.cargo/bin/watchexec /usr/local/bin/watchexec

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Install Poetry
ENV POETRY_VERSION=1.4.1
RUN pip install --no-cache-dir "poetry==${POETRY_VERSION}"

# Set working directory
WORKDIR ${LAMBDA_TASK_ROOT}

# Copy poetry.lock and pyproject.toml
COPY ../poetry.lock pyproject.toml ${LAMBDA_TASK_ROOT}/

# Install Python dependencies without creating a virtual environment
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root \
    && poetry config virtualenvs.create true

# Stage 2: Runtime Environment
FROM public.ecr.aws/lambda/${RUNTIME_LANG}:${RUNTIME_VERSION}

# Copy only the necessary files from the build stage
COPY --from=build ${LAMBDA_TASK_ROOT} ${LAMBDA_TASK_ROOT}
COPY --from=build /usr/local/bin/watchexec /usr/local/bin/watchexec

# Copy the entrypoint script and make it executable
COPY ../entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint and command
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "lambda/handlers.handler" ]
