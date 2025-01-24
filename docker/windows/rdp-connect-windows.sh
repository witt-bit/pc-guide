#!/usr/bin/env bash



nohup rdesktop -u Docker -a 16 -g "1920x1080" -z -5 -K \
	-T 'windows 11 Pro' \
	-r clipboard:PRIMARYCLIPBOARD \
	-r sound:off \
	localhost > /usr/share/windows/rdp.log 2>&1 &
