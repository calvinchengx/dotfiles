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

	p := Init(verbose)

	fileops.DataDirectory(p.HomeDir, []string{"scripts", "dotvim", "dotzsh"})
	fileops.BoxFiles(p.HomeDir, "scripts", 0755)
	fileops.BoxFiles(p.HomeDir, "dotvim", 0644)
	fileops.BoxFiles(p.HomeDir, "dotzsh", 0644)

	packageManagers(p.Goos)

	vim(p.Goos, p.HomeDir)
	fileops.SymlinkFilesInDirectory(p.HomeDir, "dotvim", verbose)
	vimPlugDependencies(p.HomeDir)

	zsh(p.HomeDir)
	fileops.SymlinkFilesInDirectory(p.HomeDir, "dotzsh", verbose)

	return nil
}
