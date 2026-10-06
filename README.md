# CanSet-Sensor-Fusion-Accelerator

A SystemVerilog-based CanSat Sensor Fusion Accelerator designed to process multi-axis sensor data and generate formatted telemetry output for a CanSat/embedded sensing system.
The project combines sensor-data processing, filtering, fault detection, packet formatting, and UART-based telemetry into a single hardware design.

Project Overview

The accelerator processes sensor information such as Accelerometer data, Gyroscope data, Roll_Pitch_Yaw angle, Filtered sensor values, Fault/status information
The complete design is integrated through the top-level module:
cansat_sensor_fusion_top

Physical Design / GDSII

The RTL design was taken through a physical-design flow to generate a GDSII layout for the top-level accelerator.
Final Layout & GDSII file:
cansat_sensor_fusion_top.gds
The layout image shows the implemented top-level CanSat sensor-fusion design along with its physical structures and I/O connections.

Project Objective

The objective of this project is to demonstrate the implementation of a sensor-processing pipeline as a dedicated digital hardware accelerator.
The project covers the flow from:
RTL Design → Verification → Physical Design → GDSII

Author
Aryan Kumar Satle
VLSI / Electronics Engineering Student
Interested in VLSI Design, Digital Hardware, ASIC Design, and Computer Architecture.
