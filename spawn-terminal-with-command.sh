
#!/bin/bash
numArgs=$#
args=("$@")
BEGINS_WITH_HYPHEN='^-'
CURRENT_DIRECTORY=$PWD

main(){
  if [[ $numArgs == 0 ]]; then
      echo "\033[1;31merror:\033[0m ./spawn-terminal-with-command.sh: No inputs specified. Use -h flag to view manual."
  elif [[ "${args[0]}" =~ $BEGINS_WITH_HYPHEN ]]; then
    if [[ "${args[0]}" == "-h" || "${args[0]}" == '--help' ]]; then
      instructions

    elif [[ "${args[0]}" == '-l' || "${args[0]}" == '--location' ]]; then
        bashScript="${args[2]}"
        finalScript="cd ${args[1]}; $bashScript"
    execute "$finalScript" "$bashScript"

    else
      echo "\033[1;31merror:\033[0m ./spawn-terminal-with-command.sh: Option not found. Use -h flag to view manual."
    fi
  else
    bashScript="${args[0]}"
    finalScript="cd $CURRENT_DIRECTORY; $bashScript"
    execute "$finalScript" "$bashScript"
  fi

  return 0
}
# Script Manual
instructions(){
    echo "\n\033[0mUsage:\033[0m ./spawn-terminal-with-command.sh [-options] '<command>'. <command> is executed in the current directory by default. To override, use the -l flag."
    echo "\n\033[0mOptions:\033[0m"
    echo " \t-h, --help: show manual"
    echo "\t-l, --location: specify directory in which <command> should be run"
    echo "\n\033[0mExamples:\033[0m"
    echo "\t./spawn-terminal-with-command.sh -h\n\t\tShows the manual for this script.\n"
    echo "\t./spawn-terminal-with-command.sh 'npm start'\n\t\tOpens a new terminal and runs 'npm start' in the current directory\n"
    echo "\t./spawn-terminal-with-command.sh -l ~/Desktop/myProject 'npm start'\n\t\tOpens a new terminal and runs 'npm start' in the '~/Desktop/myProject' directory\n"
}

# Execute Script in New Terminal
execute(){
  osascript -e 'on run {myScript}
    tell application "Terminal"
      do script myScript
    end tell
  end run' "$1"
  echo "\033[1;32msuccess:\033[0m ./spawn-terminal-with-command.sh: Opened new terminal opened with comand '$2'."
}


main $numArgs $args

# Troubleshoot
  # You might have to give this file permissions using 'chmod +x spawn-terminal-with-command.sh'

# Resources
  # Formatting in bash: https://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
  # Colors in bash: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  # Using C-like arguments: https://stackoverflow.com/questions/2740906/how-to-access-command-line-arguments-of-the-caller-inside-a-function
  # Passing shell variables to osascript: https://apple.stackexchange.com/questions/266695/how-to-pass-variables-from-bash-script-to-applescript
