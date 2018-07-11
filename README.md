# sailfish-autobackup

Execute a backup in the Sailfish OS Settings app, even if the screen is bust

## Purpose

This script and related files is for use on Jolla SailfishOS devices. It patches the setting backup application to allow backups to be performed from the command line over SSH. There are only a few situations when you'll want to do this, but one of them might be if you drop your phone, smash the screen, can still SSH into the device and want to transfer everything to a new working phone.

## Background

I recently dropped my Xperia X, cracking the screen and making my device unusable. Although I regularly use the built in backup tool to backup my files, contacts, accounts and so on, my most recent backup was a month old, and I wanted to get something fresher.

With the screen completely borked, manually performing the steps to trigger the backup was out of the question. There almost certainly is a way to perform the backup using a console command, something like `vault -a export ...`, but I couldn't figure out what it should be. This script is therefore an alternative approach. It patches the QML files of the settings application to automatically trigger a backup using whatever the current settings are.

## Use at your own risk

This script hacks around with the settings QML files. It's been designed so you can revert the changes, but it's not particularly robust. I've tried it a couple of times out of necessity. It did the job, but that's all. **You use this at our own risk**.

## Usage instructions

The instructions are a bit fiddly and have to be followed carefully. However, hopefully you won't need to do this very often!

1. Copy the scripts onto the device where you want to perform the backup (cloning the git repo to the device would be one way to do this).
2. SSH into the device from another machine. We'll call this session Console 0.
3. In a separate window, SSH into the device *again*. We'll call this Console 1. You should now have two consoles.
4. On **both consoles**, `cd` to the folder containing the `autobackup.sh` script.
5. On **console 0** enter `devel-su ./autobackup.sh` and select option 1 "Install patch".
6. On **console 1** enter `devel-su -p ./autobackup.sh` and select option 2 "Execute jolla-settings". You'll see the output from the executing Settings application in this console from now on.
7. On **console 0** enter `devel-su ./autobackup.sh` and select option 3 "Trigger backup". Back on console 1 you should be able to observe the backup taking place. It can take a while so don't panic: there's a coded 10 second delay before the backup is triggered.
8. On **console 1** you'll see `[D] expression for onDone:144 - Backup completed` once the backup process has finished. At this point you can quit the Settings app by typing `Ctrl-C`.
9. On **console 0** enter `devel-su ./autobackup.sh` and select option 4. This will revert the patch and leave the Settings app as it was before.

The last step is really important. If you don't do this, you'll leave your Settings app in a broken state. If something goes wrong, always finish with this last step of reverting the patch. If you execute option 4 more than once it will notice and won't do anything.

Once you've done this, you should have a fresh backup that you can SCP off your device.

## Queries

If you have any queries about this, contact me, David Llewellyn-Jones, here:

Email: david@flypig.co.uk

Website: http://www.flypig.co.uk

