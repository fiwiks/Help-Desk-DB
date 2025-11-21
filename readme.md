# Help Desk Database Management System (Oracle SQL)

This program is designed to run on Oracle 23ai Database virtual machine, ideally the best way to run this is to first have Oracle VirtualBox installed: [Link](https://www.virtualbox.org/wiki/Downloads)

Then download HelpDeskDB_VM.ova from the drive: [Download](https://drive.google.com/drive/folders/1kv6Qkz2sFo0lAaITq9f-iJ1rSAutlLwf?usp=sharing).

Inside of the Oracle VirtualBox menu, select File -> Import Appliance and select the HelpDesk_VM.ova

Once installed, the web application can be run from inside the VM, in the terminal, using the command: <br>
  python3 ~/helpDeskDB/web/server.py 

and the command line interface using:<br>
  cd ~/helpDeskDB/CLI/<br>
  ./start.sh

If you are for some reason unable to launch the VM image, go into the VM settings -> Network, and uncheck Enable Network Adapter for all adapters.