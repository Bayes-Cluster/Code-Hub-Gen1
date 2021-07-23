apt-get update

echo "------------------------------------------"
echo "|install some preliminary system packages|"
echo "------------------------------------------"
apt-get install -y apt-transport-https lsb-release curl gnupg git wget
apt-get clean

echo "-------------------------------------"
echo "|install python preliminary pacakges|"
echo "-------------------------------------"
pip install jupyter==1.0.0 ipywidgets==7.4.2 jupyterlab==3.0.16 tornado==6.1 \
&& jupyter nbextension enable --py widgetsnbextension \
&& jupyter serverextension enable --py jupyterlab

echo "-------------------------"
echo "|install nodejs_12 & npm|"
echo "-------------------------"
VERSION=node_12.x && DISTRO="$(lsb_release -s -c)" \
    && curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
    && echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list \
    && echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get clean

npm config set registry https://registry.npm.taobao.org 
npm install -g configurable-http-proxy

echo "--------------------"
echo "|install jupyterhub|"
echo "--------------------"
pip install jupyterhub

echo "------------------------"
echo "|install VS Code Server|"
echo "------------------------"
wget https://github.com.cnpmjs.org/cdr/code-server/releases/download/v3.11.0/code-server_3.11.0_amd64.deb
RUN dpkg -i code-server_3.11.0_amd64.deb
RUN rm -rf code-server_3.11.0_amd64.deb

echo "-----------------------"
echo "|install VS Code Prosy|"
echo "-----------------------"
jupyter labextension install @jupyterlab/server-proxy
jupyter-vscode-proxy/ /etc/jupyter-vscode-proxy
pip install /etc/jupyter-vscode-proxy
jupyter serverextension enable --py jupyter_server_proxy
jupyter labextension install jupyterlab-server-proxy
