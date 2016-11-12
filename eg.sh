#!/bin/bash

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Quit")

function show_menu {

  select option in "${options[@]}"; do
    echo $option
    break
  done
}

while true; do
  option=$(show_menu)

  if [[ $option == "Quit" ]]; then
    break
  fi
done
