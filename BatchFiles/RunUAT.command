#!/bin/bash
# Unreal Engine AutomationTool Setup Script
# Created by P.G.D.

# Define directories
scriptDir="$(dirname "$0")"
logDir="$scriptDir/Error Logs"
logFile="$logDir/Logfile.txt"

# Create the log directory if it doesn't exist
mkdir -p "$logDir"

# Function to run AutomationTool
runAutomationTool() {
    echo "Running AutomationTool..."
    "$scriptDir/RunUAT.sh" "$@" 2>&1 | tee -a "$logFile"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "An error occurred while executing RunUAT.sh. See $logFile for details." >&2
        return $status
    fi
    echo "AutomationTool executed successfully."
    return 0
}

# Main menu function
showMenu() {
    echo "Unreal Engine AutomationTool Setup Script"
    echo "1. Run AutomationTool (RunUAT.sh)"
    echo "2. Exit"
    echo -n "Enter your choice (1-2): "
    read choice
    case $choice in
        1) runAutomationTool ;;
        2) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Loop the menu
while true; do
    showMenu
done
#exit
