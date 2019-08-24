package commands

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path"
	"path/filepath"
)

func vim(goos string, homedir string) {
	switch goos {
	case "darwin":
		exist, path := checkExistsWithPath("vim")
		install := exist == false || exist == true && path != "/usr/local/bin/vim"
		if install {
			vimInstallWith("brew")
		}
		vimrcFiles(homedir)
	case "linux":
	default:
	}
}

func vimInstallWith(packageManagerName string) error {
	fmt.Printf("Install vim\n")
	cmd := exec.Command(packageManagerName, "install", "vim")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}

func vimrcFiles(homedir string) {
	fmt.Printf("Symlink vimrc files\n")
	var files []string

	root, _ := os.Getwd()
	dotvimDirname := "dotvim"
	dotvimDir := path.Join(root, dotvimDirname)
	err := filepath.Walk(dotvimDir, func(path string, info os.FileInfo, err error) error {
		// exclude the directory itself
		if filepath.Base(path) != dotvimDirname {
			files = append(files, path)
		}
		return nil
	})

	if err != nil {
		panic(err)
	}

	for _, source := range files {
		target := path.Join(homedir, filepath.Base(source))
		fmt.Printf("%s symlinked to %s\n", target, source)
		os.Symlink(source, target)
	}
}
