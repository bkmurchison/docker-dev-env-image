FROM alpine:3.23.2

ENV TERRAFORM_VERSION=1.5.7 \
    OPENTOFU_VERSION=1.11.1 \
    PYTHON_VERSION=3.12.12 \
    KUBCTL_VERSION=1.34.3 \
    ANSIBLE_VERSION=2.20.0 \
    GOLANG_VERSION=1.25.4 \
    PIPX_BIN_DIR=/usr/local/bin

RUN apk add --no-cache \
    curl \
    bash \
    git  \
    wget \
    unzip \
    make \
    build-base \
    py3-pip \
    pipx \
    openssh-client \
    gnupg \
    libc6-compat

RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

RUN wget -O tofu.zip https://github.com/opentofu/opentofu/releases/download/v${OPENTOFU_VERSION}/tofu_${OPENTOFU_VERSION}_linux_amd64.zip && \
    unzip tofu.zip && \
    mv tofu /usr/local/bin/ && \
    rm tofu.zip

RUN curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN pipx install ansible-core==${ANSIBLE_VERSION}

RUN wget https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go$GOLANG_VERSION.linux-amd64.tar.gz && \
    rm go$GOLANG_VERSION.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

WORKDIR /workspace

CMD ["bash"]
