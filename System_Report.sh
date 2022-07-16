#!/bin/bash

# This program generates a report for our system

TITLE="SYSTEM REPORT GENERATOR FOR $HOSTNAME"

CURRENT_TIME="$(date +"%x %r %Z")"

TIMESTAMP="Generated $CURRENT_TIME, by $USER"
report_uptime () {
	cat <<- _EOF_
		System Uptime
		$(uptime)
	_EOF_
	return
}

report_disk_space () {
	cat <<- _EOF_
		Disk Space
		$(df -h)
	_EOF_
	return
}


report_home_space () {
	if [ "$(id -u)" -eq 1000 ]; then
		cat <<- _EOF_
			Home Space Utilization
			"$(du -sh /home/*)"

		_EOF_
	else
		echo "the userid is not equal to 1000"
	fi
	return
}

cat <<- _EOF_

	$TITLE

	$TIMESTAMP

	$(report_uptime)

	$(report_disk_space)

	$(report_home_space)
	_EOF_
