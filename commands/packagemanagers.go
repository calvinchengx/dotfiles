package commands

import (
	"fmt"
	"log"
	"os/exec"
)

func packageManagers(goos string) {
	switch goos {
	case "darwin":
		if checkExists("brew") {
			homeBrewUpdate()
		} else {
			homeBrewInstall()
		}
	case "linux":
	default:
	}
}

func homeBrewUpdate() error {
	cmd := exec.Command("brew", "update")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}

func homeBrewInstall() error {
	fmt.Printf("Installing homebrew\n")
	cmd := exec.Command("bash", "scripts/homebrew.sh")
	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf(string(out))
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
