FROM python:3.7-slim

ENV LANG=C.UTF-8

# Install some basic utilities. (Change debain sourse list to https://mirrors.bfsue.du.cn)
RUN sed -i 's/deb.debian.org/mirrors.bfsu.edu.cn/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y apt-transport-https lsb-release curl gnupg git \
    && apt-get clean

# Change pypi Mirrors tu https://mirrors.bfsu.edu.cn
RUN pip install pip -U
RUN pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple

# Install Jupyter
RUN pip install jupyter==1.0.0 ipywidgets==7.4.2 jupyterlab==0.35.4 tornado==6.1 \
    && jupyter nbextension enable --py widgetsnbextension \
    && jupyter serverextension enable --py jupyterlab

# Install a recent version of nodejs (required for proxy extension).
RUN VERSION=node_11.x && DISTRO="$(lsb_release -s -c)" \
    && curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
    && echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list \
    && echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get clean

# Change npm source to Aliyun
RUN npm config set registry https://registry.npm.taobao.org 
RUN npm install -g configurable-http-proxy

## Install JupyterHub
RUN pip install jupyterhub==1.4.2

# Install proxy extension.
RUN pip install jupyter-server-proxy==1.0.1 \
    && jupyter serverextension enable --py jupyter_server_proxy \
    && jupyter labextension install jupyterlab-server-proxy \
    && jupyter lab build

# Download and install VS Code server
# NOTICE: github.com.cnpmjs.org is a reverse proxy for acclerate the release download
RUN curl -L -O https://github.com.cnpmjs.org/cdr/code-server/releases/download/v3.11.0/code-server-3.11.0-linux-amd64.tar.gz \
    && tar xzf code-server-3.11.0-linux-amd64.tar.gz  \
    && cp code-server-3.11.0-linux-amd64/code-server /usr/local/bin/code-server \
    && rm -rf code-server-3.11.0-linux-amd64.tar.gz \
    && rm -rf code-server-3.11.0-linux-amd64/

# Install the VS code proxy.
COPY jupyter-vscode-proxy /etc/jupyter-vscode-proxy
RUN pip install /etc/jupyter-vscode-proxy

EXPOSE 8888

# Initionalization
RUN mkdir -p /work
WORKDIR /work
RUN cd /work \
    && jupyterhub --generate-config

# JupyterHub / JupyterLab (ENTRYPOINT ["jupyter", "lab"] && CMD ["--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"])
ENTRYPOINT ["jupyter", "lab"]
CMD ["--port=8888", "--ip=0.0.0.0", "--allow-root"]
