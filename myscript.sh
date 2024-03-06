#!/bin/bash


# Initialize default values
top_entries=8
list_files=false

# Parse command line arguments
while getopts ":n:d" opt; do
  case $opt in
    n)
      top_entries=$OPTARG
      ;;
    d)
      list_files=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Shift arguments to get the directory path
shift $((OPTIND - 1))
directory=$1

# Check if directory is provided
if [ -z "$directory" ]; then
  echo "Usage: $0 [-n top_entries] [-d] directory"
  exit 1
fi

# Display disk usage based on options
if [ "$list_files" = true ]; then
  du -h --max-depth=1 "$directory"
else
  du -h --max-depth=1 "$directory" | sort -rh | head -n "$top_entries"
fi

