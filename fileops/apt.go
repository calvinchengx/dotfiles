package fileops

import (
	"fmt"
	"log"
	"os/exec"
	"path"
)

func (p *Profile) aptUpgrade() error {
	pathString := path.Join(p.HomeDir, p.DotfilesDir, "scripts", "apt_upgrade.sh")
	cmd := exec.Command("bash", pathString)
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
