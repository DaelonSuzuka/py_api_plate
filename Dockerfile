# app/Dockerfile

FROM python:3.12

WORKDIR /app

# install uv
COPY --from=ghcr.io/astral-sh/uv:0.5.2 /uv /bin/uv
RUN uv venv
ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:$PATH"

# install dependencies
COPY pyproject.toml pyproject.toml
COPY uv.lock uv.lock
RUN uv sync

COPY ./src /app/src

EXPOSE 8080

# dev mode: auto-reload, listens on localhost
CMD ["fastapi", "dev", "src/main.py"]

# run mode: no auto-reload, listens on all interfaces
# CMD ["fastapi", "run", "src/main.py"]