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

function check(script, arg, message)
	local rtn, err = tonumber(shell.ExecCommand(script, arg))
	if rtn == 1 then
		micro.InfoBar():Error(message)
	end
	return rtn
end

function driver(lookForMxcFile)
	-- Set plugin directory
	local d = os.getenv("HOME").."/.config/micro/plug/mxc/"
	-- Get current pane
	local bp = micro.CurPane()
	-- Get path of current file in buffer
	local fPath = bp.Buf.AbsPath
	-- Run parse script
	local parseScript = d.."parse.sh"
	local parseScriptString
	if lookForMxcFile then
		parseScriptString = parseScript.." "..fPath.." ".."1"
	else
		parseScriptString = parseScript.." "..fPath
	end
	local targetFile, err = shell.RunCommand(parseScriptString)
	-- Run validation script
	local validateScript = d.."validate.sh"
	local msg, err = shell.ExecCommand(validateScript, targetFile)
	if err ~= nil then
		micro.InfoBar():Error(msg)
		return
	end
	-- Save buffer if option set
	local doSave = config.GetGlobalOption("mxc.saveOnRun")
	if doSave then
		bp:Save()
	end
	-- Run execute script
	local executeScript = d.."execute.sh"
	local executeScriptString = executeScript.." "..targetFile
	local str, err = shell.RunInteractiveShell(executeScriptString, true, false)
	if err ~= nil then
		micro.InfoBar():Error(err)
	end
end
