# Setup guide

### Clone this project
Select a local directory and clone the main repository. Note that the Data directory will be on the same level as this repository. The `-j3` flag clones the three submodules in parallel, can be dropped if you are using an older version of git.  
  
```git clone --recurse-submodules -j3 https://github.com/rawgene/rawg```

### Prerequisites
RAWG supports `python3` only and is developed and tested on 3.6 and 3.7. [`Graphviz`](https://www.graphviz.org/download/) commandline program is needed to generate workflow svg files.

#### Required pyhton packages
* cwlref-runner
* Django
* Django-crispy-forms
* pandas
* pydot
* sqlalchemy

To install/check python packages, in `./rawg` run `pip3 install -r requirements.txt`  
Note that you will need to have pip3 installed

### Config local setting file
Copy and modify the setting file for the webportal which is located under `./rawg/webportal/webportal/settings.py`. You should make a copy of this and call it `local_settings.py` under the same parent directory.  
  
Few things need to be modified in the new setting file.
  * Add the desired domain or ip address to the `ALLOWED_HOST` list  
    eg. `set ALLOWED_HOST = ["*"]` to allow all possible addresses
  * Fill the secret key string with a 50-character random string. We recommand following the Django default method, as below  
    ```
    import random
    ''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50))
    ```

### Migrate database
From `./rawg/webportal` directory, run `python3 manage.py makemigrations` then `python3 manage.py migrate`

### Start the webserver
From `./rawg/webportal` directory, run `nohup python3 manage.py runserver [ip]:[port] &`  
eg. `nohup python3 manage.py runserver 0.0.0.0:80 &` will bind to all address and the default TCP port 80.  
Once the web server is running, you can access the website via any addressable domain/ip and port to the server.  
Check to make sure the port is open on the system if you are having trouble accessing the website.  

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
