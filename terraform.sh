#!/bin/sh

# Run this script as sudo
sudo apt remove landscape-client landscape-common
sudo touch /etc/motd

sudo chmod -x /etc/update-motd.d/10-help-text
sudo chmod -x /etc/update-motd.d/51-cloudguest
