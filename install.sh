#!/bin/bash
# RED
##############################
# MODULE COMPILER AND LOADER #
##############################


# == DECLARE VARS == #
work_folder="tcmodule"
libkernel_folder="/lib/modules/$(uname -r)/kernel"
newmodule_folder="${libkernel_folder}/thinkcyber"
module_file="${newmodule_folder}/tcmodule.ko"
# ================== #


# == INSTALL DEPENDENCIES == #
apt update
apt install linux-headers-$(uname -r) -y
apt install build-essential -y
apt install make bc bison -y
# ========================== #


# == ENTERS INTO MODULE DIR == #
dirs -c
pushd ${work_folder}
# ============================ #


# == COMPILE MODULE == #
make -s
# ==================== #


# == INSTALL INTO NEW MODULE FOLDER == #
[ -d ${libkernel_folder} ] && rm ${libkernel_folder}/thinkcyber -rf
[ -d ${libkernel_folder} ] && mkdir ${libkernel_folder}/thinkcyber || echo 'ERROR LIB KERNEL FOLDER NOT FOUND'
[ -d ${newmodule_folder} ] || echo 'ERROR NEW MODULE FOLDER NOT FOUND'
[ -f ${work_folder}/tcmodule.ko ] && mv ${work_folder}/tcmodule.ko ${newmodule_folder}/tcmodule.ko || echo 'ERROR BACKEND IS BROKEN'
# ==================================== #


# == LOADS NEW MODULE INTO KERNEL == #
grep tcmodule /lib/modules/$(uname -r)/modules.dep > /dev/null && echo 'MODULE ALREADY LOADED INTO DEPMOD' || echo 'kernel/thinkcyber/tcmodule.ko' >> /lib/modules/$(uname -r)/modules.dep
depmod || 'ERROR DEPMOD FAILED'
modprobe tcmodule || echo 'ERROR MODPROBE COULD NOT FIND MODULE'
# ================================== #