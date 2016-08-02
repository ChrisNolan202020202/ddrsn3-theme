The SNCharacters System
=======================

The _SNCharacters_ system (implemented in _Character.lua_) is a system designed to replace the built-in Character system with something more appropriate to the needs of SN3 and other themes based on modern DDR. It is intended to be relatively easy to drop into other themes. Currently, you'll have to make code for actually displaying any of the assets.

The Characters Themselves
-------------------------
Character.lua as included in this version of the theme can work with version 1 SNCharacters, and only version 1 SNCharacters. (No further versions have been devised yet.) The following elements are directly supported, which means that Character.lua will take care of at least part of the work for you.

### Configuration (config.lua) ###
config.lua is a file that returns a table containing at least two fields, version and color. Both must exist for the character to be considered valid.

config.lua is run in an empty environment, any attempt to use Lua functions defined outside that file will fail, including StepMania built-in functions.

version must be 1, or else the character will be considered invalid.
color is a StepMania color. It can be either a table of 4 elements or a string. If it is a string, it will be processed by color() during the loading process.

### Graphical elements ###
Character.lua verifies that two graphics files exist in the character folder during validation.
They are "combo.png" and "combo100.png". "combo.png" is the character's normal cut-in portrait, "combo100.png" is the character's 100-milestone cut-in.

### Dancer videos ###
Dancer videos go in the DancerVideos folder. Any format of video file accepted by StepMania can be loaded.

Character.lua
-------------
Character.lua exposes a table called Characters, which contains various functions for dealing with SNCharacters.

### GetPath(string name) ###
Attempts to get the path to a character with the given name. Returns nil if it can't be found. It does not validate names, so just getting a path back from this function doesn't mean that there actually is a character there.

### Validate(string name, boolean forceRecheck) ###
Basically, checks if there is a valid character with the given name. Returns true if successful and false if not. If forceRecheck is not true, answers are cached and will not reflect any changes to the character since the last recheck.

### GetConfig(string name, boolean forceRecheck) ###
Returns the configuration data for the character, or nil if there isn't any or it's invalid. forceRecheck acts identically to the way it does in Validate.
