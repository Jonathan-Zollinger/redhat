FROM jzollinger/baseline-workstation:rubi8

# Do all yum installs
RUN yum install -y golang 

RUN eval $(go env | sed 's/^/export /'); mkdir -p "$GOPATH/src" "$GOPATH/bin"
RUN eval $(go env | sed 's/^/export /'); echo -e "GOPATH current value is '${GOPATH}'"; chmod -R 777 "${GOPATH}"

WORKDIR /root/

RUN go install -v golang.org/x/tools/gopls@latest
RUN go install -v github.com/go-delve/delve/cmd/dlv@latest
RUN go install -v github.com/cweill/gotests/...@latest
RUN go install -v github.com/josharian/impl@latest
RUN go install -v gotest.tools/gotestsum@latest
RUN go install -v github.com/koron/iferr@latest

RUN echo -e "finished installing $(go version)"

CMD "/bin/bash"
