#!/bin/bash
#
# Dev script to compile python packages from a requirements.in file to a requirements.txt file.
set -e
path_to_requirements="setup"
RELATIVE_SCRIPTPATH="$(dirname -- "${BASH_SOURCE[0]}")"
SCRIPT_NAME=$(basename "$0")
OUTPUT_FILE="requirements.txt"

# Update and install packages used to compile requirements
echo -e "🛠 upgrading python package management tools"
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pip-tools wheel

# Delete existing requirements file to ensure full dependency resolution
echo -e "🛠 deleting ${path_to_requirements}/requirements-dev.txt"
rm -f ${path_to_requirements}/requirements-dev.txt

# Compile requirements
echo -e "🛠 compiling from ${path_to_requirements}/requirements.in and ${path_to_requirements}/requirements-dev.in"
CUSTOM_COMPILE_COMMAND="${RELATIVE_SCRIPTPATH}/${SCRIPT_NAME} ${path_to_requirements}" python3 -m piptools compile --output-file=${path_to_requirements}/${OUTPUT_FILE} ${path_to_requirements}/requirements.in ${path_to_requirements}/requirements-dev.in
echo -e "✅ done compiling ${path_to_requirements}/${OUTPUT_FILE}"
