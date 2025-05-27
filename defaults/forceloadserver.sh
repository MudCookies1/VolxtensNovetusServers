#!/bin/bash

#
# This script exist to pass the "Loading..." popup that some clients get stuck on.
#

# Make sure errors don't stop the script
set +e

while true; do
    # Get all window IDs with "Server" in their title
    window_ids=$(xdotool search --name "Server" 2>/dev/null || true)
    for win in $window_ids; do
    	# Focus the window
    	xdotool windowactivate "$win" 2>/dev/null 
    	sleep 0.2 # Give time for the focus to switch
	
    	# Move mouse to the center of the window
   		eval $(xdotool getwindowgeometry --shell "$win")
    	center_x=$((X + WIDTH / 2))
    	center_y=$((Y + HEIGHT / 2))
		
    	xdotool mousemove "$center_x" "$center_y" 2>/dev/null 
    	sleep 0.1
    done
    
    # Wait 2 seconds before next round
    sleep 2
done

