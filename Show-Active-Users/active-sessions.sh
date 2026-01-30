#!/bin/bash

if [ -z "$SSH_CONNECTION" ] || [ -z "$PS1" ]; then
  return
fi
#prints out the modt 
cat << "EOF"
__        __         _                                       _           
\ \      / /   ___  | |   ___    ___    _ __ ___     ___    | |_    ___               !
 \ \ /\ / /   / _ \ | |  / __|  / _ \  | '_ ` _ \   / _ \   | __|  / _ \              !
  \ V  V /   |  __/ | | | (__  | (_) | | | | | | | |  __/   | |_  | (_) |             ^
   \_/\_/     \___| |_|  \___|  \___/  |_| |_| |_|  \___|    \__|  \___/             / \
                                                                                    /___\
                   _   _   ___   _                                                 |=   =|
                  | | | | |_ _| | |                                                |     |
                  | |_| |  | |  | |                                                |     |
                  |  _  |  | |  | |___                                             |     |
                  |_| |_| |___| |_____|                                            |     |
                                                                                  /|##!##|\
                                                                                 / |##!##| \
                                                                                /  |##!##|  \
                                                                               |  / ^   ^ \  |
                                                                               | /         \ |
                                                                               |/           \|
                                                                                        
EOF

#prints out the current users conencted, there conntection time, and the duration of the connection, 
#and if the user is active or not
echo ""
echo "======= Active SSH Sessions ======="
printf "%-10s %-20s %-15s %-10s\n" "USER" "LOGIN TIME" "DURATION" "STATUS"

w -h | awk '
{
  user = $1
  login_time_str = $4  # LOGIN@ column
  split(login_time_str, t, ":")
  login_hour = t[1]
  login_min = t[2]

  # Get current time
  cmd = "date +\"%H %M\""
  cmd | getline now
  close(cmd)
  split(now, n, " ")
  now_hour = n[1]
  now_min = n[2]

  # Compute duration in minutes
  duration_min = (now_hour*60 + now_min) - (login_hour*60 + login_min)
  if (duration_min < 0) {
    duration_min += 24*60  # handle midnight wrap
  }

  hours = int(duration_min / 60)
  mins = duration_min % 60
  duration_fmt = sprintf("%02dh:%02dm", hours, mins)

  # Determine status using IDLE column ($5)
  idle = $5
  if (idle ~ /[0-9]+\.[0-9]+s/) { idle_min = 0 }
  else if (idle ~ /[0-9]+:[0-9]+/) {
    split(idle, im, ":")
    idle_min = im[1] + im[2]/60
  } else if (idle ~ /^[0-9]+$/) { idle_min = idle }
  else { idle_min = 0 }

  status = (idle_min > 5) ? "Inactive" : "Active"

  printf "%-10s %-20s %-15s %-10s\n", user, login_time_str, duration_fmt, status
}
'
echo "==================================="
echo ""