#!/bin/bash
# Copyright (C) 2018 Gavin C. Rozzi. Released under the GNU GPLv3 license.
# This script will extract attchments from the raw_emails folder of an Alaveteli instance (RAW_EMAILS_DIR) and save the files to OUTPUT_DIR.
# Depends on mpack, clamav. Tested on Ubuntu 18.04

# Define some variables (change these to match your setup)
RAW_EMAILS_DIR=/home/gavin/Documents/raw_emails
OUTPUT_DIR=/home/gavin/Documents/OPRAmachine-dev/files
VIRUS_DIR=/home/gavin/Documents/OPRAmachine-dev/viruses

# Extract files from MIME attachments
echo "Extracting files from OPRAmachine emails"
cd $OUTPUT_DIR
find $RAW_EMAILS_DIR -type f -name '*[1-9]' -exec munpack -f {} \;

# Extract all ZIP files
find $OUTPUT_DIR -name "*.zip" -exec unzip -j -o {} \; -exec rm {} \;

# Scan the extracted files for viruses and store them in VIRUS_DIR
clamscan -r $OUTPUT_DIR --move=$VIRUS_DIR