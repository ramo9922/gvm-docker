#!/bin/bash

PROJ_DIR=/opt/gvm-docker
PROJ_NAME=`basename ${PROJ_DIR}`
BACKUP_DIR=${PROJ_DIR}/backups
VOL_PATH=/var/lib/docker/volumes
if [[ -z $1 ]]; then
	export PS3="Select backup file: "
	select BACKUP_NAME in `ls ${BACKUP_DIR}`; do
		echo "Selected file is: ${BACKUP_NAME}"
		break
	done
fi
if [[ -z ${BACKUP_NAME} ]]; then
	echo >&2 Backup file is not selected.
	exit 1
fi
cd ${PROJ_DIR} && \
	docker-compose up -d && \
	cd ${VOL_PATH} && \
	tar xzvf ${BACKUP_DIR}/${BACKUP_NAME} && \
	cd ${PROJ_DIR} && \
	docker-compose pull && \
	docker-compose up -d --force-recreate
