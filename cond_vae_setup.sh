#!/bin/bash
env_name='cond_vae'

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
    if nvidia-smi | grep 'CUDA Version: 11.7'; then
        env_postfix='_cu11.7'
    elif nvidia-smi | grep 'CUDA Version: 11.[89]' || nvidia-smi | grep 'CUDA Version: 1[23456789]'; then
        env_postfix='_cu11.8'
    else
        env_postfix='_cpu'
    fi
else
    env_postfix='_cpu'
fi


conda create -n ${env_name}
command ${install_method} env update -n ${env_name} --file yml/${env_name}${env_postfix}${platform_postfix}.yml
