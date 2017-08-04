#!/bin/sh
#
# Copyleft 2017.
#
while true; do
    printf "\033[1;97mL/R/I(inverted)/N(normal)? (Y/N)\033[0m "
    read x
    case $x in
        [Ll] ) y="left"; break;;
        [Rr] ) y="right"; break;;
        [Ii] ) y="inverted"; break;;
        [Nn] ) y="normal"; break;;
    esac
done
z=$(xrandr -q | grep -Po ".*(?= connected)")
xrandr --output $z --rotate $y
