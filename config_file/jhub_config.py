# BASIC CONFIG
#------------------------------------------------------------------------------
c = get_config()
c.JupyterHub.concurrent_spawn_limit = 50
c.JupyterHub.active_server_limit = 50
c.JupyterHub.admin_users = ['terencelau']
c.JupyterHub.cookie_max_age_days = 0.1
c.JupyterHub.cleanup_servers = True
c.JupyterHub.concurrent_spawn_limit = 50
c.JupyterHub.named_server_limit_per_user = 2
c.JupyterHub.base_url = '/'
c.Spawner.cpu_limit=1
c.Spawner.mem_limit="1M"
#c.Spawner.cmd=["jupyter-labhub"]
#c.LocalProcessSpawner.shell_cmd = ["bash", "-l", "-c"]
#c.Spawner.disable_user_config=False
#c.KernelSpecManager.ensure_native_kernel = False
#------------------------------------------------------------------------------

# Spawner Config
#------------------------------------------------------------------------------
import batchspawner
c.JupyterHub.hub_ip = '192.168.50.254'
c.JupyterHub.hub_bind_url = 'http://:8081'
c.ConfigurableHTTPProxy.api_url = 'http://0.0.0.0:8001'
c.Spawner.default_url = "/lab"
c.JupyterHub.spawner_class = 'wrapspawner.ProfilesSpawner'
c.Spawner.ip = '0.0.0.0'
c.Spawner.http_timeout = 300
c.Spawner.start_timeout = 3600
c.SlurmSpawner.batch_script = '''#!/bin/bash
#SBATCH --chdir={homedir}
#SBATCH --output={homedir}/jlab_slurmspawner_%j.log
#SBATCH --partition={partition}
#SBATCH --time={runtime}
#SBATCH --cpus-per-task={nprocs}
#SBATCH --mem={memory}
#SBATCH --gres={gres}
#SBATCH --job-name=jlab-spawner
{cmd}
'''
c.ProfilesSpawner.profiles = [
     ("Control Node", 'local', 'jupyterhub.spawner.LocalProcessSpawner', {'ip':'0.0.0.0'}),
     ('CPU Node [1]', 'CPU-Compute-1', 'batchspawner.SlurmSpawner', dict(req_partition='CPU-Compute-1', req_nprocs='2', req_runtime='00:30:00', req_memory='4196M')),
     ('CPU Node [2]', 'CPU-Compute-2', 'batchspawner.SlurmSpawner', dict(req_partition='CPU-Compute-2', req_nprocs='4', req_runtime='01:00:00', req_memory='8192M')),
     ('GPU Node [x] coming soon', 'GPU-Compute-4', 'batchspawner.SlurmSpawner', dict(req_partition='GPU-Compute-4', req_nprocs='4', req_runtime='01:00:00', req_memory='8192M')),
]