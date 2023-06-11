#!/bin/bash

sudo apt update
sudo apt upgrade -y

# Install Pip
if ( which pip3 < /dev/null )
then 
  echo -e "\n\033[1;32m==== Pip3 is present ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Pip3 ====\033[0m\n"
  sudo apt install -y python3-pip
fi

# Install Python
if ( which python3 > /dev/null )
then 
  echo -e "\n\033[1;32m==== Python3 installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installiong Python3 ====\033[0m\n"
  sudo apt install -y python3 
fi

# Install python3-venv package
if ( dpkg -s python3.10-venv > /dev/null )
then
  echo -e "\n\033[1;32m==== Python3 virtual environment package present ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Python3 virtual environment package ====\033[0m\n"
  sudo apt install -y python3.10-venv
fi

# Set up a virtual environment
if [ -f py3env/bin/python ]
then
  echo -e "\n\033[1;32m==== Python3 virtual environment present ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Creating Python3 virtual environment ====\033[0m\n"
  python3 -m venv py3env
fi

# Activate virtual environment
source py3env/bin/activate

# Install Mlfow
if ( pip freeze | grep -q '^mlflow==' )
then 
  echo -e "\n\033[1;32m==== Mlflow installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Mlflow  ====\033[0m\n"
  pip install mlflow
fi

# Start Mlflow UI
if [ "$(curl -s -o /dev/null -w "%{http_code}" http://pi:5000)" -eq 200 ]
then 
  echo -e "\n\033[1;32m==== Mlflow running ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Starting Mlflow UI ====\033[0m\n"
  nohup mlflow ui --host 0.0.0.0 &
fi
