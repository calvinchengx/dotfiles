package commands

import (
	"fmt"
	"os/user"
	"runtime"

	"github.com/urfave/cli"
)

var full bool

// Flags define available flags for our command line tool
var Flags = []cli.Flag{
	cli.BoolTFlag{
		Name:        "full, f",
		Usage:       "Specify whether to execute a full installation or not, defaults to true",
		Destination: &full,
	},
}

// Setup is the function that executes the installation of dotfiles in our current OS
func Setup(c *cli.Context) error {
	goos := runtime.GOOS
	fmt.Println("Current operating system:", goos)
	fmt.Println("Full installation:", full)
	osUser, err := user.Current()
	if err != nil {
		return err
	}
	username := osUser.Username
	homedir := osUser.HomeDir
	fmt.Println("Current OS user is:", username)
	fmt.Println("Current OS user's home directory is:", homedir)

	packageManagers(goos)

	vim(goos, homedir)

	return nil
}
