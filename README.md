# Swish

Who wants to use a Ruby script to upload your iOS project? Not me. Let's use Swift.

## Approach
A task runner written in swift

## Goals: 
- Enable calling command line tools easily from Swift, since Swift's type system is nice.
- A swifty replacement for `make`
- allow easy variable substitution in shell calls, and what was run in the shell is logged to the log, for easy copy paste
- allow easy calls to all the commands declared. Sometimes a shell script fails halfway, or you simply want to run part of the script.
- scripts don't really want to be compiled since then their contents are opaque. Scripts want to be compiled just-in-time on every run

This package specifically does not try to provide a domain specific language for various tools. For those looking for a DSL, there is [Fastlane](https://fastlane.tools) or [Puma](https://github.com/pumaswift/Puma).

There are many 


## Usage

- Create a swift package with your scripts models and logic, importing `SwishKit`.
- Create a `Swishfile`


## Development

    docker run --rm -it  -v `pwd`:`pwd` -w `pwd` --platform linux/amd64 swift:5.4.1-focal
    apt-get update && apt-get install -y imagemagick
