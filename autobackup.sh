#!/bin/bash

PS3='Please enter your choice: '
options=("Install patch" "Execute jolla-settings" "Trigger backup" "Revert patch" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install patch")
            echo "Install QML file patches"

            if [ -f MainPage.qml.orig ] || [ -f NewBackupRestoreDialog.qml.orig ]; then
                echo "Patch already installed"
            else
                cp -p -v /usr/lib/qt5/qml/Sailfish/Vault/MainPage.qml MainPage.qml.orig
                cp -p -v /usr/lib/qt5/qml/Sailfish/Vault/NewBackupRestoreDialog.qml NewBackupRestoreDialog.qml.orig
                cp -f -p -v MainPage.qml.new /usr/lib/qt5/qml/Sailfish/Vault/MainPage.qml
                cp -f -p -v NewBackupRestoreDialog.qml.new /usr/lib/qt5/qml/Sailfish/Vault/NewBackupRestoreDialog.qml
                echo "Patch installed"
            fi
            break
            ;;
        "Execute jolla-settings")
            echo "Execute jolla-settings"
            jolla-settings
            echo "Executed jolla-settings"
            break
            ;;
        "Trigger backup")
            echo "Trigger backup (jolla-settings must be running in a separate console first)"
            dbus-send --type=method_call --dest=com.jolla.settings /com/jolla/settings/ui com.jolla.settings.ui.showPage string:"system_settings/system/backup"
            echo "Triggered. Follow progress on separate console."
            break
            ;;
        "Revert patch")
            echo "Revert QML file patches"
            if [ ! -f MainPage.qml.orig ] || [ ! -f NewBackupRestoreDialog.qml.orig ]; then
                echo "Patch not yet installed"
            else
                mv -f -v MainPage.qml.orig /usr/lib/qt5/qml/Sailfish/Vault/MainPage.qml
                mv -f -v NewBackupRestoreDialog.qml.orig /usr/lib/qt5/qml/Sailfish/Vault/NewBackupRestoreDialog.qml
                echo "Patch reverted"
            fi
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done




