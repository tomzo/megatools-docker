#!/bin/bash

# upload all new files to remote location
/bin/megaupload $1

# remove every file or directory which is not present locally in /Root

REMOTE_DIR="/Root/$1/"
REMOTE_PATHS=$(megals --reload -R $REMOTE_DIR)

for remote_path in $REMOTE_PATHS ; do
  if [ -f $remote_path ] || [ -d $remote_path ]; then
    echo "path '$remote_path' exists both locally and remotely"
  else
    echo "path '$remote_path' no longer exists locally - deleting!"
    megarm $remote_path
  fi
done

echo "synchronization complete. Current state of remote directory:"
megals --reload -R $REMOTE_DIR
