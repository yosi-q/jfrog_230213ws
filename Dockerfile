ARG PYTHON_VERSION=3.10.5
ARG PYTHON_LIB=/usr/local/lib/python3.10/site-packages

FROM python:${PYTHON_VERSION}-slim as builder

ARG JFROG_USER
ARG JFROG_TOKEN
ARG JFROG_INSTANCE

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --index-url https://${JFROG_USER}:${JFROG_TOKEN}@${JFROG_INSTANCE}.jfrog.io/artifactory/api/pypi/sample-pypi/simple -r requirements.txt 
RUN pip install --index-url https://${JFROG_USER}:${JFROG_TOKEN}@${JFROG_INSTANCE}.jfrog.io/artifactory/api/pypi/sample-pypi/simple jfrogsample-hello



FROM python:${PYTHON_VERSION}-slim

WORKDIR /app
COPY --from=builder ${PYTHON_LIB} ${PYTHON_LIB}/
COPY --from=builder /app /app/

# Command to run
ENTRYPOINT ["python","-m","hello"]