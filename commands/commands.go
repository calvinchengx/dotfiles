package commands

import (
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

	p := fileops.Init(verbose, full)

	p.DataDirectory([]string{"scripts", "dotvim", "dotzsh"})
	p.BoxFiles("scripts", 0755)
	p.BoxFiles("dotvim", 0644)
	p.BoxFiles("dotzsh", 0644)

	packageManagers(p.Goos)

	vim(p.Goos, p.HomeDir)
	p.SymlinkFilesInDirectory("dotvim")
	vimPlugDependencies(p.HomeDir)

	zsh(p.HomeDir)
	p.SymlinkFilesInDirectory("dotzsh")

	return nil
}
