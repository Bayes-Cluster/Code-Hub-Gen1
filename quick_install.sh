# Define color
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

# Check Root
[[ $(id -u) != 0 ]] && echo -e "\n Please use ${red}root ${none} to run this scirpt ${yellow}~(^_^) ${none}\n" && exit 1

# Check Architecture

sys_bit=$(uname -m)
ARCH = "unkown"
case $sys_bit in
'amd64' | x86_64)
	ARCH="amd64"
	;;
*)
	echo -e " 
	This ${red} script ${none} cannot run on your architecture, only for amd64
	" && exit 1
	;;
esac

# Check System
awk -F= '/^NAME/{print $2}' /etc/os-release
if awk != "Ubuntu"; then
    echo -e "UBUNTU Only"
    && exit 1
fi

echo "------------------------------------------"
echo "|install some preliminary system packages|"
echo "------------------------------------------"
sleep 3s && clear
apt-get update
apt-get install -y apt-transport-https lsb-release curl gnupg git wget
apt-get clean
clear

echo "-------------------------------------"
echo "|install python preliminary pacakges|"
echo "-------------------------------------"
sleep 3s && clear
pip install jupyter==1.0.0 ipywidgets==7.4.2 jupyterlab==3.0.16 tornado==6.1 \
&& jupyter nbextension enable --py widgetsnbextension \
&& jupyter serverextension enable --py jupyterlab
clear

echo "-------------------------"
echo "|install nodejs_12 & npm|"
echo "-------------------------"
sleep 3s && clear
VERSION=node_12.x && DISTRO="$(lsb_release -s -c)" \
    && curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
    && echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list \
    && echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get clean

echo "--------------------------------"
echo "|install cofigurable-http-proxy|"
echo "--------------------------------"
sleep 3s && clear
npm install -g configurable-http-proxy

echo "--------------------"
echo "|install jupyterhub|"
echo "--------------------"
sleep 3s && clear
pip install jupyterhub

echo "------------------------"
echo "|install VS Code Server|"
echo "------------------------"
sleep 3s && clear
wget https://github.com/Bayes-Cluster/code-server/releases/download/U3.11.1/code-server_3.11.1_amd64.deb
dpkg -i code-server_3.11.0_amd64.deb
rm -rf code-server_3.11.0_amd64.deb

echo "-----------------------"
echo "|install VS Code Prosy|"
echo "-----------------------"
sleep 3s && clear
jupyter labextension install @jupyterlab/server-proxy
git clone https://github.com/Bayes-Cluster/Code-Hub.git
cd Code-Hub && pip install jupyter-vscode-proxy && cd ..
echo "------------------------"
echo "| default configuration|"
echo "------------------------"
sleep 3s && clear
pip install https://github.com/NERSC/jupyterlab-slurm/archive/refs/heads/lab3.zip
pip install https://github.com/Bayes-Cluster/Code-Hub/archive/refs/heads/main.zip
pip install jupyterlab-git

mkdir /etc/jupyterhub/ && cp config_hub && cp Code-Hub/config_file/jhub_config.py /etc/jupyterhub/config.py
sleep 1s && clear

echo "----------------------------------------------------------"
echo "| The JupyterHub Config is in /etc/jupyterhub/config.py   |"
echo "| Please customize it according to your own situation.    |"
echo "| If any question or comment, issues aare always welcome  |"
echo "-----------------------------------------------------------"
