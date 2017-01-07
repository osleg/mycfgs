-- {{{
--   Heavily modified version of copycats powerarrow dark
-- }}}

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
-- }}}

-- {{{ My requires
--local hints = require("hints")
require("eminent")
--local minitray = require("minitray")
local helpers = require("helpers")
--local revelation = require("revelation")
local rerodentbane = require("rerodentbane")
-- }}}
--rerodentbane.bind({}, "KP_End", {rerodentbane.cut, 'tl'})

-- {{{ Error handling
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
  title = "Oops, there were errors during startup!",
  text = awesome.startup_errors })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, an error happened!",
    text = err })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

local home   = os.getenv("HOME")

wallpaper_app = "feh" -- if you want to check for app before trying
--wallpaper_dir = home .. "/Pictures/wallpapers" -- wallpaper dir
wallpaper_dir = home .. "/Pictures/wp" -- wallpaper dir

require_safe('personal')

--wallpaper = home .. "/.config/awesome/themes/powerarrow-darker/wall.png"
--wallpaper = home .. "/Pictures/wallpapers/sexy_android.jpg"
--wallpaper = home .. "/Pictures/wallpapers/grey_red.jpg"
--wallpaper = home .. "/Pictures/wallpapers/sexy_legs.jpg"
--wallpaper = home .. "/Pictures/wallpapers/dear.jpg"
--os.execute("feh --bg-scale " .. wallpaper)
local wallpaper_cmd = "find " .. wallpaper_dir .. " -type f -name '*.*g'  -print0 | shuf -n1 -z"
local exec   = awful.spawn.spawn
local sexec  = awful.spawn.with_shell


-- beautiful init - powerarrow
beautiful.init(home .. "/.config/awesome/themes/blackburn/theme.lua")

-- beautiful init - holo
--beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/holo/theme.lua")

-- revalation init
--revelation.init()

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "urxvt"
editor     = os.getenv("EDITOR") or "vim" or "vi"
editor_cmd = terminal .. " -e " .. editor


-- user defined
browser    = "firefox"
browser2   = "chromium"
gui_editor = "qvim"
graphics   = "gimp"
--maila       = terminal .. " -e vmail"
--mailo       = "VMAIL_HOME=~/.vmail/oDesk/" .. terminal .. " -e /home/alex/.gem/ruby/2.1.0/bin/vmail "
--mail4       = "source ~/.zshrc && VMAIL_HOME=~/.vmail/4k1r4/" .. terminal .. " -e /home/alex/.gem/ruby/2.1.0/bin/vmail "
musicplr    = terminal .. " -e ncmpcpp "
pacmixer    = "pavucontrol"
nmcli       = "nmcli_dmenu"

-- hints
--hints.init()

local layouts = {
  --awful.layout.suit.floating,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile,
  --awful.layout.suit.tile.left,
  --awful.layout.suit.tile.top,
  --lain.layout.uselesstile,
  --awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.spiral,
  --awful.layout.suit.spiral.dwindle,
  --awful.layout.suit.max,
}
-- }}}

-- {{{ Tags
--taglist = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十"}
taglist = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
tags = {}
for s = 1, screen.count() do
  -- Each screen has its own tag table.
  tags[s] = awful.tag(taglist, s, layouts[1])
end
-- }}}

-- {{{ Menu
mymainmenu = awful.menu.new({ items = require("menubar.menu_gen").generate(
  function(e)
    return e
  end),
  theme = { height = 16, width = 130 }})
-- }}}

-- {{{ Wibox
local markup = lain.util.markup

-- {{{ Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = wibox.widget.textclock(markup(beautiful.fg_urgent, " %a %d %b  %H:%M"))
-- }}}

-- {{{ calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })
-- }}}

-- {{{ MPD
mpdicon = wibox.widget.imagebox(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn.spawn_with_shell(musicplr) end)))
--mpdwidget = mocp(2)
--mocwidget = lain.widgets.contrib.moc({
--settings = function()
--if moc_now.state == "PLAY" then
--artist = " " .. moc_now.artist .. " "
--title  = moc_now.title  .. " "
--mpdicon:set_image(beautiful.widget_music_on)
--elseif moc_now.state == "PAUSE" then
--artist = " moc "
--title  = "paused "
--else
--artist = ""
--title  = ""
--mpdicon:set_image(beautiful.widget_music)
--end

--widget:set_markup(markup("#EA6F81", artist) .. title)
--end
--})
mpdwidget = lain.widgets.mpd({
  settings = function()
    if mpd_now.state == "play" then
      artist = " " .. mpd_now.artist .. " "
      title  = mpd_now.title  .. " "
      mpdicon:set_image(beautiful.widget_note_on)
    elseif mpd_now.state == "pause" then
      artist = " mpd "
      title  = "paused "
    else
      artist = ""
      title  = ""
      mpdicon:set_image(beautiful.widget_note)
    end

    widget:set_markup(markup(beautiful.fg_urgent, artist) .. markup(beautiful.fg_normal, title))
  end
})
--mocwidgetbg = wibox.container.background(mocwidget, "#313131")
--mpdwidgetbg = wibox.container.background(mpdwidget, "#313131")
-- }}}

-- {{{ TaskWarrior

--taskicon = wibox.widget.imagebox(beautiful.widget_task)
--taskicon:buttons(
--awful.util.table.join(
--awful.button({ }, 1,
--function ()
--lain.widgets.contrib.task:prompt_add()
--end)))
--taskwidget = lain.widgets.contrib.task:attach(taskicon, {
--fg = beautiful.fg_normal,
--bg = beautiful.bg_normal
--})
-- }}}

-- {{{ Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
local tempfile = "/sys/devices/platform/coretemp.0/hwmon/hwmon"

function file_exists(path)
local f=io.open(path,"r")
if f~=nil then io.close(f) return true else return false end
end

for t=0, 10 do
  local tf = tempfile .. t .. "/name"
  if file_exists(tf) then
    tempfile = tempfile .. t .. "/temp1_input"
    break
  end
end

tempwidget = lain.widgets.temp({
  tempfile = tempfile,
  settings = function()
    widget:set_markup(markup(beautiful.fg_urgent, coretemp_now .. "°C "))
  end
})
-- }}}

-- {{{ / fs
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
  settings  = function()
    widget:set_markup(markup(beautiful.fg_normal, fs_now.used .. "% "))
  end
})
fswidget = wibox.container.background(fswidget, "#1A1A1A")
fsicon = wibox.container.background(fsicon, "#1A1A1A")
-- }}}

-- {{{ Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
  settings = function()
    if bat_now.perc == "N/A" then
      widget:set_markup(" AC ")
      baticon:set_image(beautiful.widget_ac)
      return
    elseif tonumber(bat_now.perc) <= 5 then
      baticon:set_image(beautiful.widget_battery_empty)
    elseif tonumber(bat_now.perc) <= 15 then
      baticon:set_image(beautiful.widget_battery_low)
    else
      baticon:set_image(beautiful.widget_battery)
    end
    widget:set_markup(markup(beautiful.fg_urgent, bat_now.perc .. "% "))
  end,
  battery = "BAT0"
})
-- }}}

-- {{{ ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn.spawn_with_shell(pacmixer) end)))
volumewidget = lain.widgets.alsa({
  timeout = 60,
  settings = function()
    if volume_now.status == "off" then
      volicon:set_image(beautiful.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
      volicon:set_image(beautiful.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
      volicon:set_image(beautiful.widget_vol_low)
    else
      volicon:set_image(beautiful.widget_vol)
    end

    widget:set_markup(markup(beautiful.fg_normal, volume_now.level .. "% "))
  end
})
voliconbg = wibox.container.background(volicon, "#1A1A1A")
volumewidgetbg = wibox.container.background(volumewidget, "#1A1A1A")
-- }}}

-- {{{ Net
--local net_widgets = require("net_widgets")
--net_wireless = lain.widgets.net({})
--neticon = wibox.widget.imagebox(beautiful.widget_net)
--neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn.spawn_with_shell(iptraf) end)))
--net_wireless = lain.widgets.net({
--settings = function()
--widget:set_markup(markup("#7AC82E", " " .. net_now.received)
--.. " " ..
--markup("#46A8C3", " " .. net_now.sent .. " "))
--end
--})
--net_wireless = wibox.container.background(net_wireless, "#1A1A1A")
-- }}}

--[[ {{{ Net widget - speeds
[neticon = wibox.widget.imagebox(beautiful.widget_net)
[neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn.spawn(nmcli) end)))
[netwidget = wibox.container.background(lain.widgets.net({
[    settings = function()
[        widget:set_markup(markup("#7AC82E", " " .. net_now.received)
[                          .. " " ..
[                          markup("#46A8C3", " " .. net_now.sent .. " "))
[    end
[}), "#313131")
]]
-- }}}

-- {{{ Sysload
--loadicon = wibox.widget.imagebox(beautiful.widget_mem)
--loadwidget = wibox.container.background(lain.widgets.sysload({
--timeout = 60,
--settings = function()
--widget:set_markup(markup("#C49393", load_5)
--.. '-' ..
--markup("#F6686F", load_15 .. ' '))
--end
--}))
--loadwidget = wibox.container.background(loadwidget, "#313131")
--loadicon = wibox.container.background(loadicon, "#313131")
-- }}}

-- {{{ Notifications Widget
notificon = wibox.widget.imagebox(beautiful.widget_mail)
-- }}}

-- {{{ Separators
spr = wibox.widget.textbox(' ')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
arrl_dl = wibox.widget.imagebox()
arrl_dl:set_image(beautiful.arrl_lr_pre)
arrl_ld = wibox.widget.imagebox()
arrl_ld:set_image(beautiful.arrl_lr_post)
-- }}}

-- {{{ Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}

-- [[ Systray

-- ]]

awful.screen.connect_for_each_screen(function(s)

  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()

  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
  awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, mytasklist.buttons)
  mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 3, function ()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ width=250 })
    end
  end))
  -- Create the wibox
  mywibox[s] = awful.wibar({ position = "top", screen = s, height = beautiful.awful_widget_height })

  -- Widgets that are aligned to the upper left
  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(mytaglist[s])
  left_layout:add(arrl_dl)
  left_layout:add(mylayoutbox[s])
  left_layout:add(arrl_ld)

  -- Widgets that are aligned to the upper right
  -- If you are moving widgets from a section with light grey background to dark grey or vice versa,
  -- use a replacement icon as appropriate from themes/powerarrow-darker/alticons so your icons match the bg.
  local right_layout = wibox.layout.fixed.horizontal()
  --right_layout:add(arrl_dl)
  --if s == 1 then right_layout:add(wibox.widget.systray()) end
  --right_layout:add(mypromptbox[s])
  --right_layout:add(arrl_ld)
  right_layout:add(mpdicon)
  right_layout:add(mpdwidget)
  right_layout:add(arrl_dl)
  --right_layout:add(mocwidgetbg)
  right_layout:add(voliconbg)
  right_layout:add(volumewidgetbg)
  right_layout:add(arrl_ld)
  --right_layout:add(loadicon)
  --right_layout:add(loadwidget)
  --right_layout:add(arrl_dl)
  right_layout:add(tempicon)
  right_layout:add(tempwidget)
  right_layout:add(arrl_dl)
  right_layout:add(fsicon)
  right_layout:add(fswidget)
  right_layout:add(arrl_ld)
  right_layout:add(baticon)
  right_layout:add(batwidget)
  right_layout:add(arrl_dl)
  if s.index == 1 then right_layout:add(wibox.widget.systray()) end
  --right_layout:add(neticon)
  --right_layout:add(net_wireless)
  right_layout:add(arrl_ld)
  right_layout:add(mytextclock)
  right_layout:add(spr)
  right_layout:add(notificon)

  local middle_layout = wibox.layout.fixed.horizontal()
  middle_layout:add(spr)
  middle_layout:add(arrl)
  middle_layout:add(mytasklist[s])
  --middle_layout:add(arrl_ld)

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(middle_layout)
  layout:set_right(right_layout)
  mywibox[s]:set_widget(layout)

end)
-- }}}
-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
awful.key({ modkey,           }, "q",     rerodentbane              ),
awful.key({ modkey, "Control" }, "q",
function()
  rerodentbane.start_systray()
end),

awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

awful.key({ modkey,           }, "j",
function ()
  awful.client.focus.byidx( 1)
  if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end),
--awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),
-- On the fly useless gaps change
awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
awful.key({ modkey,           }, "Tab",
function ()
  awful.client.focus.history.previous()
  if client.focus then
    client.focus:raise()
  end
end),

-- Standard program
awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn.spawn(terminal) end),
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey,           }, "r", function () awful.spawn.spawn("rofi -show run") end),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.client.incwfact( 0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.client.incwfact(-0.05)    end),

awful.key({ modkey,           }, ",",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey,           }, ".",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

awful.key({ modkey }, "b", function ()
  mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
end),

--awful.key({ modkey }, "x",
--function ()
--awful.prompt.run({ prompt = "RLC: " },
--mypromptbox[mouse.screen].widget,
--awful.util.eval, nil,
--awful.util.getdir("cache") .. "/history_eval")
--end),

-- Hints
--awful.key({ modkey }, "p", function () hints.focus() end),

-- bind PrintScrn to capture a screen
awful.key({ }, "Print", function () awful.spawn.spawn("sh /home/alex/.bin/capscr", false) end),

awful.key({ "Shift" },
"Print",
function ()
  awful.spawn.spawn_with_shell("DATE=`date +%Y%m%d%H%M`; xsnap -nogui -grab -file $HOME/capscr/$DATE")
end),

-- ALSA volume control
awful.key({  }, "XF86AudioRaiseVolume",
function ()
  awful.spawn.spawn("pamixer -i 1")
  volumewidget.update()
end),
awful.key({ }, "XF86AudioLowerVolume",
function ()
  awful.spawn.spawn("pamixer -d 1")
  volumewidget.update()
end),
awful.key({ }, "XF86AudioMute",
function ()
  awful.spawn.spawn("pamixer -t")
  volumewidget.update()
end),

-- minitray
--awful.key({ modkey, "Shift" }, "s", function () minitray.toggle() end),
-- Copy to clipboard
awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

-- XF86
awful.key({ }, "XF86AudioPlay", function () awful.spawn.spawn( "mpc toggle" ) end),
awful.key({ }, "XF86AudioStop", function () awful.spawn.spawn( "mpc stop" ) end),
awful.key({ }, "XF86AudioPrev", function () awful.spawn.spawn( "mpc prev" ) end),
awful.key({ }, "XF86AudioNext", function () awful.spawn.spawn( "mpc next" ) end),

awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn.spawn( "pamixer --decrease 2" ) end),
awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn.spawn( "pamixer --increase 2" ) end),
awful.key({ }, "XF86AudioMute", function() awful.spawn.spawn( "pamixer -t" ) end),


awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn.spawn( "/home/alex/.bin/brightness up" ) end),
awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn.spawn( "/home/alex/.bin/brightness down" ) end),
awful.key({ }, "XF86KbdBrightnessUp", function () awful.spawn.spawn( "kbdlight up 1" ) end),
awful.key({ }, "XF86KbdBrightnessDown", function () awful.spawn.spawn( "kbdlight down 1" ) end),

-- rock the world!
--awful.key({ modkey, "Shift" }, "m", function() awful.spawn.spawn_with_shell(pacmixer) end),
awful.key({ modkey, "Shift" }, "p", function () awful.spawn.spawn( "/home/alex/.bin/panextSink.sh" ) end),

-- revealation binds
--awful.key({ modkey }, "e", revelation),

-- Drop
awful.key({ modkey }, "z", function() drop(terminal .. " -e tmux", "top", "center", 1, 0.5) end),
awful.key({ modkey, "Shift" }, "m", function() drop(pacmixer, "top", "center", 1, 0.5) end),
awful.key({ modkey }, "m", function() drop(musicplr, "top", "center", 1, 0.5) end),

-- Notification suspension
awful.key({ modkey, "Shift" }, "n", function()
  if naughty.is_suspended() then
    naughty.notify({
      title = "Notifications system",
      text = "Running again!"})
      naughty.resume()
      notificon:set_image(beautiful.widget_mail)
    else
      naughty.notify({
        title = "Notifications system",
        text = "Suspending!"})
        naughty.suspend()
        notificon:set_image(beautiful.widget_mail_on)
      end
    end),
    awful.key({ modkey, "Control"   }, "n",
    function()
      local tag = awful.tag.selected()
      for i=1, #tag:clients() do
        tag:clients()[i].minimized=false
        tag:clients()[i]:redraw()
      end
    end)
    )

    clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "t",      awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Control" }, "t",      function(c) c.opacity = 0.5                   end),
    awful.key({ modkey, "Shift"   }, "t",      function(c) c.opacity = 1                     end),
    awful.key({ modkey, "Shift"   }, "f",
    function (c)
      c.focusable = nil
    end)
    --awful.key({ modkey, "Control"   }, "f",      function (c) if c.focusable then naughty.notify({title = "true"}) else naughty.notify({title ="false"}) end     end)
    --awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end)
    --awful.key({ modkey,           }, "m",
    --function (c)
    --c.maximized_horizontal = not c.maximized_horizontal
    --c.maximized_vertical   = not c.maximized_vertical
    --end)
    )

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it works on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 10 do
      globalkeys = awful.util.table.join(globalkeys,
      awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end),
      awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end),
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end),
      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end))
    end

    clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

    -- Set keys
    root.keys(globalkeys)
    -- }}}

    -- {{{ Rules
    awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
      properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons,
      size_hints_honor = false,
      maximized_vertical = false,
      maximized_horizontal = false } },
      --{ rule = { class = "URxvt" },
      --properties = { opacity = 0.95 } },

      { rule = { class = "MPlayer" },
      properties = { floating = true } },

      { rule = { class = "Dwb" },
      properties = { tag = tags[1][1] } },

      { rule = { class = "Iron" },
      properties = { tag = tags[1][1] } },

      { rule = { instance = "plugin-container" },
      properties = { tag = tags[1][1] } },

      { rule = { class = "Gimp" },
      properties = { tag = tags[1][4],
      floating = true } },

      { rule = { class = "Gimp", role = "gimp-image-window" },
      properties = { maximized_horizontal = true,
      maximized_vertical = true } },
      { rule = { class = "Plugin-container" },
      properties = { floating = true } },

      { rule = { instance = "mpvldb" },
      properties = { focusable = false,
      below = true,
      floating = true,
      maximized_vertical = true,
      maximized_horizontal = true
    } },
  }
  -- }}}

  -- {{{ Signals
  --
  -- {{{ Manage signal handler
  client.connect_signal("manage", function (c, startup)
    -- Add titlebar to floaters, but remove those from rule callback
    if c.floating
      or awful.layout.get(c.screen) == awful.layout.suit.floating then
      if c.titlebar then awful.titlebar.remove(c) end
    end

    -- Focus on click
    --c:connect_signal("mouse::click", function (c)
    --if  awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    --and awful.client.focus.filter(c) then
    --client.focus = c
    --end
    --end)

    -- Client placement
    if not startup then
      awful.client.setslave(c)
      if  not c.size_hints.program_position
        and not c.size_hints.user_position then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
      end
    end
  end)
  -- }}}

  -- {{{ Focus signal handlers
  client.connect_signal("focus",
  function (c)
    c.border_color = beautiful.border_focus
  end)
  client.connect_signal("unfocus",
  function (c)
    c.border_color = beautiful.border_normal
  end)
  -- }}}

  -- {{{ Arrange signal handler
  for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    for _, c in pairs(clients) do -- Floaters are always on top
      if c.floating or layout == "floating" then
        if not c.fullscreen and c.focusable then
          c.above = true
        end
      else
        c.above = false
      end
    end
  end)
end
-- }}}

-- {{{ Disable DPMS on fullscreen application
local fullscreened_clients = {}

local function remove_client(tabl, c)
local index = awful.util.table.hasitem(tabl, c)
if index then
  table.remove(tabl, index)
  if #tabl == 0 then
    awful.spawn.spawn("xset s on")
    awful.spawn.spawn("xset +dpms")
  end
end
end

client.connect_signal("property::fullscreen",
function(c)
  if c.fullscreen then
    table.insert(fullscreened_clients, c)
    if #fullscreened_clients == 1 then
      awful.spawn.spawn("xset s off")
      awful.spawn.spawn("xset -dpms")
    end
  else
    remove_client(fullscreened_clients, c)
  end
end)

client.connect_signal("unmanage",
function(c)
  if c.fullscreen then
    remove_client(fullscreened_clients, c)
  end
end)
-- }}}

-- }}}

-- {{{ Background cycle
x = 0

gears.wallpaper.fit('/home/alex/Pictures/wp/wallhaven-105677.png', mouse.screen)
-- setup the timer
--mytimer = gears.timer { timeout = x }
--mytimer:connect_signal("timeout", function()

  ---- tell awsetbg to randomly choose a wallpaper from your wallpaper directory
  --if file_exists(wallpaper_dir) and whereis_app('feh') then
    --os.execute(wallpaper_cmd)
  --end
  ---- stop the timer (we don't need multiple instances running at the same time)
  --mytimer:stop()

  ---- define the interval in which the next wallpaper change should occur in seconds
  ---- (in this case anytime between 10 and 20 minutes)
  --x = math.random( 600, 1200)

  ----restart the timer
  --mytimer.timeout = x
  --mytimer:start()
--end)

---- initial start when rc.lua is first run
--mytimer:start()

-- {{{ Autorun
require_safe('autorun')
-- }}}

-- vim: set ts=2 sw=2 tw=0 fdm=marker et :
