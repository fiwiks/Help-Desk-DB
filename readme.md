# Help Desk Database Management System (Oracle SQL)

This program is designed to run on Oracle 23ai Database virtual machine, ideally the best way to run this is to first have Oracle VirtualBox installed: [Link](https://www.virtualbox.org/wiki/Downloads)

Then download HelpDeskDB_VM.ova from the latest release: [Download](https://github.com/fiwiks/Help-Desk-DB/releases/latest).

Inside of the Oracle VirtualBox menu, select File -> Import Appliance and select the HelpDesk_VM.ova

Once installed, the web application can be run in the terminal using the command: 
  python3 ~/helpDeskDB/web/server.py 

and the command line interface using:
  cd ~/helpDeskDB/CLI/
  ./start.sh