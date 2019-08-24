package commands

import (
	"fmt"
	"os"
	"path"
	"path/filepath"
)

func zsh(homedir string) {
	fmt.Printf("Symlink zsh files\n")
	var files []string

	dotvimDirname := "dotzsh"
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
