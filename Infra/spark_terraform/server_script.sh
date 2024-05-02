#!/bin/bash
sudo apt-get update -y
sudo apt install python3-pip -y
sudo apt-get install python3-venv -y
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install jupyter
sudo apt-get install default-jre -y
sudo apt-get install scala -y
pip install py4j
wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
sudo tar -zxvf spark-3.5.1-bin-hadoop3.tgz
pip install findspark
jupyter notebook --generate-config
mkdir certs
cd certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mycert.key -out mycert.pem -subj "/C=US/ST=FL"
sudo chmod 440 mycert.pem
sudo chmod 440 mycert.key
cd ~/.jupyter
echo "c = get_config()" >> jupyter_notebook_config.py
echo "c.NotebookApp.certfile = u'/home/ubuntu/certs/mycert.pem'" >> jupyter_notebook_config.py
echo "c.NotebookApp.keyfile = u'/home/ubuntu/certs/mycert.key'" >> jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> jupyter_notebook_config.py
if [ $? -ne 0 ]; then
  echo "Error occurred during script execution!" >&2
  exit 1
fi

echo "Script completed successfully!"
exit 0

# Capture output and errors to a log file
2>&1 >> /var/log/userdata.log
