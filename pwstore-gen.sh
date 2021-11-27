#!/bin/sh

keepassxc-cli export -f csv $1 | grep '^"Root/' | awk -F'","' '{print $2, ";", $3, ";", $4, ";", $7}' | while IFS=";" read -r domain user pw otp; do
    domain=`echo $domain`
    user=`echo $user`
    pw=`echo $pw`
    otp=`echo $otp`

    #echo "domain:'$domain'"
    #echo "user:'$user'"
    #echo "pw:'$pw'"
    #echo "otp:'$otp'"

    if [[ -n "$user" ]]; then
        path="$domain/$user"
    else
        path="$domain"
    fi
    echo "Inserting password for '$path'"
    echo -e "$pw\n$pw" | pass insert "pw/$path"

    if [[ -n "$otp" ]]; then
        echo "Inserting otp for '$path'"
        echo "$otp" | pass otp insert "otp/$path"
    fi
done
