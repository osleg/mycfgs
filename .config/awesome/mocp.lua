---------------------------------------------------------------------------
-- @author Gwenhael Le Moine &lt;gwenhael.le.moine@gmail.com&gt;
-- @copyright © 2010, 2011 Gwenhael Le Moine
-- @release 0.0
---------------------------------------------------------------------------

local setmetatable = setmetatable
local os           = os
local io           = io
local math         = math
local tonumber     = tonumber
local textbox      = require( "wibox.widget.textbox" )
local progressbar  = require( "awful.widget.progressbar" )
local wibox        = require( "wibox" )
local beautiful    = require( "beautiful" )
local capi         = { timer = timer }
local toolbox      = require( "toolbox" )
local string       = string
lain = require("lain")

local markup = lain.util.markup

module("mocp")

--- Create a mocp widget. It draws what mocp's playing
-- @param timeout How often update the time. Default is 60.
-- @param height Total height of the return "widget"
-- @param width Total width of the return "widget"
-- @return A layout.
function new( timeout, height, width )
   local timeout = timeout or 10
   --local height = height or 5 --FIXME: get parent wibox's height
   --local width = width or 10

   local l = wibox.layout.fixed.horizontal()
   --local pb_args = { height = height,
                     --width = width }

   local tb = textbox(  )
   --local pb = progressbar( pb_args )

   --toolbox.set_colors( pb )

   local timer = capi.timer { timeout = timeout }
   timer:connect_signal(
      "timeout",
      function()
         -- harvesting data
         local mocp = {  }
         fd = io.popen('mocp -i')
         state = fd:read()
         fd:close()
         if state then
             m_state = string.gsub(state, "State:%s*", "")
         else
             m_state = 'STOP'
         end
         if m_state == 'STOP' then
             tb:set_markup( ' Why Silence? ' )
         elseif m_state == 'PAUSE' then
             tb:set_markup( '|Oo|' )
         else
             mocp.state, mocp.file, mocp.title, mocp.artist, mocp.songTitle, mocp.album, mocp.totalTime, mocp.timeLeft, mocp.totalSec, mocp.currentTime, mocp.currentSec, mocp.bitrate, mocp.avgBitrate, mocp.rate = toolbox.pread( 'mocp --info' ):match( '^.*State:%s(.*)\n.*File:%s(.*)\n.*Title:%s(.*)\n.*Artist:%s(.*)\n.*SongTitle:%s*(.*)\n.*Album:%s(.*)\n.*TotalTime:%s(.*)\n.*TimeLeft:%s(.*)\n.*TotalSec:%s*(%d*)\n.*CurrentTime:%s(.*)\n.*CurrentSec:%s*(%d*)\n.*Bitrate:%s(.*)\n.*AvgBitrate:%s(.*)\n.*Rate:%s(.*)$' )
             if mocp.state == 'PLAY' then
                if mocp.artist ~= nil and mocp.songTitle ~= nil then
                   tb:set_text( ' ' .. mocp.artist:sub(1, 35) .. ' d^^b ' .. mocp.songTitle:sub(1, 65) .. ' ')
                elseif mocp.artist == nil and string.sub(mocp.file, 1 , string.len('http')) == 'http' and mocp.songTitle ~= nil then
                    tb:set_text('d^^b ' .. mocp.songTitle)
                end
             end
         end
      end)
   timer:start()
   timer:emit_signal("timeout")

   --l:add( pb )
   l:add( tb )

   return l
end

setmetatable(_M, { __call = function(_, ...) return new(...) end })
