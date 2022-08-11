#!/bin/bash

sudo wget -O /root/activity_fix.sh https://raw.githubusercontent.com/cemrehano/helium_mining_activity_fix/main/activity_fix.sh; chmod a+x /root/activity_fix.sh
{ crontab -l; echo "0 * * * * sh /root/activity_fix.sh"; } | crontab -
