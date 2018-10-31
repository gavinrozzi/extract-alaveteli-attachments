# extract-alaveteli-attachments
## Extract files from raw email files stored by an Alaveteli instance

This script will iterate through each raw email in an Alaveteli instance, extract documents that were sent to the site by government agencies as email attachments, unzip any zip archives & output all of the files to a directory before scanning them for viruses and uploading the final documents to an Amazon S3 bucket.

[Alaveteli](https://github.com/mysociety/alaveteli) is an open source platform that allows individuals & organizations to setup Freedom of Information request websites for their local jurisdictions. I operate one for New Jesey, [OPRAmachine](https://opramachine.com). The Alaveteli software produces data from public records requests and responses that may be useful for subsequent analysis.

### How to use this script

**Usage: bash extract-alaveteli-attachments.sh**

 1. Download a copy of your Alaveteli instance's "raw_emails" folder. (Default location: /var/www/[your_alaveteli_site]/alaveteli/files/raw_emails). SFTP worked for me.
 2. Edit the variables defined at the beginning of this script to match the folders and directories in your setup. Be sure that S3cmd is configured with the appropriate access key and secret key if you wish to upload to S3.
 3. Extract all of the files collected by your Alaveteli instance.
 4. Upload the extracted files to Amazon S3