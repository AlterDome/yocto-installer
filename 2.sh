#
#  Тест 1
#  Первая версия установочного файла, просто установка yocto poky
#  Не содержит сырцов...
#
#  Author Rybochkin Aleksei
#  July 2025
#
#  Готовилось для версии Walnascar 5.2
#
#
#
#
#
#  BB_NUMBER_THREADS = «4»
#






### - 1  УСТАНОВКА ГИТА -------------

function fnyocto() {
echo "_________________________ Setup Yocto 5 ...___________"
uptime
echo "___________________"
df /
echo  "____________________"
##
# Wrynose 6.0 - выпуск апрель 2026
# Whinlatter 5.3 - выпуск октября 2025
# Walnascar (Walna) 5.2 - выпуск май 2025 - ТЕКУЩАЯ до ноября 2025, без поддержки...
# Mickledore - выпуск май 2023, 
# Kirkstone --- ВЫПУСК май 2022 - ПОДДЕРЖИВАЕТСЯ--
# Dunfell --- ВЫПУСК апрель 2020 - ПОДДЕРЖИВАЕТСЯ--
# Zeus - выпуск октябрь 2019,
# Warrior - выпуск апрель 2019,
# Thud - выпуск ноябрь 2018,
# Sumo - выпуск апрель 2018,
# Rocko - выпуск октябрь 2017,
# Pyro - выпуск апрель 2017,
# Morty - выпуск октябрь 2016,
# Krogoth - выпуск апрель 2016, 
# Jethro - выпуск октябрь 2015
# Fido - выпуск апрель 2015,
# Dizzy - выпуск октябрь 2014,
# Daisy - выпуск апрель 2014,
# Dora - выпуск октябрь 2013,
# Dylan - выпуск апрель 2013,
# Danny - выпуск октябрь 2012,
# Denzil - выпуск апрель 2012,
# Edison - выпуск октябрь 2011,
# Bernard - выпуск 2011,
# Laverne - первый выпуск 2010, 
#
# git clone -b НАЗВАНИЕ ВЕРСИИИ git://git.yoctoproject.org/poky НАЗВАНИЕ ПАПКИ
git clone git://git.yoctoproject.org/poky

echo "git clone git://git.yoctoproject.org/poky"
sleep 3
cd poky    # Poky - Стандартное название, лучше не менять
echo "cd poky"
source oe-init-build-env
echo "source oe-init-build-env"

sleep 3
cd build            # build - стандартное название папки, лучше не менять
echo "cd build"

mainn
}


### - 2  УСТАНОВКА ЛОКАЛИ ----------------
function fnlocale() {
# localectl set-locale LC_TIME=en_US.UTF-8
localectl set-locale LC_TIME=en_US.UTF-8
echo "localectl set-locale LC_TIME=en_US.UTF-8"
echo " "
mainn
}

### - 3 ВЫБОРЫ В BITBAKE -----------------
function fnbitbake() {
source oe-init-build-env
echo " Выберите свой вариант установки..."
echo " 1 - bitbake core-image-minimal "
echo " 2 - bitbake core-image-full-cmdline "
echo " 3 - bitbake core-image-sato "
echo " 4 - bitbake core-image-weston "
echo " 5 - bitbake meta-toolchain "
echo " 6 - bitbake meta-ide-support "
echo " 7 - Главное меню "

read num

case $num in

1) bitbake core-image-minimal
;;
2) bitbake core-image-full-cmdline
;;
3) bitbake core-image-sato
;;
4) bitbake core-image-weston
;;
5) bitbake meta-toolchain
;;
6) bitbake meta-ide-support
;;
7) mainn
;;
*) mainn
;;
esac
echo " "
}

### - 4 ВСТАВКА СВОИХ СЛОЕВ -----------------------
function fnlayer() {
echo " "
echo " Введина название слоя - желательно с meta-  "
cd poky  # перешли в каталог поки для создания слоя...
read lay

bitbake-layers create-layer $lay
sleep 3

bitbake-layers add-layer $lay
sleep 3

echo " "
mainn
}

### - 5 ВЫХОД ИЗ СКРИПТА
function fnexit() { 
echo " "
uptime
df /
echo " Exit ..."
exit 0
}



function mainn() {
echo " 1 - Git clone yocto from yoctoproject.org  "
echo " 2 - Установка локали  en_US.UTF-8  "
echo " 3 - Выбрать образ для Bitbake  "
echo " 4 - Создать свой слой  "
echo " 5 - Exit  "
echo " 6 - Главное меню  "
echo " 7 - Uptime and df / "
echo " 8 - Запуск образа в qemu " 
echo " 9 - bitbake-layers show-layers"




echo " Введите значение ... "
main
}

function main() {

read number

case $number in

1) fnyocto
;;
2) fnlocale
;;
3) fnbitbake
;;
4) fnlayer
;;
5) fnexit
;;
6) mainn
;;
7) uptimedf
;;
8) runimage
;;
9) showlayers
;;

*) mainn
;;
esac
}

function runimage() {
echo " Запуск образа в Qemu..."	
#qemu-system-arm \

cd /home/alex/poky/1/poky/build/tmp/deploy/images/qemux86-64/

qemu-system-x86_64 \
-kernel bzImage \
-drive file=core-image-minimal-qemux86-64.rootfs.ext4 \
-append "root=/dev/sda console=ttyS0"


######
#-kernel file=./build/tmp/deploy/images/qemux86-64/bzImage-qemux86-64.bin \
#-hda = ./poky/build/tmp/deploy/images/qemux86-64/core-image-minimal-qemux86-64.rootfs.ext4 \
#
#-append "root=/dev/hda console=ttyS0" -nographic


#####
#-append "console=ttyS0 root=/dev/hda initrd=/initrd" \
#-nographic \
#-serial stdio -kernel vmlinuz -hda -drive file =./poky/build/tmp/deploy/images/qemux86-64/bzImage \
#-drive file =./poky/build/tmp/deploy/images/qemux86-64/bzImage \
#-hda = \
#./poky/build/tmp/deploy/images/qemux86-64/core-image-minimal-qemux86-64.rootfs.ext4 \
#-append "console=ttyS0 root=/dev/hda initrd=/initrd" \
#-cpu q35 \
#-kernel "vmlinuz" -initrd "initrd" -append "root=/dev/ram0" \
#format=raw \
#-m 1G \
#-device virtio-net-pci,netdev=lan \
#-net dev user,id=lan \








}


function uptimedf() {
echo " "
uptime
df /
echo " "
mainn
}

#########################################################
function showlayers() {
echo " "
bitbake-layers show-layers
echo " "
mainn
}



#! /bin/bash
### - 0 ГЛАВНОЕ МЕНЮ ------------------
echo " "
echo "Yocto installer by Rybochkin Aleksei "
echo "  Выберите действие...  "
mainn
