#!/bin/bash

echo "Setting up DeepPilot..."

# Cambiar al directorio principal de DeepPilot
DEEP_PILOT_DIR=/bebop_ws/src/DeepPilot
if [ -d "$DEEP_PILOT_DIR" ]; then
    echo "Changing directory to $DEEP_PILOT_DIR"
    cd "$DEEP_PILOT_DIR" || { echo "Error: Could not change directory to $DEEP_PILOT_DIR."; exit 1; }
else
    echo "Error: Directory $DEEP_PILOT_DIR does not exist."
    exit 1
fi

echo "Copying files..."

# Configurar modelos de Gazebo
echo "Processing Gazebo models..."
mkdir -p ~/.gazebo/models/
if [ -d "gazebo_models" ]; then
    cp -r gazebo_models/* ~/.gazebo/models/ 2>/dev/null || echo "No models found to copy in gazebo_models/"
    rm -rf gazebo_models || echo "Failed to remove gazebo_models directory, skipping..."
else
    echo "Directory gazebo_models does not exist, skipping..."
fi

# Configurar archivos de lanzamiento
echo "Processing launch files..."
LAUNCH_DEST=~/bebop_ws/src/iROS_drone/rotors_simulator/rotors_gazebo/launch
if [ -d "launch" ]; then
    mkdir -p "$LAUNCH_DEST"
    cp -r launch/* "$LAUNCH_DEST" 2>/dev/null || echo "No files found to copy in launch/"
    rm -rf launch || echo "Failed to remove launch directory, skipping..."
else
    echo "Directory launch does not exist, skipping..."
fi

# Configurar mundos de adr
echo "Processing adr_worlds..."
ADR_DEST=~/bebop_ws/src/iROS_drone/rotors_simulator/rotors_gazebo/
if [ -d "adr_worlds" ]; then
    cp -r adr_worlds "$ADR_DEST" 2>/dev/null || echo "No files found to copy in adr_worlds/"
    rm -rf adr_worlds || echo "Failed to remove adr_worlds directory, skipping..."
else
    echo "Directory adr_worlds does not exist, skipping..."
fi

# Configurar teclado
echo "Processing keyboard..."
if [ -d "keyboard" ]; then
    cp -r keyboard ~/bebop_ws/src/ 2>/dev/null || echo "No files found to copy in keyboard/"
    rm -rf keyboard || echo "Failed to remove keyboard directory, skipping..."
else
    echo "Directory keyboard does not exist, skipping..."
fi

echo "DeepPilot setup complete."
