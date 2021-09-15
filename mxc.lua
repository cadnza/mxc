VERSION = "1.0.0"

local micro = import("micro")
local shell = import("micro/shell")
local config = import("micro/config")

function init()
	-- Create commands
	config.MakeCommand("mxc", mxc, config.OptionComplete)
	config.MakeCommand("mxcx", mxcx, config.OptionComplete)
	-- Map bindings
	config.TryBindKey("F5","lua:mxc.mxc",false)
	config.TryBindKey("F6","lua:mxc.mxcx",false)
	-- Set options
	config.RegisterCommonOption("mxc", "saveOnRun", true)
	-- Register help file
	config.AddRuntimeFile("mxc", config.RTHelp, "help/mxc.md")
end

function mxc()
	driver(false)
end

function mxcx()
	driver(true)
end

function driver(lookForMxcFile)
	-- Get current pane
	local bp = micro.CurPane()
	-- Save buffer if option set
	local doSave = config.GetGlobalOption("mxc.saveOnRun")
	if doSave then
		bp:Save()
	end
	-- Get path of current file in buffer
	local fPath = bp.Buf.AbsPath
	-- Run main script
	local mainScript = os.getenv( "HOME" ).."/.config/micro/plug/mxc/main.sh"
	local scriptString
	if lookForMxcFile then
		scriptString = mainScript.." "..fPath.." ".."1"
	else
		scriptString = mainScript.." "..fPath
	end
	local str, err = shell.RunInteractiveShell(scriptString, true, false)
	-- Show any error
	if err ~= nil then
		micro.InfoBar():Error(err)
	end
end
