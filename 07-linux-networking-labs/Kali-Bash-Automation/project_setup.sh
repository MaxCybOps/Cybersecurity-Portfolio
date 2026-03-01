#!/bin/bash
# =============================================================================
# Script Name : project_setup.sh
# Author      : Ogbodo Uchenna Maxwell (@MaxCybOps)
# Description : Automates creation of standardized security project folder
#               structure with correct permissions in Kali Linux.
# Usage       : chmod +x project_setup.sh && ./project_setup.sh
# =============================================================================

create_project_structure() {
  BASE_PATH=$1
  PROJECT_NAME=$2

  echo "[*] Creating project structure for '$PROJECT_NAME' in '$BASE_PATH'..."

  DIRS=(
    "$BASE_PATH/$PROJECT_NAME"
    "$BASE_PATH/$PROJECT_NAME/docs"
    "$BASE_PATH/$PROJECT_NAME/src"
    "$BASE_PATH/$PROJECT_NAME/tests"
    "$BASE_PATH/$PROJECT_NAME/config"
    "$BASE_PATH/$PROJECT_NAME/data/raw"
    "$BASE_PATH/$PROJECT_NAME/data/processed"
    "$BASE_PATH/$PROJECT_NAME/logs"
  )

  for DIR in "${DIRS[@]}"; do
    mkdir -p "$DIR" && chmod 755 "$DIR"
    echo "[+] Created and secured: $DIR"
  done

  echo ""
  echo "[✓] Project structure created successfully."
  find "$BASE_PATH/$PROJECT_NAME" -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
}

echo "============================================="
echo "  Kali Linux Project Setup — @MaxCybOps"
echo "============================================="
echo ""
echo "Enter base directory path (e.g., /home/user/projects):"
read BASE_PATH
echo "Enter project name:"
read PROJECT_NAME

if [ -z "$BASE_PATH" ] || [ -z "$PROJECT_NAME" ]; then
  echo "[!] Error: Base path and project name cannot be empty."
  exit 1
fi

if [ ! -d "$BASE_PATH" ]; then
  echo "[!] Base path does not exist. Creating it..."
  mkdir -p "$BASE_PATH" && chmod 755 "$BASE_PATH"
fi

create_project_structure "$BASE_PATH" "$PROJECT_NAME"

