package fileops

import (
	"fmt"
	"os/user"
	"runtime"
	"strconv"
)

// Profile of our operating system, home directory and current user
type Profile struct {
	Goos        string
	Username    string
	HomeDir     string
	DotfilesDir string
	Verbose     bool
	Full        bool // full installation
}

// Init initialises a new operating system profile
func Init(verbose bool, full bool) *Profile {
	goos := runtime.GOOS
	if verbose {
		fmt.Printf("Current operating system: %s\n", goos)
		fmt.Printf("Full installation: %s\n", strconv.FormatBool(full))
	}
	osUser, err := user.Current()
	if err != nil {
		fmt.Printf("Error: %s", err)
	}
	username := osUser.Username
	homedir := osUser.HomeDir
	if verbose {
		fmt.Printf("Current OS user is: %s\n", username)
		fmt.Printf("Current OS user's home directory is: %s\n", homedir)
	}
	return &Profile{
		Goos:        goos,
		Username:    username,
		HomeDir:     homedir,
		DotfilesDir: ".dotfiles",
		Verbose:     verbose,
		Full:        full,
	}
}
