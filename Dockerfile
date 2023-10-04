FROM nvcr.io/nvidia/pytorch:23.09-py3

RUN apt update && apt upgrade -y

# Install Node.js
RUN apt install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ARG NODE_MAJOR=20
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update && apt install nodejs -y

RUN apt autoremove -y &&\
    apt clean &&\
    rm -rf /usr/local/src/*

# Update jupyterlab
RUN pip install -U pip black isort &&\
    pip install --no-cache-dir --upgrade jupyterlab jupyterlab-language-pack-ja-JP

# Uninstall
RUN pip uninstall --no-cache-dir jupyterlab_tensorboard

# Install extension
RUN pip install --no-cache-dir --upgrade \
jupyterlab_code_formatter \
jlab-enhanced-cell-toolbar \
jupyterlab-lsp \
lckr-jupyterlab-variableinspector \
jupyterlab-nvdashboard