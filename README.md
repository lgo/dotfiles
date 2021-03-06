# Usage

### Organization

Dotfiles are split up into folders called _topics_. Each topic folder has as _topics.yaml_ file which has details about the configuration. A topics will specify a list of symlinks and scripts. Here's an example of the VS Code (`editors/vscode`) topic.

```yaml
name: Visual Studio Code
scripts:
  - name: Backup extensions
    file: backup-extensions.sh
  - name: Install extensions
    file: install-extensions.sh
    bootstrap: true
symlinks:
  - src: keybindings.json
    path: ~/Library/Application Support/Code/User/keybindings.json
  - src: settings.json
    path: ~/Library/Application Support/Code/User/settings.json
  - src: snippets
    path: ~/Library/Application Support/Code/User/snippets
```

It has two scripts, backup extensions and install extensions. You'll notice install extensions has `bootstrap: true`, which means that this script will be run while bootstrapping the dotfiles! There are also a handful of symlinks, which will also be created when bootstrapping.

### Setup

```bash
# Grab the dotfiles.
$ git clone git@github.com:lgo/dotfiles.git ~/.dotfiles && ~/.dotfiles
# Make the dotfiles more accessible to Finder.
$ ln -s ~/.dotfiles ~/dotfiles

# (one-time prep, because the dotfiles manager is Ruby)
$ bundle install

$ ./dotfiles.rb
Usage: ./dotfiles.rb <subcommand> [options]

Commands:
  bootstrap   - sets up symlinks and executes all installation scripts
  info        - get information on topic(s) or script(s)

See 'dotfiles COMMAND --help' for more information on a specific command.
```

### Usage

```bash
# You can view all of the available topics of dotfiles.
$ ./dotfiles.rb info
Available topics
iterm: iTerm2
macos: macos
editors/vscode: Visual Studio Code
...

# You can view the specific details about a topic, including
# 1. The state of the symlinks (✅-> installed, ❌ not installed)
# 2. All of the scripts (⚙ -> bootstrap script)
$ ./dotfiles.rb info editors/vscode
Visual Studio Code (editors/vscode)

 [✅] keybindings.json -> ~/Library/Application Support/Code/User/keybindings.json
 [✅] settings.json -> ~/Library/Application Support/Code/User/settings.json
 [❌] snippets -> ~/Library/Application Support/Code/User/snippets

Scripts
      Backup extensions (/Users/joey/.dotfiles/editors/vscode/backup-extensions.sh)
 [⚙ ] Install extensions (/Users/joey/.dotfiles/editors/vscode/install-extensions.sh)

(from /Users/joey/.dotfiles/editors/vscode)

# Bootstrap the dotfiles for editors/vscode, only making symlinks.
$ ./dotfiles.rb bootstrap editors/vscode --only-symlinks
 [ ⚙  ] bootstrapping Visual Studio Code (editors/vscode)
 [ OK ] keybindings.json already linked
 [ OK ] settings.json already linked
 [ OK ] snippets linked
 [ ✅ ] completed Visual Studio Code (editors/vscode)

# Or, we can just run everything including the installation scripts.
# --only-scripts can be provided to only run the bootstrap scripts.
$ ./dotfiles.rb bootstrap editors/vscode
 [ ⚙  ] bootstrapping Visual Studio Code (editors/vscode)
 [ OK ] keybindings.json already linked
 [ OK ] settings.json already linked
 [ OK ] snippets already linked
 [ .. ] running script: Install extensions
 [ OK ] finished script
 [ ✅ ] completed Visual Studio Code (editors/vscode)
```

# What's provided

- zsh and an oh-my-zsh configuration
- macos configurations. using the `defaults` command on macos, there are plenty of power-user system configuration that is set, such speeding up UI animations, disabling features that are commonly unused or slow (dashboard, launchpad), preventing chrome's gesture swipe to go forward/backward in history, and plenty more. This is all in the `macos/set-defaults.sh` script.
- basic configurations for vscode, vim, and spacemacs & symlinking for them.
- ... (probably lots more!)

---

# dotfiles (old readme, from the holman/dotfiles base)

Adopted from holman dotfiles.

As with holman dotfiles, these are topic-centric which helps split
things up to concerns of including software packages.

## topical

Everything's built around topic areas. If you're adding a new area to
your forked dotfiles — say, "Java" — you can simply add a `java`
directory and put files in there. Anything with an extension of `.zsh`
will get automatically included into your shell. Anything with an
extension of `.symlink` will get symlinked without extension into
`$HOME` when you run `script/bootstrap`.

## what's inside

- homebrew setup
- macOS configuration. this includes lots of system defaults
- ...

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for
  [Homebrew Cask](http://caskroom.io) to install: things like Chrome and
  1Password and Adium and stuff. Might want to edit this file before
  running any initial setup.
- **topic/\*.zsh**: configuration files
  - Environment configuration (i.e., `.zshenv`)
    - **topic/\*env.zsh**: Any file ending with `env.zsh` is loaded
      second and is expected to setup any additional environment
      (e.g., shell options).
  - Interactive configuration (i.e., `.zshrc`)
    - **topic/\*path.zsh**: Any file ending with `path.zsh` (except
      those ending with `fpath.zsh`) is loaded first and is expected
      to setup `$PATH` or similar.
    - **topic/\*fpath.zsh**: Any file ending with `fpath.zsh` is
      loaded for interactive shells only. They are expected to
      populate `$fpath`.
    - **topic/\*.zsh**: Any files ending in `.zsh` (except those
      specified elsewhere) are loaded for interactive shells only.
      Interactive configuration can include aliases, color output,
      prompt configuration, or anything else that should only be
      loaded when a user is interacting with Zsh.
    - **topic/\*completion.zsh**: Any file ending with
      `completion.zsh` is loaded last for interactive shells only.
      They are expected to setup autocomplete.
  - Login configuration (i.e., `.zprofile`, `.zlogin`, `.zlogout`)
    - **topic/\*profile.zsh**: Any file ending with `profile.zsh` is
      loaded for login shells only. Unlike `.zlogin`, these files
      are loaded before the interactive files above are loaded.
    - **topic/\*login.zsh**: Any file ending in `login.zsh` is
      loaded for login shells only. Unlike `.zprofile`, they are
      loaded after your interactive files are loaded above. This is
      the ideal place to put anything you want to see when you start
      up a new login shell (e.g., cowsay, date, todo, fortune).
    - **topic/\*logout.zsh**: Any file ending in `logout.zsh` is
      loaded for login shells only and only when you exit/logout the
      shell.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## install

Run this:

```sh
git clone https://github.com/lego/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is
`zsh/zshenv.symlink`, which sets up a few paths that'll be different on
your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## test

Because you don't want to necessarily ruin your local environment
everytime you make a change, let's use Docker.

**Note:** you can only test the pieces of your dotfiles that will work
in a Linux environment. macOS specifics cannot be tested.

### dependencies

#### docker

Be sure Docker is installed.

##### macOS

    brew cask install docker

### run

    ./test/run.sh

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as _my_ dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/holman/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

I forked [Ryan Bates](http://github.com/ryanb)' excellent
[dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
weight of my changes and tweaks inspired me to finally roll my own. But Ryan's
dotfiles were an easy way to get into bash customization, and then to jump ship
to zsh a bit later. A decent amount of the code in these dotfiles stem or are
inspired from Ryan's original project.
