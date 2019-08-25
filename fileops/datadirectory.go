package fileops

import (
	"fmt"
	"io/ioutil"
	"os"
	"path"

	"github.com/calvinchengx/dotfiles/static"
)

// DataDirectory allows to specify subdirectories that should exist in .dotfiles folder
func DataDirectory(homedir string, subdirs []string) error {
	for _, subdir := range subdirs {
		path := path.Join(homedir, dotfilesDir, subdir)
		var fileMode os.FileMode = 0755
		err := os.MkdirAll(path, fileMode)
		if err != nil {
			return err
		}
	}
	return nil
}

// BoxFiles packages and retrieves files using packr library
// subdir can be "dotvim" or "scripts"
// perm can be 0755 or 0644
func BoxFiles(homedir string, subdir string, perm os.FileMode) {
	boxDotVim := static.PackFiles(subdir)
	files := boxDotVim.List()
	for _, file := range files {
		fileContent := boxDotVim.Bytes(file)
		filePath := path.Join(homedir, dotfilesDir, subdir, file)
		err := ioutil.WriteFile(filePath, fileContent, perm)
		if err != nil {
			fmt.Println(err)
		}
	}
}