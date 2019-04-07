# RAWG: RNA-Seq Analysis Workflow Generator

[![Gitter](https://badges.gitter.im/rawgene/rawg.svg)](https://gitter.im/rawgene/rawg?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Quickstart guide
Select a local directory and clone the main repository. Note that the Data directory will be on the same level as this repository. The `-j3` flag clones the three submodules in parallel, can be dropped if you are using an older version of git.  
  
```git clone --recurse-submodules -j3 https://github.com/rawgene/rawg```
  
Copy and modify the setting file for the webportal which is located under `./rawg/webportal/webportal/settings.py`. You should make a copy of this and call it `local_settings.py` under the same parent directory.  
  
Few things need to be modified in the new setting file.
  * Add the desired domain or ip address to the `ALLOWED_HOST` list
  * Fill the secret key string with a 50-character random string. We recommand following the Django default method, as below  
    ```
    import random
    ''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50))
    ```

### Start the webserver
From `./rawg/webportal` directory, run `nohup python runserver [ip]:[port] &`

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
