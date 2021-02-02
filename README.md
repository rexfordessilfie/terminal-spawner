# terminal-spawner
This is a shell script that can be used to run a command in a new macOS terminal.

This tool is useful for chaining commands, involving some blocking commands that take control of the terminal, but need to occur before some other command. 

For example starting up metro-bundler before building and running a React Native application on iOS.

## Usage
### Basic Usage
Run command in a new terminal in the current directory
eg. `bash spawn-terminal-and-run.sh "npm start"`

### With Location
Use `-l` or `--location` to specify location to run new command in
`bash spawn-terminal-and-run.sh -l "<location>" "<command>"`

### Help
Use `-h` or `--help` flag to get help
`bash spawn-terminal-and-run.sh -l "<location>" "<command>"`
