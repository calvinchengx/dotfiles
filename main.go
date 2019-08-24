package main

import (
	"log"
	"os"

	"github.com/calvinchengx/dotfiles/commands"
	"github.com/urfave/cli"
)

func main() {
	app := cli.NewApp()
	app.Name = "dotfiles"
	app.Usage = "command line tool to manage my dotfiles"
	app.Version = "0.0.1"
	app.Flags = commands.Flags
	app.Action = commands.Setup

	err := app.Run(os.Args)

	if err != nil {
		log.Fatal(err)
	}
}
