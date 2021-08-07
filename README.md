# JupyterHub with Code-Server (Code-Hub)

## At First (Intro)

This idea comes from [Nils Braun](https://github.com/nils-braun)'s [Article](https://nils-braun.medium.com/deploying-a-free-multi-user-browser-only-ide-in-just-a-few-minutes-d891f803224b) and [repo](https://github.com/nils-braun/codehub), where he intergrating the JupyterHub and Code-Server via the `KubeSpawner`. His idea enlighted me that I can a kind of tunnel between JupyterHub and Code-Server.

Code-Hub, is a intergrated web application for USBC cluster, which allows user to upload, modify and delete files, 
also submit, hold, kill SLURM jobs. Which decrease the dependence of prior knowledge in Linux and HPC. The goal of this web application is to form a cohesive set of tools that enable:
* environment management
* monitoring the cluster status/usage
* scaleable and efficient computation
* secure user information and data

To achive these goal, here is the tools and extension we use:
* [Jupyter](https://github.com/jupyter/jupyter)==1.0.0
* [JupyterLab](https://github.com/jupyterlab/jupyterlab)==3.0.16
* [JupyterHub](https://github.com/jupyterhub/jupyterhub)=1.4.2
* [Jupyterlab-SLURM](https://github.com/NERSC/jupyterlab-slurm/tree/lab3) branch `lab3`
* [batchspawner](https://github.com/jupyterhub/batchspawner) with [modification](https://github.com/Bayes-Cluster/batchspawner)
* [Code-Server](https://github.com/cdr/code-server) with [modification](https://github.com/Bayes-Cluster/code-server) 

Not yet impeletemented:

* Web Login with TOTP/2FA
* noVNC Intergration
* Jump Server & User Audit 

## Installation 

Run the `quick_install.sh` with root privileges (both works in system-wide python and conda environment). For now, the script is only support Ubuntu 18.04 and Ubuntu 20.04


## Rendering:

### Homepage:

<a href="https://sm.ms/image/1tcj4TDWqEX7aM9" target="_blank"><img src="https://i.loli.net/2021/08/01/3bz5hi6jQBaOHEc.jpg" width="80%" /></a>

### Spawner Option:

<a href="https://sm.ms/image/1tcj4TDWqEX7aM9" target="_blank"><img src="https://i.loli.net/2021/08/01/V3W9ouBheRtJv2X.jpg" width="80%" /></a>

### Cluster Monitor:

<a href="https://sm.ms/image/1tcj4TDWqEX7aM9" target="_blank"><img src="https://i.loli.net/2021/08/01/WR8xCp1qJciYr54.jpg" width="80%" /></a>

### JupyterLab and Code-Server:

<a href="https://sm.ms/image/1tcj4TDWqEX7aM9" target="_blank"><img src="https://i.loli.net/2021/07/18/1tcj4TDWqEX7aM9.gif" width="80%" /></a>


## References

- [jupyterlab-docker](https://github.com/mikebirdgeneau/jupyterlab-docker)
- [vscode-binder](https://github.com/betatim/vscode-binder)
- [jupyterlab-vscode](https://github.com/jrderuiter/jupyterlab-vscode)
- [codehub](https://github.com/nils-braun/codehub)
