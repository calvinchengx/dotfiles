package fileops

import (
	"fmt"

	"github.com/calvinchengx/dotfiles/exec"
)

// E is a wrapper around our executor interface
type E struct {
	Exec exec.Interface
}

// CheckExists accepts a programName as string and returns whether the programName is already installed or not
func (e E) CheckExists(programName string) bool {
	path, err := e.Exec.LookPath(programName)
	if err != nil {
		fmt.Printf("%s does not exist\n", programName)
		return false
	}
	fmt.Printf("%s is at %s\n", programName, path)
	return true
}

// CheckExistsAgainstPath accepts a programName as string and returns whether prograName is installed or not and
// the path where it is installed
func (e E) CheckExistsAgainstPath(programName string) (bool, string) {
	path, err := e.Exec.LookPath(programName)
	if err != nil {
		fmt.Printf("%s does not exist\n", programName)
		return false, path
	}
	fmt.Printf("%s is at %s\n", programName, path)
	return true, path
}
