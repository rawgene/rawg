# get script dir
script_dir=`dirname $(readlink -f ${BASH_SOURCE[0]})`
dir=`dirname $script_dir`

## make cwl_create.sh
echo "if [ ! -f /tmp/rawg.lock ]; then
    touch /tmp/rawg.lock" > $script_dir/cwl_create.sh

create=`readlink -f ./flowgen/cwl_creator.py`

echo "    python3 $create >> $dir/crontab.log 2>&1" >> $script_dir/cwl_create.sh
echo "    rm /tmp/rawg.lock
fi" >> $script_dir/cwl_create.sh

## make run.sh
echo "if [ ! -f /tmp/run.lock ]; then
    touch /tmp/run.lock" > $script_dir/run.sh

run=`readlink -f ./flowgen/run.py`

echo "    python3 $run >> $dir/crontab.log 2>&1" >> $script_dir/run.sh
echo "    sleep 15
    rm /tmp/run.lock
fi" >> $script_dir/run.sh


## add crontab
(crontab -l ; echo "* * * * * source ~/.bashrc; bash $script_dir/cwl_create.sh") | crontab -
(crontab -l ; echo "* * * * * sleep 15; source ~/.bashrc; bash $script_dir/cwl_create.sh") | crontab -
(crontab -l ; echo "* * * * * sleep 30; source ~/.bashrc; bash $script_dir/cwl_create.sh") | crontab -
(crontab -l ; echo "* * * * * sleep 45; source ~/.bashrc; bash $script_dir/cwl_create.sh") | crontab -
(crontab -l ; echo "* * * * * source ~/.bashrc; bash $script_dir/run.sh") | crontab -
(crontab -l ; echo "* * * * * sleep 15; source ~/.bashrc; bash $script_dir/run.sh") | crontab -
(crontab -l ; echo "* * * * * sleep 30; source ~/.bashrc; bash $script_dir/run.sh") | crontab -
(crontab -l ; echo "* * * * * sleep 45; source ~/.bashrc; bash $script_dir/run.sh") | crontab -