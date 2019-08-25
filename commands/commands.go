package commands

import (
	"github.com/urfave/cli"

	"github.com/calvinchengx/dotfiles/depsvim"
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

	// initialise OS profile
	p := fileops.Init(verbose, full)

	// data directory
	p.DataDirectory()

	// package managers
	p.PackageManagers()

	// vim and its dependencies
	p.MustInstallPackage("vim")
	p.SymlinkFilesInDirectory("dotvim")
	depsvim.PlugDependencies(p)

	// zsh and its dependencies
	p.MustInstallPackage("zsh")
	p.SymlinkFilesInDirectory("dotzsh")

	return nil
}
