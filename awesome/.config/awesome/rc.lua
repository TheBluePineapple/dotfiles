-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local home = os.getenv("HOME")
local assets = home .. "/.config/awesome/default/assets"
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(home .. "/.config/awesome/default/theme.lua")
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
-- gears.wallpaper.maximized(home .. "/.config/awesome/default/wallpapers/space2.jpg") -- /usr/share/awesome/lib/gears/wallpaper.lua

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.corner.nw,
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
-- https://icons8.com/icon/lkk6STbDNYML/arch-linux
-- https://icons8.com/icon/419/console
-- https://icons8.com/icon/muqMY2QA2VIG/kali-linux
-- https://icons8.com/icons/set/linux--white
-- beautiful.awesome_icon = assets .. "/arch-linux-icon-white.svg"
beautiful.awesome_icon = assets .. "/artix-linux-icon-material-design.png"
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

-- context menu
mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal },
	},
})

beautiful.taglist_spacing = 5

local praisewidget = wibox.widget.textbox()
praisewidget.text = "ur grate!"
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %a %b %d, %I:%M ")

--not currently in use
local mybatterybar = wibox.widget({
	{
		min_value = 0,
		max_value = 100,
		value = 0,
		paddings = 1,
		border_width = 1,
		forced_width = 50,
		border_color = "#0000ff",
		id = "mypb",
		widget = wibox.widget.progressbar,
	},
	{
		id = "mytb",
		text = "100%",
		widget = wibox.widget.textbox,
	},
	layout = wibox.layout.stack,
	set_battery = function(self, val)
		self.mytb.text = tonumber(val) .. "%"
		self.mypb.value = tonumber(val)
	end,
})
gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		--read it from /sys/class/power_supply/
		-- mybatterybar.battery =
	end,
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)
	--awful.util.spawn.with_shell("~/.fehbg &")
	--awesome.spawn.with_shell("feh --bg-scale ~/Pictures/Wallpapers/wallpaper-1866931.jpg")
	-- Each screen has its own tag table.
	--awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	--
	-- local names = { "", "", "", "", "", "", "", "󱑢", "" }
	local names = { "", "", "", "", "", "" }
	local l = awful.layout.suit
	local layouts = {
		l.tile,
		l.tile,
		l.corner.nw,
		l.max,
		l.corner.nw,
		l.max,
	}
	-- local layouts = {
	-- 	l.corner.nw,
	-- 	l.tile,
	-- 	l.corner.nw,
	-- 	l.corner.nw,
	-- 	l.corner.nw,
	-- 	l.max.fullscreen,
	-- 	l.max.fullscreen,
	-- 	l.corner.nw,
	-- 	l.max.fullscreen,
	-- }
	awful.tag(names, s, layouts)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- theme.systray_icon_spocing = 6
	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = 25, bg = beautiful.bg_normal .. "aa" }) --,bg = beautiful.bg_normal .. "00" }) -- .. 33 concatinate 33/255 as transparency/opacity

	-- systray_icon_spocing
	--systray_widget:set_base_size(20)

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- praisewidget,
			-- mybatterybar,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	-- TODO switch speaker to fn, default to headphone and shift to master
	-- CHANGE BRIGHTNESS/VOLUME
	-- Add caching brightness with brillo and restore at bottom with autostart applications
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("doas brillo -s intel_backlight -q -U 1-")
	end, { description = "lower brightness", group = "system" }),
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("doas brillo -s intel_backlight -q -A 1")
	end, { description = "raise brightness", group = "system" }),

	--changes headphone volume
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.util.spawn("amixer -c 0 set Headphone 1%+")
	end, { description = "raise headphone volume", group = "system" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.util.spawn("amixer -c 0 set Headphone 1%-")
	end, { description = "lower headphone volume", group = "system" }),
	awful.key({}, "XF86AudioMute", function()
		awful.util.spawn("amixer -c 0 set Headphone toggle")
	end, { description = "un/mute headphones", group = "system" }),

	--changes Speaker volume
	awful.key({}, "F3", function()
		awful.util.spawn("amixer -c 0 set Speaker 1%+")
	end, { description = "raise speaker volume", group = "system" }),
	awful.key({}, "F2", function()
		awful.util.spawn("amixer -c 0 set Speaker 1%-")
	end, { description = "lower speaker volume", group = "system" }),
	awful.key({}, "F4", function()
		awful.util.spawn("amixer -c 0 set Speaker toggle")
	end, { description = "un/mute speaker", group = "system" }),
  
	--rebalances volume to my presets
	awful.key({"Mod1"}, "F4", function()
		awful.util.spawn("amixer -c 0 set Master 100%"); 
		awful.util.spawn("amixer -c 0 set Master unmute");
		awful.util.spawn("amixer -c 0 set Speaker 30%");
		awful.util.spawn("amixer -c 0 set Speaker mute");  
		awful.util.spawn("amixer -c 0 set Headphone 35%");
		awful.util.spawn("amixer -c 0 set Headphone unmute");
		--awful.util.spawn("amixer -c 0 set Master 100% && amixer -c 0 set Master unmute && amixer -c 0 set Speaker 30% && amixer -c 0 set Speaker mute && amixer -c 0 set Headphone 35% && amixer -c 0 set Headphone unmute")
	end, { description = "rebalance to preset volumes", group = "system" }),


	awful.key({"Shift"}, "F3", function()
		awful.util.spawn("amixer -c 0 set Master 1%+")
	end, { description = "raise speaker master", group = "system" }),
	awful.key({"Shift"}, "F2", function()
		awful.util.spawn("amixer -c 0 set Master 1%-")
	end, { description = "lower speaker master", group = "system" }),
	awful.key({"Shift"}, "F4", function()
		awful.util.spawn("amixer -c 0 set Master toggle")
	end, { description = "un/mute master", group = "system" }),

	
	--fullscreen screenshot
	-- ffmpeg -loglevel quiet -f x11grab -framerate 1 -video_size $RES -i :0.0 -vframes 1 ' #output.jpeg
	awful.key({}, "Print", function()
		-- awful.util.spawn("")
		awful.prompt.run({
			prompt = "<b>File: </b>",
			text = "~/images/output.jpg",
			bg_cursor = "#ff0000",
			-- To use the default rc.lua prompt:
			textbox = mouse.screen.mypromptbox.widget,
			-- textbox = atextbox,
			exe_callback = function(input)
				if not input or #input == 0 then
					return
				end

				-- awful.spawn(
				-- 	'bash -c "ffmpeg -loglevel quiet -f x11grab -framerate 1 =video_size $RES -i :0.0 -vframes 1 '
				-- 		.. input
				-- 		.. '"'
				-- 	-- 'bash -c "'
				-- 	-- 	.. " ffmpeg -loglevel quiet -f x11grab -framerate 1 -video_size $RES -i :0.0 -vframes 1 "
				-- 	-- 	.. input
				-- 	-- 	.. '"'
				-- )
				-- take the screenshot, get the output
				-- local command = [[bash -c '
				-- ffmpeg -loglevel quiet -f x11grab -framerate 1 -video_size $RES -i :0.0 -vframes 1 ]] .. input .. [[
				-- ']]
				-- local command = "ffmpeg -loglevel quiet -f x11grab -framerate 1 -video_size $RES -i :0.0 -vframes 1 "
				-- 				local output = [[bash -c '
				-- ]] .. command .. input .. [[
				-- ']]
				-- 		awful.spawn.easy_async(command, function(stdout, stderr, reason, exit_code)
				-- 			naughty.notify({ text = "The output was " .. stdout })
				-- 		end)
				-- 		naughty.notify({ text = "The command was: " .. command })
				naughty.notify({ text = "The input was: " .. input })
			end,
		})
	end, { description = "take a fullscreen screenshot", group = "system" }),

	-- LAUNCH APPLICATIONS
	awful.key({ modkey }, "b", function()
		awful.util.spawn("librewolf")
	end, { description = "launch librewolf", group = "launcher" }),
	awful.key({ modkey }, "c", function()
		awful.util.spawn(terminal .. " -e htop")
	end, { description = "launch htop", group = "launcher" }),
	awful.key({ modkey }, "a", function()
		awful.util.spawn(terminal .. " -e alsamixer -c 0")
		awful.util.spawn(terminal .. " -e mocp")
		awful.util.spawn(terminal .. " -e vis")
	end, { description = "launch mocp, alsamixer, and vis", group = "launcher" }),
	awful.key({ modkey }, "v", function()
		awful.util.spawn("lvide")
	end, { description = "launch lunarvim in lvide", group = "launcher" }),
	awful.key({ modkey }, "e", function()
		awful.util.spawn(terminal .. " -e ranger")
	end, { description = "launch ranger", group = "launcher" }),

	-- mod4 super r is default
	--awful.key({ modkey }, "a", function()
	--awful.util.spawn(terminal.." -e echo 'awesome.restart()' | awesome-client") end,
	--  {description = "launch ranger", group = "launcher"}),

	--awful.key({ modkey }, "a", function()
	--awful.util.spawn(terminal.." -e echo 'awesome.restart()' | awesome-client") end,
	--  {description = "launch ranger", group = "launcher"}),

	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},
	-- things that you don't want to float
	{
		rule = { class = "obsidian" },
		properties = { floating = false },
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- custom icon theme UNUSED RICE
	if c.instance ~= nil then
		local icon = menubar.utils.lookup_icon(c.instance)
		local lower_icon = menubar.utils.lookup_icon(c.instance:lower())
		if icon ~= nil then
			local new_icon = gears.surface(icon)
			c.icon = new_icon._native
		elseif lower_icon ~= nil then
			local new_icon = gears.surface(lower_icon)
			c.icon = new_icon._native
		elseif c.icon == nil then
			local new_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
			c.icon = new_icon._native
		end
	else
		local new_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
		c.icon = new_icon._native
	end
	-- only show titlebar if the window is floating
	client.connect_signal("property::floating", function(c)
		if c.floating then
			awful.titlebar.show(c)
		else
			awful.titlebar.hide(c)
		end
	end)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	--force programs to fit in the given space when tiling
	c.size_hints_honor = false
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = false})
--end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}

-- Autostart Applications
awful.spawn.with_shell("picom")
--awful.spawn.with_shell("feh")
--awful.spawn.with_shell("nitrogen --restore")
