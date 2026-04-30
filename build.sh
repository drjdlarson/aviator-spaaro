#!/bin/bash

cd simulation/
/mnt/c/Program\ Files/MATLAB/R2025b/bin/matlab.exe -batch setup
mkdir ../flight_code/build
cd ../flight_code/build
cmake .. -D FMU=mini-v1 -D VEHICLE=torch -D AUTOCODE=torch_xdof
../../tycmd.exe reset -b
make -j6 flight_upload
make -j6 flight_upload
