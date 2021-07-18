# JupyterHub with Code-Server (Code-Hub)

## At First

This idea comes from [Nils Braun](https://github.com/nils-braun)'s [Article](https://nils-braun.medium.com/deploying-a-free-multi-user-browser-only-ide-in-just-a-few-minutes-d891f803224b) and [repo](https://github.com/nils-braun/codehub), where he intergrating the JupyterHub and Code-Server via the `KubeSpawner`

His idea enlighted me that I can a kind of tunnel between JupyterHub and Code-Server:

## Installation 

```
docker build -t terenceliu98/codehub .
```

Running the image:

```
docker run --rm -p 8888:8888 terenceliu98/codehub
```

Files/notebooks can be mounted into the `/work` directory, which is the
default working directory for JupyterLab and vscode-server.

## Rendering:

<a href="https://sm.ms/image/1tcj4TDWqEX7aM9" target="_blank"><img src="https://i.loli.net/2021/07/18/1tcj4TDWqEX7aM9.gif" height="400" width="400" /></a>

## References

Based on:

- [jupyterlab-docker](https://github.com/mikebirdgeneau/jupyterlab-docker)
- [vscode-binder](https://github.com/betatim/vscode-binder)
- jupyterlab-vscode(https://github.com/jrderuiter/jupyterlab-vscode)

