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
		install := checkExists("vim") == false
		if install {
			vimInstallWith("apt")
		}
		vimrcFiles(homedir)
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

	dotvimDirname := "dotvim"
	dotvimDir := path.Join(homedir, dotfilesDir, dotvimDirname)
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
		if _, err := os.Lstat(target); err == nil {
			if err := os.Remove(target); err != nil {
				fmt.Printf("failed to unlink: %+v", err)
			}
		} else if os.IsNotExist(err) {
			fmt.Printf("failed to check symlink: %+v", err)
		}
		// execute symlink
		os.Symlink(source, target)
	}
}

func vimPlugDependencies(homedir string) error {
	fmt.Printf("Install vim's plug dependencies\n")
	filePath := path.Join(homedir, dotfilesDir, "scripts", "vimplug_install.sh")
	cmd := exec.Command("bash", filePath)
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
