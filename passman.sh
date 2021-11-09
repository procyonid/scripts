#!/bin/sh
account=$(fd -t f --base-directory ~/.password-store/ ".*.gpg$" | rofi -theme dt-dmenu.rasi -dmenu -p "Choose: " )

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
