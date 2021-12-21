#!/bin/sh

text=$1

text=$(echo $text | sed 's/[^0-9]*//g')

text=$(echo $text | tr '0' 's')
text=$(echo $text | tr '1' 't')
text=$(echo $text | tr '2' 'n')
text=$(echo $text | tr '3' 'm')
text=$(echo $text | tr '4' 'r')
text=$(echo $text | tr '5' 'l')
text=$(echo $text | tr '6' 'sh')
text=$(echo $text | tr '7' 'k')
text=$(echo $text | tr '8' 'f')
text=$(echo $text | tr '9' 'p')

echo $text
