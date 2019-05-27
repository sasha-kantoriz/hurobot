#!/bin/bash


action=$1
device=$2


case $action in
	enable)
		crontab -l | sed "/^#.*${device}*/s/^#//" | crontab -
		;;
	disable)
		crontab -l | sed "/^[^#].*${device}*/s/^/#/" | crontab -
		;;
	*)
		echo 'Sorry, unknown command, "enable" or "disable" are supported'
		;;
esac

crontab -l

