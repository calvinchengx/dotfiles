package fileops

import (
	"fmt"
	"os/exec"
)

// CheckExists accepts a programName as string and returns whether the programName is already installed or not
func CheckExists(programName string) bool {
	path, err := exec.LookPath(programName)
	if err != nil {
		fmt.Printf("%s does not exist\n", programName)
		return false
	}
	fmt.Printf("%s is at %s\n", programName, path)
	return true
}

// CheckExistsAgainstPath accepts a programName as string and returns whether prograName is installed or not and
// the path where it is installed
func CheckExistsAgainstPath(programName string) (bool, string) {
	path, err := exec.LookPath(programName)
	if err != nil {
		fmt.Printf("%s does not exist\n", programName)
		return false, path
	}
	fmt.Printf("%s is at %s\n", programName, path)
	return true, path
}
