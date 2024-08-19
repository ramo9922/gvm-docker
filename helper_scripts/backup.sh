#!/bin/bash

PROJ_DIR=/opt/gvm-docker
PROJ_NAME=`basename ${PROJ_DIR}`
BACKUP_DIR=${PROJ_DIR}/backups
BACKUP_NAME=gvm_backup_`date +%d-%m-%y_%T`.tar.gz
VOL_PATH=/var/lib/docker/volumes

echo proj-dir: ${PROJ_DIR}
echo proj-name: ${PROJ_NAME}
echo backup-dir: ${BACKUP_DIR}
echo backup-name: ${BACKUP_NAME}
echo vol-path: ${VOL_PATH}

[[ ! -f ${BACKUP_DIR} ]] && mkdir -p ${BACKUP_DIR}
[[ ! -f ${BACKUP_DIR} ]] && \
	cd ${VOL_PATH} && \
	tar czvf ${BACKUP_DIR}/${BACKUP_NAME} ${PROJ_NAME}_*
