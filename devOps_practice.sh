#!/bin/bash

# ==============================
# Accept arguments
# ==============================
USERNAME=$1
FILE_TO_DELETE=$2
PATH_TO_CHECK=$3

# ==============================
# Function: Create User
# ==============================
create_user() {
  if [ -z "$USERNAME" ]; then
    echo "No username provided"
    return 1
  fi

  if id "$USERNAME" &>/dev/null; then
    echo "User already exists"
  else
    sudo useradd -m "$USERNAME"
    echo "User $USERNAME created"
  fi
}

# ==============================
# Function: Delete File if exists
# ==============================
delete_file() {
  if [ -z "$FILE_TO_DELETE" ]; then
    echo "No file provided"
    return 1
  fi

  if [ -f "$FILE_TO_DELETE" ]; then
    rm "$FILE_TO_DELETE"
    echo "File deleted: $FILE_TO_DELETE"
  else
    echo "File does not exist"
  fi
}

# ==============================
# Function: Disk Usage
# ==============================
check_disk_usage() {
  if [ -z "$PATH_TO_CHECK" ]; then
    echo "No path provided"
    return 1
  fi

  if [ -d "$PATH_TO_CHECK" ]; then
    du -sh "$PATH_TO_CHECK"
  else
    echo "Invalid directory"
  fi
}

# ==============================
# Function: Ping Servers
# ==============================
ping_servers() {
  SERVERS=("google.com" "github.com" "invalid.host")

  for SERVER in "${SERVERS[@]}"
  do
    ping -c 1 "$SERVER" &>/dev/null

    if [ $? -eq 0 ]; then
      echo "$SERVER is reachable"
    else
      echo "$SERVER is NOT reachable"
    fi
  done
}

# ==============================
# While Loop Example
# ==============================
counter_loop() {
  COUNT=1

  while [ $COUNT -le 3 ]
  do
    echo "Loop iteration: $COUNT"
    COUNT=$((COUNT + 1))
  done
}

# ==============================
# Main Execution
# ==============================

echo "===== DevOps Script Started ====="

create_user
echo "Exit Code (create_user): $?"

delete_file
echo "Exit Code (delete_file): $?"

check_disk_usage
echo "Exit Code (disk_usage): $?"

ping_servers

counter_loop

echo "===== Script Completed ====="
