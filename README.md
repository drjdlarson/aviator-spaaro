# Simulink/C++ Platform for Aeronautics and Autonomy Research and Operations (SPAARO)
SPAARO, when coupled with Bolder Flight control systems, enables engineers to quickly research, develop, and deploy control laws, autonomy algorithms, and flight software.
   * [License](LICENSE.md)
   * [Changelog](CHANGELOG.md)
   * [Contributing guide](CONTRIBUTING.md)

# Overview

The X-DOF SPAARO branch controls the dynamics of the AVIATOR platform in the horizontal direction for both fixed and variable angle configurations.

# Setting up the Development Environment
Follow the [build tools guide](https://github.com/bolderflight/build-tools) for setting up your development environment. Additionally, if you plan on using the SPAARO Simulink simulation, you'll need:
   * MATLAB Simulink
   * Aerospace Blockset
   * Control System Toolbox (trimming and linearization)
   * Simulink Control Design (trimming and linearization)

If you plan on autocoding flight software, you will also need:
   * MATLAB Coder
   * Simulink Coder
   * Embedded Coder

# Building and Uploading Software

First, clone the github repository and checkout the zdof-branch.

```shell
git clone https://github.com/drjdlarson/aviator.git
cd lager_spaaro
git checkout torch_zdof
```

Next, plug in the aviator platform into a USB port and execute run.sh in WSL.
``` shell
./run.sh
```

This will autocode the simulink control laws to C++ and compile a build directory with all objects and dependencies. It will also upload the compiled code to the flight controller aboard the AVIATOR platform.

After the script has executed (around 5 minutes), AVIATOR will be configured for Z-DOF controls. To begin testflights, unplug the USB cable, power on AVIATOR through the power supply module, and wait for a distinct beep from the ESC signaling all systems have been initialized.

With the telemetry module plugged into the PC, upload the default flight parameters through MissionPlanner. Connect through the correct COM port and BAUD 57600. Select `CONFIG->Full Parameter List->Load from file` and choose the param file in the main directory. Once the values have been loaded, select `Write from Params` to upload to the drone. The method of changing params mid-flight should only be used to change flight modes or position/velocity commands. In case of emergency, do NOT use MissionPlanner. Instead, use the physical E-stop button located on the side of the platform.

# Data Logging and Visualization
All flight data is logged to the microSD card aboard the AVIATOR flight controller as a .bfs file. Before converting it to a MATLAB-readable `.mat` file, we need to build the mat_converter tool.

```shell
cd ./mat_converter/build
cmake ..
make -j6
```

Copy the `.bfs` file into the main directory of the repository and run
```shell
./mat_converter/build/mat_converter <file_name>
```

Then run `flight_data_parser.m`. Make sure the specify the file location, the output name and location, and the range you wish to save.
To visualize the flight data, run `setup.m` with vms_only == false. Then run the first section of `sim_vs_flight.m` to load variables for the sim. Finally run the sim and then rerun the MATLAB script.


## Cite

Please cite the framework as follows
```
    @Misc{lager_spaaro,
        author       = {Brian Taylor and Jordan D. Larson and Tuan D. Luong and Aabhash Bhandari and Ryan W. Thomas},
        howpublished = {Web page},
        title        = {{lager_spaaro}: {S}imulink/C++ {P}latform for {A}eronautics and {A}utonomy {R}esearch and {O}perations},
        year         = {2023},
        url          = {https://github.com/drjdlarson/lager_spaaro},
    }
```

<!-- # Simulation

# Analyzing Data -->
