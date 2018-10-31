# extract-alaveteli-attachments

This script will iterate through each raw email in an Alaveteli instance, extract documents that were sent to the site by government agencies as email attachments, unzip any zip archives & output all of the files to a directory. Once the files are extracted to the output directory, ClamAV scans the documents and moves any detected viruses to a folder defined in the script.

[Alaveteli](https://github.com/mysociety/alaveteli) is an open source platform that allows individuals & organizations to setup Freedom of Information request websites for their local jurisdictions. I operate one for New Jesey, [OPRAmachine](https://opramachine.com). The Alaveteli software produces data from public records requests and responses that may be useful for subsequent analysis.

## How to use this script
 1. Download a copy of your Alaveteli instance's "raw_emails" folder. (Default location: /var/www/[your_alaveteli_site]/alaveteli/files/raw_emails). SFTP worked for me.
 2. Edit the variables defined at the beginning of this script to match the folders and directories in your setup.
 3. Extract all of the files collected by your Alaveteli instance!

Alaveteli stores files in the form of numeric files in related numeric subfolders of the 