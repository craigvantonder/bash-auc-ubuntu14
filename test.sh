#!/bin/bash

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Quit")
echo ${options[@]};exit;
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            loop=1;
            for option in ${options} ; do
              echo "$loop) $option";
              loop=$((loop+1));
            done

            ;;
        "Option 2")
            echo "you chose choice 2"
            loop=1;
            for option in ${options[@]} ; do
              echo "$loop) $option";
              loop=$((loop+1));
            done
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

