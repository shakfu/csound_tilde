# csound~

A Max/MSP external for Csound.

## History

- This project was originally created by Matt Ingalls. 

- It was later maintained by Davis Pyon.  

- Steven Yi updated csound~ to work with Csound 6 and maintained it for a while within the main csound Git repository under the frontends/max\_csound\_tilde folder.

- The project folder and git history were exported (filtered) out and migrated to the current https://github.com/csound/csound_tilde repository.  

- This fork has the objective of converting the project to a Max Package structure, removing deprecated or obsolete code, and improving the build options for both macOS and Windows.


## Current Differences

**caveat**: tested only on macOS so far

- Makefile frontend for macOS builds

- Code fixes (see `source/project/csound_tilde/DEVNOTES.md`)

- Conversion to Max Package

- Build variants:

	- **local** build: non-relocatable, dynamically linked to local csound library or framework

	- **hybrid** build: relocatable with static csound + dynamic dependencies

	- **release** build: relocatable 100% static build using vcpkg. Best for both macOS and Windows



## Build Variants

In increasing order of build times:


variant    | linking  | relocatable   | pkg manager        | build time (x)
:--------- | :------- | :-----------: | :----------------- | :--------------:
local      | shared   | no     		  | local, homebrew    | 1x
hybrid     | both     | yes     	  | source, homebrew   | 50x
release    | static   | yes			  | vcpkg			   | 52x


### Local Build

This is the default.

Assumes:

	- local installation of Csound in $HOME/Library/Frameworks

	- `brew install libsndfile boost`

```bash
make
```

###  Relocatable Hybrid Build

Assumes:

	- `brew install libsndfile boost`

```
make hybrid
```

### Relocatable Release Build

Use vcpkg to download all dependencies which are all built statically.

```bash

make release

```


