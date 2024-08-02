#!/bin/bash
env_name='loraopt'

platform_postfix=''
if [[ "$OSTYPE" == "darwin"* ]]; then
   platform_postfix='_mac'
fi

# Prefer mamba if possible
if command -v mamba; then
    install_method='mamba'
else
    install_method='conda'
fi

if command -v nvidia-smi; then
    #if nvidia-smi | grep 'CUDA Version: 11.[89]' || nvidia-smi | grep 'CUDA Version: 1[23456789]'; then
        # conda-forge only has bitsandbytes for cuda 11.8 and 12.0, and 
        # pytorch-cuda doesn't have a package for 12.0, only having for 12.1.
        # Therefore we can only install using cuda 11.8
    #    env_postfix='_cu11.8'
    #elif nvidia-smi | grep 'CUDA Version: 1[23456789]'; then
    #    env_postfix='_cu12.0'
    #else
    #    env_postfix='_cpu'
    #fi


    if nvidia-smi | grep 'CUDA Version: 11.[89]' || nvidia-smi | grep 'CUDA Version: 12.0'; then
        env_postfix='_cu11.8'
    elif nvidia-smi | grep 'CUDA Version: 12.[123]'; then
        env_postfix='_cu12.1'
    elif nvidia-smi | grep 'CUDA Version: 1[23456789]'; then
        env_postfix='_cu12.4' # UNTESTED
    else
        env_postfix='_cpu'
    fi
else
    env_postfix='_cpu'
fi


conda create -n ${env_name}
command ${install_method} env update -n ${env_name} --file yml/${env_name}${env_postfix}${platform_postfix}.yml


