# terminal-spawner
This is a shell script that can be used to run a command in a new macOS terminal.

This tool is useful for chaining commands, involving some blocking commands that take control of the terminal, but need to occur before some other command. 

For example starting up metro-bundler before building and running a React Native application on iOS.

# Usage
First, run `bash setup.sh` to make the script executable.

> Without this step, you will need to run the script with `bash terminal-spawner.sh` instead of just `terminal-spawner`. And you will need to provide permissions to the script every time you run it, with `chmod +x terminal-spawner.sh`.

## Basic
Run command in a new terminal in the current directory

eg. `terminal-spawner "npm start"`

## With Location
Use `-l` or `--location` to specify location to run new command in

eg. `terminal-spawner -l ~/Documents/AwesomeProject "npm start"`

## Chaining Commands
You may chain a blocking command like this:

`terminal-spawner "npm start"; npx react-native run-ios`

## Help
Use `-h` or `--help` flag to get help

`terminal-spawner -h`
