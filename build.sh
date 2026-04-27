#!/bin/bash

cd simulation/
/mnt/c/Program\ Files/MATLAB/R2025b/bin/matlab.exe -batch setup
mkdir ../flight_code/build
cd ../flight_code/build
cmake .. -D FMU=mini-v1 -D VEHICLE=torch -D AUTOCODE=torch_zdof
make -j6 flight_upload
cd ../../tycmd.exe reset -b
make -j6 flight_upload 

pip3 install --user future
if ! command -v mavproxy.py &> /dev/null; then
    echo "Installing MAVProxy..."
    pip3 install --user MAVProxy
    export PATH="$PATH:$HOME/.local/bin"
fi
mavproxy.py --master=/dev/ttyS8 --baudrate 57600  --cmd="param load params.txt"

# param set PARAM_000 1