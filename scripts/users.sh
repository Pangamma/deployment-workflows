#!/bin/bash

PROG_NAME="devops"
SLOT_IDX=1
CONTROLLER_USERNAME="${PROG_NAME}"
USERNAME="slot.${SLOT_IDX}"
USERGROUP="${PROG_NAME}-slots"
USER_HOME_DIR="/home/${CONTROLLER_USERNAME}/slots/slot.${SLOT_IDX}"


# Create the main user group if it does not already exist. (For organization purposes.)
sudo getent group "${USERGROUP}" || sudo groupadd "${USERGROUP}"

# Create a brand new user. No login space and no shell either. Used when running services more securely.
# sudo useradd --system --no-create-home --shell /usr/sbin/nologin $USERNAME
# -g = group
# -c = comment
# -d = home directory (Create if not already existing)
# --shell = Prevent logging into this account.
sudo useradd -g "${USERGROUP}" -c "Slot ${SLOT_IDX}" -d "${USER_HOME_DIR}" -s /usr/sbin/nologin "${USERNAME}"
# sudo useradd -u "${USERNAME}" -g "${USERGROUP}" -c "Slot ${SLOT_IDX}" -d "${USER_HOME_DIR}" -s /bin/false "${USERNAME}"

# Confirm adding the user to the correct group.
sudo usermod -a -G $USERGROUP $USERNAME

# Make the user folder, and the active/staging subdirectories for working with uploads.
sudo mkdir -p $USER_HOME_DIR
sudo mkdir -p "${USER_HOME_DIR}/active"
sudo mkdir -p "${USER_HOME_DIR}/staging"
sudo chown -R $USERNAME:$USERNAME $USER_HOME_DIR


# Create a folder within the main user's account that will house the files for each service.
# you can chown the folders.
