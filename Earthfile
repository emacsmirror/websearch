VERSION 0.8

FROM scratch

USER ubuntu

builder-v3:
    FROM docker.io/xgqt/ci-emacs-tools:latest

    USER root

    RUN apk update  && \
        apk upgrade && \
        apk add curl pre-commit

prepare-v3:
    FROM +builder-v3

    WORKDIR /earthly-build/xgqt-elisp-app-el-fetch

    RUN mkdir -p code/source
    COPY --dir code/source/v3 ./code/source/

    COPY --dir code/integration ./code/

    RUN git config --global --add safe.directory "*"

build-v3:
    FROM +prepare-v3

    RUN make -C code/source/v3 clean && \
        make -C code/source/v3 build

test-v3:
    FROM +build-v3

    RUN make -C code/source/v3 test

lint-v3:
    FROM +prepare-v3

    COPY --dir .git .
    COPY .pre-commit-config.yaml .

    RUN make -C code/source/v3 pre-commit
