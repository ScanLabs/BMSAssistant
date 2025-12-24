@echo off
setlocal EnableDelayedExpansion
set "arg0="
set "arg1="
set "arg2="

call set "arg0=%%1"
call set "arg1=%%2"
call set "arg2=%%3"


if defined arg0 goto :model_exists
echo arg0 is missing set JK
call set "arg0=JK"

:model_exists
if defined arg1 goto :com_exists
echo arg1 is missing set COM16
call set "arg1=COM16"

:com_exists
if defined arg2 goto :now_flash
echo arg2 is missing set BAUD @ 115200
call set "arg2=115200"


:now_flash
esptool --port !arg1! --baud !arg2! write_flash 0x00000 SolarEnergyECUMulti.!arg0!-3.4.2.bin 0x200000 SolarEnergyECUMulti.mklittlefs-3.4.2.bin

:done
echo DONE
