

draw_list() {
  RED='\033[0;31m'
  CL='\033[0m'

  # Get arguments
  declare -a array=("${!1}")

  # Draw
  for k in "${!array[@]}"; do
    if [ "$2" -eq "$k" ]; then
      # Clear line
      #echo -en "\033[K"
      # Print
      echo -en "$RED${array[$k]} \n \r"
    else
      # Clear line
      #echo -en "\033[K"
      # Print
      echo -en "$CL${array[$k]} \n \r"
    fi
  done

  # Clear formatting
  echo -en "$CL"
}

clear_list() {
  # Get arguments
  declare -a array=("${!1}")

  # Draw
  for k in "${!array[@]}"; do
    # Clear line
    #echo -en "\033[K"
    # Move cursor up
    echo -en "\033[1A"
  done
}

get_cursor() {
  # Send ANSI command
  echo -en '\033[6n'

  # Read
  read -sdR CURPOS

  # Extract value
  CURPOS=${CURPOS#*[}
  _GUT_CURSOR=$(echo $CURPOS | awk -F';' '{print $1}')
}

get_input() {
  # Get arguments
  declare -a array=("${!1}")
  # echo ${array[@]} # List array contents
  # echo "${#array[@]}" # List size of array

  # Set mix/max
  let i=0;
  let min=0;
  let max="${#array[@]} - 1"

  # Get cursor position
  get_cursor

  # Turn cursor off
  echo -en "\033[?25l"

  while true
  do
    # User input logic
    if [ "$input" = "A" ]; then
      if [ "$i" -gt "$min" ]; then
        (( i -= 1 ))
      fi
    fi
    if [ "$input" = "B" ]; then
      if [ "$i" -lt "$max" ]; then
        (( i += 1 ))
      fi
    fi

    # Draw list
    draw_list array[@] $i

    # Read input
    read -r -sn1 input

    # Read selection (This is after the read to prevent early termination)
    if [ "$input" = "" ]; then
      _GUT_SELECTION=$i
      _GUT_SELECTION_TEXT="${array[$i]}"

      break
    fi

    # Reset cursor
    clear_list array[@]
    #echo -en "\033[$_GUT_CURSOR;1f"
  done

  # Turn cursor on
  echo -en "\033[?25h"
}

ls_dir() {
  dirs=( $( ls ) )

  get_input dirs[@]

  echo "Selected: $_GUT_SELECTION_TEXT"
}
