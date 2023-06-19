# playground
Many smol projects


## Configuration

We have one separate environment for each project to keep it easier, so please read the configuration section on each of the notebooks themselves. But we'll try to keep the general configuration procedure consistent as below.

### Environments

We use [miniconda](https://docs.conda.io/en/latest/miniconda.html) (and we recommend also having [mamba](https://mamba.readthedocs.io/en/latest/installation.html#installation)) to setup our environments here and we have only tested this way. If you want to install the packages through pip you are on your own.

We try to provide a simple linux setup script that checks your system for GPU and CUDA versions using `nvidia-smi`, (re-)creates the environment using `conda`, and installs the packages according to your system using either `mamba` or `conda`. To use this script to setup your environment, you only need to run the code below changing `env_name` to the name of the notebook you want to run:
```sh
chmod a+x env_name.sh
./env_name.sh
```
And then [add the environment's kernel to your jupyter notebook](https://arshren.medium.com/how-to-setup-conda-environments-and-add-kernels-for-jupyter-notebook-f2ebf968a409) in case your notebook engine doesn't find it automatically:
```sh
conda activate env_name
python -m ipykernel install --user --name=env_name --display-name "env_name"
conda deactivate
jupyter notebook
```

Note that we may only have tested our environment with a specific configuration, so if you find any problems with other setups feel free to raise an issue.

We try to make our `.yml` files contain major and minor versions for libraries, with debug versions for some of them. If you can't find a combination for your system, try [relaxing the versions](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#create-env-file-manually). However, it might be possible that our notebooks won't work with some of the relaxed versions.