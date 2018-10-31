#!/bin/bash
# This script will search for attachments in an Alaveteli site's raw emails folder and save the attached files + upload them to S3.
# Depends on mpack, clamav and s3cmd. Tested on Ubuntu 18.04

#Define some variables
RAW_EMAILS_DIR=/home/gavin/Documents/raw_emails
OUTPUT_DIR=/home/gavin/Documents/OPRAmachine-dev/files
VIRUS_DIR=/home/gavin/Documents/OPRAmachine-dev/viruses
S3_BUCKET=opramachine-documents

# Extract files from MIME attachments
echo "Extracting files from Alaveteli emails"
cd $OUTPUT_DIR
find $RAW_EMAILS_DIR -type f -name '*[1-9]' -exec munpack -f {} \;

# Extract all ZIP files
find $OUTPUT_DIR -name "*.zip" -exec unzip -j -o {} \; -exec rm {} \;

# Scan the extracted files for viruses and remove them
clamscan -r $OUTPUT_DIR --move=$VIRUS_DIR

# Upload the final documents to Amazon S3
s3cmd sync $OUTPUT_DIR/ s3://$S3_BUCKET/