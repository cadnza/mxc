# microExecutor

![](https://img.shields.io/github/v/release/cadnza/mxc)

Handy script runner for [micro](https://micro-editor.github.io/index.html). Speeds up your scripting. :-)

## Install

You'll want to get it from [micro's plugin site](https://micro-editor.github.io/plugins.html), but it it's not there yet (see [#73](https://github.com/micro-editor/plugin-channel/pull/73)), you can always do the following:

1. Download the [latest release](https://github.com/cadnza/mxc/releases/latest)
2. Place the unzipped `mxc` directory in `~/.config/micro/plug` (create the `plug` directory if it doesn't already exist)

## Commands

### `F5`: `mxc`

The sweet, simple script runner. Hit `F5` to temporarily suspend the buffer and run your current script in the terminal. Once it's done executing, hit Enter to return, and [micro](https://micro-editor.github.io/index.html) prints any errors in the gutter.

### `F6`: `mxcx`

The extended script runner. 😎 Hit `F6` to search the current script's directory for a file called `.mxc`. If it finds it, it runs `.mxc` instead of the current script. If you're in a [git](https://git-scm.com/) repo, it crawls every directory back to the root, executing the first `.mxc` it finds. 🔭 This can be very useful if you're tweaking a file that's part of a larger project and needs another script for testing.

## Options

### `mxc.saveOnRun`

If `true` (default), running `mxc` or `mxcx` saves your file automatically before running it. 💾

## Questions?

Feel free to [log an issue](https://github.com/cadnza/mxc/issues/new)!
