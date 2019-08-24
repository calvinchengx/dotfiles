package commands

import (
	"fmt"
	"log"
	"os/exec"
)

func aptUpgrade() error {
	cmd := exec.Command("bash", "scripts/apt_upgrade.sh")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
