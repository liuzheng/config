#!/bin/bash
texfile="$1"
terminal -e "/opt/MATLAB/R2011a/bin/matlab -r clc -nosplash -nodesktop" -T MatlabT --hide-menubar &> /dev/null &
# try to return focus to GVIM
xdotool search --class --name "${texfile}.*GVIM" windowactivate &>/dev/null
exit 0
