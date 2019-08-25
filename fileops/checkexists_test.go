package fileops_test

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/calvinchengx/dotfiles/exec/testingexec"
	"github.com/calvinchengx/dotfiles/fileops"
)

func TestCheckExists(t *testing.T) {

	assert := assert.New(t)

	fakeLookPathFunc := func(file string) (string, error) {
		if file == "sh" {
			return "/bin/sh", nil
		}
		err := fmt.Errorf("No such file %s", file)
		return "", err
	}

	e := fileops.E{
		Exec: &testingexec.FakeExec{
			LookPathFunc: fakeLookPathFunc,
		},
	}

	exist := e.CheckExists("sh")
	assert.Equal(exist, true, "exist is true")
}

func TestCheckExistsAgainstPath(t *testing.T) {

	assert := assert.New(t)

	fakeLookPathFunc := func(file string) (string, error) {
		if file == "sh" {
			return "/bin/sh", nil
		}
		err := fmt.Errorf("No such file %s", file)
		return "", err
	}

	e := fileops.E{
		Exec: &testingexec.FakeExec{
			LookPathFunc: fakeLookPathFunc,
		},
	}

	exist, path := e.CheckExistsAgainstPath("sh")
	assert.Equal(true, exist, "exist is true")
	assert.Equal("/bin/sh", path, "Path is at %s", path)

}
