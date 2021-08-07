# BASIC CONFIG
#------------------------------------------------------------------------------
import batchspawner
c = get_config()
c.JupyterHub.concurrent_spawn_limit = 50
c.JupyterHub.active_server_limit = 50
c.JupyterHub.admin_users = ['{{ADMIN NAME}}']
c.JupyterHub.cookie_max_age_days = 0.1
c.JupyterHub.cleanup_servers = True
c.JupyterHub.concurrent_spawn_limit = 50
c.JupyterHub.named_server_limit_per_user = 2
c.JupyterHub.base_url = '/'

c.Spawner.cpu_limit=1
c.Spawner.mem_limit="1M"
c.JupyterHub.hub_ip = '{{IP ADDR}}'
c.JupyterHub.hub_bind_url = '{{BIND URL}}'
c.ConfigurableHTTPProxy.api_url = '{{API URL}}'
c.Spawner.default_url = "/lab"
c.JupyterHub.spawner_class = 'wrapspawner.ProfilesSpawner'
c.Spawner.ip = '{{IP ADDR}}'
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

module add anaconda3/3.5.1
conda activate {condaenv}
{cmd}
'''
c.ProfilesSpawner.profiles = [
     ("Control Node", 'local', 'jupyterhub.spawner.LocalProcessSpawner', {'ip':'0.0.0.0'}),
     ('GPU Node [1]', 'GPU NODE', 'batchspawner.SlurmSpawner', dict(req_partition='{{PARTITION NAME}}', req_nprocs='2', req_runtime='00:30:00', req_memory='4196M', req_condaenv="{{CONDA ENV NAME}}")),
]
