local io           = io
local math         = math
local string       = string
local tostring     = tostring
local tonumber     = tonumber
local print        = print
local awful        = require( "awful" )
local beautiful    = require( "beautiful" )

module("toolbox")

-- greatest common divisor
function gcd( m, n )
   while m ~= 0 do
      m, n = math.mod(n, m), m
   end
   return n
end

function round( what, precision )
   return math.floor( what*math.pow( 10, precision) + 0.5 ) / math.pow( 10, precision )
end

function notify( title, message )
   local cmd = "notify-send  --urgency=critical --expire-time=5000 --icon=/usr/share/icons/Tango/32x32/actions/appointment.png "
   awful.util.spawn( cmd .. title .. ' ' .. message )
end

function fread( filename )
   if filename and filename ~= "" then
      local f, err = io.open( filename, 'r' )
      if f then
         local s = f:read( "*all" )
         f:close(  )
         return s
      else
         print( err )
      end
   end
end

--- Read a program output and returns its output as a string.
function pread( cmd )
   if cmd and cmd ~= "" then
      local f, err = io.popen( cmd, 'r' )
      if f then
         local s = f:read( "*all" )
         f:close(  )
         return s
      else
         print( err )
      end
   end
end

function set_colors( w )
   w:set_background_color( beautiful.bg_normal )
   w:set_color( beautiful.fg_normal )
   w:set_border_color( beautiful.border_focus )
end

function dec2hex(s)
   return string.format( "%02x", s )
end

function gradient(color, to_color, min, max, value)
   local function color2dec(c)
      return tonumber(c:sub(2,3),16), tonumber(c:sub(4,5),16), tonumber(c:sub(6,7),16)
   end

   local factor = 0
   if (value >= max ) then 
      factor = 1  
   elseif (value > min ) then 
      factor = (value - min) / (max - min)
   end 

   local red, green, blue = color2dec(color) 
   local to_red, to_green, to_blue = color2dec(to_color) 

   red   = red   + (factor * (to_red   - red))
   green = green + (factor * (to_green - green))
   blue  = blue  + (factor * (to_blue  - blue))

   -- dec2color
   return string.format("#%02x%02x%02x", red, green, blue)
end
