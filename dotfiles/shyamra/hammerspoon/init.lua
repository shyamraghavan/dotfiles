hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("WindowHalfsAndThirds",
	{ fn = function(s) s:bindHotkeys({
		left_half      = { {"shift",        "cmd"}, "Left" },
		right_half     = { {"shift",        "cmd"}, "Right" },
		top_half       = { {"shift",        "cmd"}, "Up" },
		bottom_half    = { {"shift",        "cmd"}, "Down" },
		left_third     = { {"shift", "ctrl","cmd"}, "Left" },
		middle_third_h = { {"shift", "ctrl","cmd"}, "Up" },
		right_third    = { {"shift", "ctrl","cmd"}, "Right" },
		right_half     = { {"shift",        "cmd"}, "Right" },
		-- top_left    = { {"shift",        "cmd"}, "1" },
		-- top_right   = { {"shift",        "cmd"}, "2" },
		-- bottom_left = { {"shift",        "cmd"}, "3" },
		-- bottom_right= { {"shift",        "cmd"}, "4" },
		max_toggle     = { {"shift", "alt"       }, "Down" },
		max            = { {"shift", "alt"       }, "Up" },
		undo           = { {         "alt", "cmd"}, "z" },
		center         = { {         "alt", "cmd"}, "c" },
	 }) end
	})

function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

function moveWindowOneSpace(direction)
    local keyCode = direction == "left" and 123 or 124

    return hs.osascript.applescript([[
        tell application "System Events"
            keystroke (key code ]] .. keyCode .. [[ using control down)
        end tell
    ]])
end

function moveSpace(direction)
    local spacesMainScreen = hs.screen.mainScreen():spaces()
	local currentIndex = table.indexOf(spacesMainScreen, spaces.activeSpace())

	-- if (currentIndex == #spacesMainScreen and direction == 1) then
	-- 	hs.osascript.applescript(" \
	-- 	tell application \"System Events\" \
	-- 		tell application \"Mission Control\" to launch \
	-- 		tell group 2 of group 2 of group 1 of process \"Dock\" \
	-- 			click (every button whose value of attribute \"AXDescription\" is \"add desktop\") \
	-- 		end tell \
	-- 	end tell \
	-- 	delay 1 \
	-- 	")
	-- end

	local newSpace = spacesMainScreen[currentIndex + direction]

	hs.window.focusedWindow():spacesMoveTo(newSpace)
	spaces.changeToSpace(newSpace)
end

hs.hotkey.bind({"cmd", "shift", "alt"}, 'Left', function () moveWindowOneSpace("left") end)
hs.hotkey.bind({"cmd", "shift", "alt"}, 'Right', function () moveWindowOneSpace("right") end)

-- quick jump to important applications
hs.grid.setMargins({0, 0})
hs.hotkey.bind({"cmd", "shift"}, 'C', function () hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({"cmd", "shift"}, 'S', function () hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind({"cmd", "shift"}, 'L', function () hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind({"cmd", "shift"}, 'J', function () hs.application.launchOrFocus("IntelliJ IDEA") end)
hs.hotkey.bind({"cmd", "shift"}, 'D', function () hs.application.launchOrFocus("Signal") end)
hs.hotkey.bind({"cmd", "shift"}, 'K', function () hs.spotify.playpause() end)
hs.hotkey.bind({"cmd", "shift", "alt"}, 'P', function () hs.spotify.displayCurrentTrack() end)
hs.hotkey.bind({"cmd", "shift"}, 'V', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({"cmd", "shift"}, 'I', function () hs.application.launchOrFocus("Sublime Text") end)
hs.hotkey.bind({"cmd", "shift"}, 'U', function ()
    local chrome = hs.application.open("Google Chrome", 10)
    chrome:selectMenuItem({"Tab", "Mail - Shyam Raghavan - Outlook"})
end)
hs.hotkey.bind({"cmd", "shift"}, 'Y', function ()
    local chrome = hs.application.open("Google Chrome", 10)
    chrome:selectMenuItem({"Tab", "Calendar - Shyam Raghavan - Outlook"})
end)
hs.hotkey.bind({"cmd", "shift"}, 'Z', function ()
    local chrome = hs.application.open("Google Chrome", 10)
    chrome:selectMenuItem({"Tab", "CRED Iteration Board - Agile Board - ZBRT"})
end)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "p", function() hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult) end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "d", function()
    hs.execute("lpass show --password -c --color=never okta.com", true)
    hs.alert("Lastpass login loaded")
end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function pingResult(object, message, seqnum, error)
	if message == "didFinish" then
		avg = tonumber(string.match(object:summary(), '/(%d+.%d+)/'))
		if avg == 0.0 then
			hs.alert.show("No network")
		elseif avg < 200.0 then
			hs.alert.show("Network good (" .. avg .. "ms)")
		elseif avg < 500.0 then
			hs.alert.show("Network poor(" .. avg .. "ms)")
		else
			hs.alert.show("Network bad(" .. avg .. "ms)")
		end
	end
end

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
        hs.notify.new({title="Hammerspoon", informativeText="Hammerspoon config automatically reloaded"}):send()
    end
end

pathwatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
