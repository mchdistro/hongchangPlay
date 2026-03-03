-- local skill_hud = aris.game.client.create_hud()

-- local cooltime_text = aris.client.create_default_text_renderer("안녕", 0X000000)
-- cooltime_text:set_scale(5)
-- cooltime_text:set_x(100)
-- cooltime_text:set_y(100)
-- skill_hud:add_child(cooltime_text)

-- skill_hud:open_hud()

function get_limg()
    
    
end

local SCREEN_WIDTH1 = 850

function text_pixel_width1(str)
    local width = 0
    local i = 1
    while i <= #str do
        local byte = string.byte(str, i)
        if byte < 128 then
            width = width + 6
            i = i + 1
        elseif byte < 224 then
            width = width + 8
            i = i + 2
        elseif byte < 240 then
            width = width + 8
            i = i + 3
        else
            width = width + 8
            i = i + 4
        end
    end
    return width
end

function center_x1(text, scale)
    local text_width = text_pixel_width1(text) * scale
    return SCREEN_WIDTH1 / 2 - text_width / 2
end

local hud = aris.game.client.create_hud()
local bimg = aris.client.create_image_renderer(aris.client.load_image("hud.png"))
bimg:set_width(1920)
bimg:set_height(1080)
bimg:set_x(0)
hud:add_child(bimg)

local displayName = aris.client.create_default_text_renderer("", 0X000000)
displayName:set_scale(6)
local a = center_x1("", 6)
displayName:set_x(a)
displayName:set_y(60)
hud:add_child(displayName)

local money = aris.client.create_default_text_renderer("", 0X000000)
money:set_scale(4)
money:set_x(center_x1("", 4))
money:set_y(165)
hud:add_child(money)

local limg = aris.client.create_image_renderer(aris.client.load_image(""))
limg:set_width(256)
limg:set_height(256)
limg:set_x(30)
limg:set_y(20)
hud:add_child(limg)

hud:open_hud()

function urlencode(str)
    str = string.gsub(str, "([^%w%-%.%_%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    return str
end

aris.game.client.networking.register_s2c_packet_handler("hud_info", function(v)
    
    local player_displayName = v.displayName
    displayName:set_text(player_displayName)
    displayName:set_x(center_x1(player_displayName, 6))

    money:set_text(v.money.."타코")
    money:set_x(center_x1(v.money.."타코", 4))
    local url = "https://raw.githubusercontent.com/suhotest/hongsinso-server/main/"..urlencode(v.villageName)..".png"
    limg:set_image(aris.client.load_image(url))
    
end)