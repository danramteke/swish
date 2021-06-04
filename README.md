# Swish

Who wants to use a Ruby scripts to maintain your iOS project? Not me. Let's use Swift.

## Motivation

Bash scripts have gotten us pretty far, but it's difficult reasoning about control flow. And there's no type safety. 

Another motivation is a script fails, and you make some fixes, and you want to run only the command that failed. However, the command that failed had lots of `$VARIABLE` substitutions that are difficult to recreate.

These issues have bothered me for many years, through mountains of bash scripts, and I think I have something worth suggesting. I would love your feedback on it.

## Approach
Swish is a Swift task runner that lets you reason about your script in Swift, easily calling shell commands and using their output in your Swift program. It also
- keeps track of all commands run, and all output.
- logs the out of the shell commands to the terminal, for easy copy-pasting for re-running failed commands.
- can parse output into Swift types that conform to either ShellOutputInitable or StdOutputInitible
- clears previous logs (by default) to keep a clean logs directory

- Swish does not intend to offer a Domain Specific Language to different shell commands. 
- Swish does not intend to be used a `#!` point-of-entry for scripts

## Goals: 

- Enable calling command line tools easily from Swift, since Swift's type system is nice.
- A swifty replacement for `make`
- allow easy variable substitution in shell calls, and what was run in the shell is logged to the log, for easy copy-paste
- allow easy calls to all the commands declared. Sometimes a shell script fails halfway, or you simply want to run part of the script.
- scripts don't really want to be compiled since then their contents are opaque. Scripts want to be compiled just-in-time on every run

This package specifically does not try to provide a domain specific language for various tools. For those looking for a DSL, there is [Fastlane](https://fastlane.tools) or [Puma](https://github.com/pumaswift/Puma).


## Examples

There are two example projects in the `Examples` folder

- The `DockerDev` example sets up and tears down some docker containers. 

- The `AppIconRender` example renders iOS App Icons using [ImageMagick](https://imagemagick.org/). The `AppIconRender` example also showcases Swish's `make`-like targets to avoid regenerating large assets when they are not needed. 


## Usage

- Create a swift package with your scripts models and logic, importing `SwishKit`.


## Development

A Docker snippet to confirm that it works on Linux.

    docker run --rm -it  -v `pwd`:`pwd` -w `pwd` --platform linux/amd64 swift:5.4.1-focal
    apt-get update && apt-get install -y imagemagick
