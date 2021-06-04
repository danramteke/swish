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
- use `sh` to create a command and execute it immediately. (e.g. `let gitRoot: Path = try sh("git rev-parse --show-toplevel")`)
- use `cmd` to create a command, and save it for later. This can be useful when setting up longer scripts. For example:

```
let name = "Example"
let checkIfExampleIsRunning = cmd("docker ps -aq -f name=\(name) --format \"{{ .Names }}\"", .equalsTrimming(name))`
```

You can then compose these building blocks into your own script. For example, we can compose a function to check if a docker container named `name` is currently running:

```
func containerIsRunning(name: String) -> ConcreteBooleanShellQuery {
  cmd("docker ps -aq -f name=\(name) --format \"{{ .Names }}\"", .equalsTrimming(name))
}
```
and it would be used like this: `let isExampleRunning: Bool = containerIsRunning(name: "example").execute()`

Or we can subclass `ConcreteBooleanShellQuery` to achieve the same thing: 

```
class ContainerIsRunning: ConcreteBooleanShellQuery {
  let name: String
  init(name: String) {
    self.name = name
    let text = "docker ps -aq -f name=\(name) --format \"{{ .Names }}\""
    super.init(text, .equalsTrimming(name))
  }
}
```
which would be used like `let isExampleRunning: Bool = ContainerIsRunning(name: "Example").execute()`

### Callable as function

All `Command`s and `Query`s implement Swift's `callAsFunction()`, which simply delegates to `execute`. This can aid slightly in readability. Consider 

```
let startExampleContainer = cmd("docker run -d -p 8080:80 --name Example example/example:1.0")
let checkIfExampleIsRunning = containerIsRunning(name: "Example")
// ...
if !checkIfExampleIsRunning() {
    startExampleContainer()
}
```

## Architecture

There are two things you typically do with a shell. Run `Command`s and ask `Query`s. An example of a `Command` might be `xcodebuild ...`, where we aren't necessarily concerned about the output, just if it passes or fails. An example of a `Query` might be `git status --porcelain`, where we are going to parse the output and do something with it. A second kind of query might be a `BooleanShellQuery` where we translate the output of `git status --porcelain` into a boolean value: whether or not the git working copy is clean, in this example.

The `sh` and `cmd` helpers reference the `SharedShellRunner` global object, which provides context to the shell invocations, such as where to write the logs.


Not everything you want to needs to be done as a shell command. For example, you may want to use [Alamofire](https://github.com/Alamofire/Alamofire.git) instead of shelling out to `curl`. Just make your type adhere to `Command` or `Query` if needed.



## Development

A Docker snippet to confirm that it works on Linux.

    docker run --rm -it  -v `pwd`:`pwd` -w `pwd` --platform linux/amd64 swift:5.4.1-focal
    apt-get update && apt-get install -y imagemagick
