#!/usr/bin/env bash

terminal_spawner_bin="/usr/local/bin/terminal-spawner"
should_remove_existing_bin='Y'

prompt_existing_bin_file() {
    read -p 'Detected an existing terminal_spawner bin file. Would you like to remove the existing setup and continue? (Y/n): ' should_remove_existing_bin

   if [[ -z $should_remove_existing_bin ]]; then
        should_remove_existing_bin='Y'
   fi
}

create_terminal_spawner_bin() {
    echo "Creating terminal-spawner executable..."
    touch $terminal_spawner_bin

    echo "#!/usr/bin/env bash" >> $terminal_spawner_bin
    cat "$(pwd)/terminal-spawner.sh" >> $terminal_spawner_bin

    echo "Setting permissions..."
    chmod +x $terminal_spawner_bin
}

if [ -f "$terminal_spawner_bin" ]; then
   prompt_existing_bin_file

  if [[ $should_remove_existing_bin =~ [^nN] ]]; then
        rm -rf $terminal_spawner_bin
        create_terminal_spawner_bin
        echo "Completed setup!"
  else
        echo "Exiting setup. Existing ${terminal_spawner_bin} is unmodified."
  fi 
else
  create_terminal_spawner_bin
fi

