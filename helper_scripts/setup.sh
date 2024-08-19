#!/bin/bash

must_install=(ca-certificates gnupg)
for i in git openssl docker docker-compose; do
	[[ ${i} == "docker" ]] && i=docker.io
	which -s ${i} || must_install+=${i}
done
if [[ -n ${must_install[@]} ]]; then
	apt update && apt install -y ${must_install[@]}
fi

REPO=https://github.com/ramo9922/gvm-docker.git
cd /opt && \
	git clone ${REPO} && \
	cd helper_scripts && \
	bash regenerate_ssl_gsad.sh && \
	cd /opt/gvm-docker && \
	docker-compose up -d

echo Default username and password is admin:admin
read -p "Do you want to change username and password?[y/N] " choise
case ${choise} in
	[Yy]|[Yy][Ee][Ss])
		read -p "New username: " username
		until [[ ${pass} == ${new_pass} ]]; do
			read -s -p "New password:" pass
			echo -e "\n"
			read -s -p "Repeate password:" new_pass
			echo -e "\n"
		done
		docker-compose exec -itu gvmd gvmd gvmd --user=${username} --new-password=${pass}
		;;
	*) echo Default credentials are setted ;;
esac
