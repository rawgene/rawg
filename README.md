# RAWG: RNA-Seq Analysis Workflow Generator
[![Build Status](https://travis-ci.com/rawgene/cwl.svg?branch=master)](https://travis-ci.com/rawgene/cwl)
[![Gitter](https://badges.gitter.im/rawgene/rawg.svg)](https://gitter.im/rawgene/rawg?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Google group : RAWG](https://img.shields.io/badge/Google%20Group-RAWG-blue.svg)](https://groups.google.com/forum/#!forum/rawgene)

RAWG is born out of a student project at Imperial College London. The aim of this project is to provide an easy and intuitive way for researchers to conduct RNA-Seq analysis and compare different analysis pipelines, by automatically generate workflows based on user-selected tools.

For an online demo of the front-end interface, please see [demo](http://rawg.tony.tc) and [user guide](/doc/userguide.md)

For a detailed write-up, please see [report.pdf](https://github.com/rawgene/rawg/blob/master/doc/RNASeq_report_CC.pdf)


## Quickstart guide

### Clone this project
Select a local directory and clone the main repository. Note that the Data directory will be on the same level as this repository. The `-j3` flag clones the three submodules in parallel, can be dropped if you are using an older version of git.  
  
```git clone --recurse-submodules -j3 https://github.com/rawgene/rawg```

### Prerequisites
RAWG supports `python3` and is developed and tested on 3.6 and 3.7. [`Graphviz`](https://www.graphviz.org/download/) commandline program is needed to generate workflow svg files.

#### Required pyhton packages
* cwlref-runner
* Django
* Django-crispy-forms
* pandas
* pydot
* sqlalchemy

To install/check python packages, run `pip3 install -r requirements.txt` in `./rawg`

### Config local setting file
Copy and modify the setting file for the webportal which is located under `./rawg/webportal/webportal/settings.py`. You should make a copy of this and call it `local_settings.py` under the same parent directory.  
  
Few things need to be modified in the new setting file.
  * Add the desired domain or ip address to the `ALLOWED_HOST` list
  * Fill the secret key string with a 50-character random string. We recommand following the Django default method, as below  
    ```
    import random
    ''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50))
    ```

### Start the webserver
From `./rawg/webportal` directory, run `nohup python3 manage.py runserver [ip]:[port] &`

### Config file
A config file is needed outside the rawg root directory to provide database location for flowgen's scripts as well as the number of threads the analysis tools should use. This file should be called `config.ini`.

_An example config file_
```
[main]
database = sqlite:///rawg/webportal/db.sqlite3
threads = 2
```
Note that in this example, the relative path to the SQLite database (default by Django) is used. All database supported by SQLAlchemy can be used and the string should be formatted according to [this document](https://docs.sqlalchemy.org/en/latest/core/engines.html#supported-databases). `threads` is set to 2 in this example, you can modify it according to your system. The majority tools used in rawg do not scale well above 12 threads and some are single thread only.

### Setup crontab and scripts
A script is provided to automatically generate two shell scripts (one for `cwl_creator.py` and one for `run.py`). This setup script also add cron jobs to run these two shell scripts periodically (every 15 seconds). A file based locking system is implemented for these two shell script to prevent racing condition.  
  
To use the setup script, simply `bash ./rawg/setup.sh`. Use `crontab -l` to check the correct jobs are added to crontab.

</p></details>

## Development Guide
To clone the main repository with all submodules  
`git clone --recurse-submodules -j3 https://github.com/rawgene/rawg`
  
Note that at this point, the submodules will be in HEAD DETACHED mode. To modify code, you should go into the relevant submodule and `git checkout master` or any other branch. If you are creating a new branch, be sure to checkout master first, as submodules are not dynamically linked to master branch so the code might be outdated.
  
Before committing and pushing your code, please do a `git status` to check you are on the correct repository AND correct branch. Becareful about any sensitive information (eg. password, secret key and absolute path) as the code is publicly accessible now.
  
### Update submodules
```
git submodules update --remote --merge
git commit -m "Update submoduels"
git push
```
