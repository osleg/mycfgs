local awful = require("awful")
function dbg(vars)
        local text = ""
        if type(vars) == "table" then
                for i=1, #vars do text = text .. vars[i] .. " | " end
        elseif type(vars) == "string" then
                text = vars
        end
        naughty.notify({ text = text, timeout = 0 })
end

function clean(string)
        s = string.gsub(string, '^%s+', '')
        s = string.gsub(s, '%s+$', '')
        s = string.gsub(s, '[\n\r]+', ' ')
        return s
end

function file_exists(file)
        local cmd = "/bin/bash -c 'if [ -e " .. file .. " ]; then echo true; fi;'"
        local fh = io.popen(cmd)

        s = clean(fh:read('*a'))

        if s == 'true' then return true else return nil end
end

function require_safe(lib)
        if file_exists(awful.util.getdir("config") .. '/' .. lib ..'.lua') or
                file_exists(awful.util.getdir("config") .. '/' .. lib) then
                        require(lib)
        end
end

function run_once(prg,arg_string,pname,screen)
        if not prg then
                do return nil end
        end

        if not pname then
                pname = prg
        end

        if not arg_string then
                awful.spawn.with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
        else
                awful.spawn.with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
        end
end

function whereis_app(app)
    local fh = io.popen('which ' .. app)
    s = clean(fh:read('*a'))

    if s == "" then return nil else return s end
    return s
end

function safe_html(html)
-- list of strings to replace (the order is important to avoid conflicts)
    local cleaner = {
        { "&amp;", "&" }, -- decode ampersands
        { "&#151;", "-" }, -- em dash
        { "&#146;", "'" }, -- right single quote
        { "&#147;", "\"" }, -- left double quote
        { "&#148;", "\"" }, -- right double quote
        { "&#150;", "-" }, -- en dash
        { "&#160;", " " }, -- non-breaking space
        { "<br ?/?>", "\n" }, -- all <br> tags whether terminated or not (<br> <br/> <br />) become new lines
        { "</p>", "\n" }, -- ends of paragraphs become new lines
        { "(%b<>)", "" }, -- all other html elements are completely removed (must be done last)
        { "\r", "\n" }, -- return carriage become new lines
        { "[\n\n]+", "\n" }, -- reduce all multiple new lines with a single new line
        { "^\n*", "" }, -- trim new lines from the start...
        { "\n*$", "" }, -- ... and end
        }

    -- clean html from the string
    for i=1, #cleaner do
        local cleans = cleaner[i]
        t = string.gsub( html, cleans[2], cleans[1] )
    end
end
