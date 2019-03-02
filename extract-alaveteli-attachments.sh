#!/bin/bash
# This script will search for attachments in an Alaveteli site's raw emails folder and save the attached files + upload them to S3.
# Depends on mpack, clamav and s3cmd. Tested on Ubuntu 18.04

#Define some variables
BASE_DIR=/home/gavin
RAW_EMAILS_DIR=$BASE_DIR/opramachine-files
OUTPUT_DIR=$BASE_DIR/files
VIRUS_DIR=$BASE_DIR/viruses
DOCUMENTS_S3_BUCKET=opramachine-documents

# Download latest OPRAmachine raw emails
s3cmd sync s3://opramachine-files $RAW_EMAILS_DIR

# Extract files from MIME attachments
echo "Extracting files from Alaveteli emails"
cd $OUTPUT_DIR
find $RAW_EMAILS_DIR -type f -name '*[1-9]' -exec munpack -f {} \;

# Extract all ZIP files
find $OUTPUT_DIR -name "*.zip" -exec unzip -j -o {} \; -exec rm {} \;

# Scan the extracted files for viruses and remove them
clamscan -r $OUTPUT_DIR --move=$VIRUS_DIR

# Upload the final documents to Amazon S3
s3cmd sync $OUTPUT_DIR/ s3://$DOCUMENTS_S3_BUCKET/