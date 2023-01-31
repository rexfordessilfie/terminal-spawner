
#!/bin/bash
num_args=$#
args=("$@")
BEGINS_WITH_HYPHEN='^-'
CURRENT_DIRECTORY="$(pwd)"

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

OTPION_NOT_FOUND_MESSAGE="${RED}error:${ENDCOLOR} terminal-spawner: Option not found. Use -h flag to view manual.\n"

main(){
  if [[ $num_args == 0 ]]; then
      printf "${RED}error:${ENDCOLOR} terminal-spawner: No inputs specified. Use -h flag to view manual.\n"
  elif [[ "${args[0]}" =~ $BEGINS_WITH_HYPHEN ]]; then
    
    if [[ "${args[0]}" == "-h" || "${args[0]}" == '--help' ]]; then
      instructions

    elif [[ "${args[0]}" == '-l' || "${args[0]}" == '--location' ]]; then
        bash_script="${args[2]}"
        final_script="cd ${args[1]}; $bash_script"
    
    execute "$final_script" "$bash_script"

    else
      printf "${RED}error:${ENDCOLOR} terminal-spawner: Option not found. Use -h flag to view manual.\n"
    fi

  else
    bash_script="${args[0]}"
    final_script="cd $CURRENT_DIRECTORY; $bash_script"
    execute "$final_script" "$bash_script"
  fi
}
# Script Manual
instructions(){
    printf "\nUsage:\n"
    printf "\tterminal-spawner [-options] '<command>', where <command> is executed in the current directory by default. To override, use the -l flag."
    printf "\nOptions:\n"
    printf "\t-h, --help: show manual\n"
    printf "\t-l, --location: specify directory in which <command> should be run\n"
    printf "Examples:\n"
    printf "\tterminal-spawner -h\n\t\tShows the manual for this script.\n"
    printf "\tterminal-spawner 'npm start'\n\t\tOpens a new terminal and runs 'npm start' in the current directory\n"
    printf "\tterminal-spawner -l ~/Desktop/myProject 'npm start'\n\t\tOpens a new terminal and runs 'npm start' in the '~/Desktop/myProject' directory\n"
}

# Execute Script in New Terminal
execute(){
  osascript -e 'on run {myScript}
    tell application "Terminal"
      do script myScript
    end tell
  end run' "$1"
  printf "${GREEN}success:${ENDCOLOR} terminal-spawner: Opened new terminal opened with comand '$2'.\n"
}


main $num_args $args