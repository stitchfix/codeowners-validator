# Get latest CA certs & git
FROM ubuntu:18.04 as deps

RUN apt update
RUN apt install -y git

FROM scratch

LABEL source=https://github.com/stitchfix/codeowners-validator.git

COPY ./bin/codeowners-validator /codeowners-validator

COPY --from=deps /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=deps /usr/bin/git /usr/bin/git
COPY --from=deps /usr/bin/xargs  /usr/bin/xargs
COPY --from=deps /lib /lib
COPY --from=deps /usr/lib /usr/lib
COPY --from=deps /usr/bin/tail /usr/bin/tail

CMD ["/codeowners-validator"]
