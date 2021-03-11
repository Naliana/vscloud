#!/bin/bash

#1 clone a repo
git clone https://github.com/facebook/react.git
#2 start code-server popinted @ repo
sudo systemctl restart code-server react
