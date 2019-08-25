package commands

import (
	"fmt"
	"os/user"
	"runtime"

	"github.com/urfave/cli"

	"github.com/calvinchengx/dotfiles/fileops"
)

const dotfilesDir = ".dotfiles"

var (
	full    bool
	verbose bool
)

// Flags define available flags for our command line tool
var Flags = []cli.Flag{
	cli.BoolTFlag{
		Name:        "full, f",
		Usage:       "Specify whether to execute a full installation or not, defaults to true",
		Destination: &full,
	},
	cli.BoolFlag{
		Name:        "verbose, vv",
		Usage:       "Specify whether to execute with verbosity, defaults to false",
		Destination: &verbose,
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

	fileops.DataDirectory(homedir, []string{"scripts", "dotvim", "dotzsh"})
	fileops.BoxFiles(homedir, "scripts", 0755)
	fileops.BoxFiles(homedir, "dotvim", 0644)
	fileops.BoxFiles(homedir, "dotzsh", 0644)

	packageManagers(goos)

	vim(goos, homedir)
	fileops.SymlinkFilesInDirectory(homedir, "dotvim", verbose)
	vimPlugDependencies(homedir)

	zsh(goos)
	fileops.SymlinkFilesInDirectory(homedir, "dotzsh", verbose)

	return nil
}
