#!/bin/sh
account=$(fd -t f --base-directory ~/.password-store/ ".*.gpg$" | grep -v "protonmail-credentials" | cut -c 3- | rofi -theme dt-dmenu.rasi -dmenu -p "Choose: " )

[ -z "$account" ] && exit

account=$(echo $account | sed 's/\.gpg$//' )

case $account in
	"otp/"*)
		pass otp -c "$account"
		;;
	*)
		pass -c "$account"
		;;
esac
