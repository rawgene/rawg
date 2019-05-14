# Demo and User Guide

A demon server for the front-end interface is available [here](http://rawg.tony.tc)
![create a new session](create_session.gif)
![create new conditions](create_conditions.gif)
![add single-end sample](add_sample_sg.gif)
![add paired-end sample](add_sample_pe.gif)
![add workflows](add_workflows.gif)
![submit analysis](submit.gif)

## Appendix
### Command used to set up the demo server

The [demo](http://rawg.tony.tc) is hosted on a DigitalOcean droplet with minimum comuptational resource hence it is only meant to be a demonstration for the front-end interface. This droplet uses Ubuntu 18.04 as base image.  
Here is the history shows commands used to set up the demo server
```
root@rawg:~# history
    1  git clone --recurse-submodules -j3 https://github.com/rawgene/rawg
    2  apt update
    3  apt install graphviz python3-pip
    4  cd rawg/webportal/webportal/
    5  cp settings.py local_settings.py
    6  vim local_settings.py 
    7  cd ../..
    8  pip3 install -r requirements.txt 
    9  cd webportal/
   10  python3 manage.py makemigrations
   11  python3 manage.py migrate
   12  nohup python3 manage.py runserver 0.0.0.0:80 &
```
