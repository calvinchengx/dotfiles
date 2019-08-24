package commands

import (
	"fmt"
	"os/exec"
)

func checkExists(programName string) bool {
	path, err := exec.LookPath(programName)
	if err != nil {
		fmt.Printf("%s does not exist\n", programName)
		return false
	}
	fmt.Printf("%s is at %s\n", programName, path)
	return true
}
