# RAWG: RNA-Seq Analysis Workflow Generator

## Development Guide
To clone the main repository with all submodules  
`git clone --recurse-submodules -j3 https://github.com/rawgene/rawg`
  
Note that at this point, the submodules will be in HEAD DETACHED mode. To modify code, you should go into the relevant submodule and `git checkout master` or any other branch. If you are creating a new branch, be sure to checkout master first, as submodules are not dynamically linked to master branch so the code might be outdated.
  
Before committing and pushing your code, please do a `git status` to check you are on the correct repository AND correct branch. Becareful about any sensitive information (eg. password, secret key and absolute path) as the code is publicly accessible now.
