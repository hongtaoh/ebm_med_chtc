#!/bin/bash
set -e  # Exit immediately on error

# Logging
echo "eval_cp.sh started at $(date)"
echo "Running in directory: $(pwd)" 
echo "Running with arguments: $@"

# 🚨 Cleanup Temporary Files
echo "Cleaning temporary files..."
rm -rf /tmp/* /var/tmp/* || echo "Warning: Could not clean all temp files."

# Create necessary directories
mkdir -p conjugate_priors/{logs,records,heatmaps,traceplots,results}

# Try to extract the virtual environment
if [[ -f "venv.tar.gz" ]]; then
    echo "Extracting virtual environment..."
    if tar -xzf venv.tar.gz; then
        echo "Virtual environment extracted successfully."
    else
        echo "Failed to extract venv. Will fall back to system Python."
        VENV_BROKEN=true
    fi
else
    echo "venv.tar.gz not found. Will fall back to system Python."
    VENV_BROKEN=true
fi

# Decide which Python to use
if [[ -z "$VENV_BROKEN" ]]; then
    # Try activating the virtual environment
    source venv/bin/activate
    PYTHON_EXEC=./venv/bin/python
else
    echo "Using system Python as fallback."
    PYTHON_EXEC=$(which python3)
fi

# Verify alabebm installation
if ! $PYTHON_EXEC -c "from alabebm import run_ebm" &> /dev/null; then
    echo "alabebm not found. Installing..."
    $PYTHON_EXEC -m pip install alabebm --no-cache-dir || { echo "Failed to install alabebm"; exit 1; }
else
    echo "alabebm is already installed."
fi

# Extract data if available
if [[ -f "data.tar.gz" ]]; then
    tar -xzf data.tar.gz
else
    echo "Warning: data.tar.gz not found. Skipping extraction."
fi

# List files for debugging
echo "Files present:"
ls -l

# Run the Python script using the selected Python interpreter
$PYTHON_EXEC ./eval_cp.py "$@"

# Log completion
echo "Script completed at $(date)"
