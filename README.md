GTFOBins Binaries Checker

Description
------------
This script checks the installation status of binaries listed in the GTFOBins repository (https://gtfobins.github.io/) by fetching the relevant markdown files from GitHub. It provides a summary of installed and missing binaries, making it easy to verify your system's capabilities.

Features
--------
- Fetches a list of binaries from the GTFOBins GitHub repository.
- Checks if each binary is installed on the local system.
- Generates a detailed report summarizing the results.

Prerequisites
-------------
- Git: Ensure Git is installed on your system.
- Curl: The script uses `curl` to fetch data from GitHub.
- jq: This script requires `jq` for parsing JSON data. Install it using:
  sudo apt-get install jq

Usage
-----
1. Clone this repository or download the script to your local machine.
2. Open a terminal and navigate to the directory containing the script.
3. Make the script executable:
   chmod +x check_binaries.sh
4. Run the script:
   ./check_binaries.sh

Output
------
The results will be saved in a file named gtfo-bin-check-results.txt. This file will contain:
- A list of binaries checked.
- Status of each binary (installed or not installed).
- A summary of the total checked binaries.

Example
-------
Fetching the list of binaries from GitHub...

Total binaries found: 10

✔ Binary 'ssh' is installed.

✖ Binary 'telnet' is NOT installed.

Total binaries checked: 10

Summary of results:

Installed binaries: 8

Missing binaries: 2

Contribution
------------
Feel free to fork this repository and submit pull requests for any enhancements or bug fixes.

License
-------
This project is licensed under the MIT License. See the LICENSE file for details.

Author
------
Darpan Katarya - darpan-97
