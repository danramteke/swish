# Swish

Who wants to use a Ruby script to upload your iOS project? Not me. Let's use Swift.

## Approach
A task runner written in swift

## Goals: 
- not to provide bindings per se to different packages, since that is a lot of maintenance work. 
- Allow easy command line use of tools
- allow easy variable substitution in shell calls, and what was called is logged to the log, for easy copy paste
- allow easy calls to all the commands declared. Sometimes a shell script fails halfway, or you simply want to run part of the script.
- scripts don't really want to be compiled since then their contents are opaque. Scripts want to be compiled just-in-time on every run

## usage


swish