# UbuntuCreator
A little bash-script for remastering of live-cds/dvds 

## Important
- **Do not delete the UbuntuCreator directory after installation**
- Use the uninstaller script for instead

## Steps to setup the program
- Install the program by running: `sudo bash ./install.sh`
This will setup the $PATH variable correctly and install some neccesary tools for the image generation

- Restart your terminal to refresh the changed $PATH

## Use UbuntuCreator
- Download yourself an iso file from a recent (**LIVE**) Ubuntu or Ubuntu flavour version ( **not Netboot** )

- Simply to start the program by typing `sudo /PATH/TO/UbuntuCreator/bin/ucreator`

- Confirm the Message at startup with "OK"
- Enter the information that is asked for

- And it will do its job
- When ist at 55 % it chroots into the iso, which means you can modify files and install and remove packages and stuff.
  To continue just type `exit`.

- When `ucreator` exits it leaves the finished iso in the project folder behind.
  This is your new **OS**
  **Y**a**a**a**y**
