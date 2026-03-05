aris.game.client.networking.register_s2c_packet_handler("roulette_result", function(v)
    -- aris.game.client.send_system_message("data1: " .. v.data1)
    -- aris.game.client.send_system_message("data2: " .. v.data2)
    -- aris.game.client.send_system_message("data3: " .. v.data3)
    -- aris.game.client.send_system_message("data4: " .. v.data4)
    -- aris.game.client.send_system_message("msg: " .. v.msg)

    open_roulette_gui(v.data1,v.data2,v.data3,v.data4,v.msg)
end)

aris.game.client.networking.register_s2c_packet_handler("village_selection_gui", function(v)
    aris.game.client.send_system_message("villages: " .. v.villages)

    local packet_builder = aris.game.client.networking.create_c2s_packet_builder("village_selection")
    packet_builder:append_string("selectedvillage", "테스트")
    aris.game.client.networking.send_c2s_packet(packet_builder)
end)

function xyxyToXywh(x1, y1, x2, y2)
    local x = x1
    local y = y1
    local width = x2 - x1
    local height = y2 - y1
    
    return x, y, width, height
end

function split(str, delimiter)
    local result = {}
    local from = 1
    local delim_len = #delimiter

    while true do
        local start, finish = string.find(str, delimiter, from, true)
        if not start then
            table.insert(result, string.sub(str, from))
            break
        end
        table.insert(result, string.sub(str, from, start - 1))
        from = finish + 1
    end

    return result
end

function spin_roulette(text, data_list, scale)
    local base_spins = 3
    local start_delay = 10
    local end_delay = 80

    local last_val = data_list[#data_list]
    local range_min, range_max = string.match(last_val, "^([%d,]+)~([%d,]+)$")

    if range_min and range_max then
        -- 범위 모드: 10~100 같은 형식
        range_min = tonumber((range_min:gsub(",", "")))
        range_max = tonumber((range_max:gsub(",", "")))
        local target = tonumber((data_list[1]:gsub(",", "")))
        local total_spins = 12

        for i = 1, total_spins - 1 do
            local progress = i / total_spins
            local delay = start_delay + (end_delay - start_delay) * (progress * progress)
            local num = math.random(range_min, range_max)
            local s = tostring(num)
            text:set_text(s)
            text:set_x(center_x(s, scale))
            task_sleep(delay)
        end
        -- 마지막에 target으로 멈춤
        local s = tostring(target)
        text:set_text(s)
        text:set_x(center_x(s, scale))
    else
        -- 일반 리스트 모드
        local total_spins = (base_spins - 1) * #data_list + 1

        for i = 1, total_spins do
            local progress = i / total_spins
            local delay = start_delay + (end_delay - start_delay) * (progress * progress)
            local idx = ((i - 1) % #data_list) + 1
            text:set_text(data_list[idx])
            aris.log_info(data_list[idx] .. " : " .. center_x(data_list[idx], scale))
            text:set_x(center_x(data_list[idx], scale))
            task_sleep(delay)
        end
    end

    -- 결과 깜빡깜빡
    for i = 1, 4 do
        text:set_is_visible(false)
        task_sleep(80)
        text:set_is_visible(true)
        task_sleep(80)
    end
end

local SCREEN_WIDTH = 1920

function utf8_len(str)
    local len = 0
    local i = 1
    while i <= #str do
        local byte = string.byte(str, i)
        if byte < 128 then
            i = i + 1
        elseif byte < 224 then
            i = i + 2
        elseif byte < 240 then
            i = i + 3
        else
            i = i + 4
        end
        len = len + 1
    end
    return len
end

function text_pixel_width(str)
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

function center_x(text, scale)
    local text_width = text_pixel_width(text) * scale
    return SCREEN_WIDTH / 2 - text_width / 2
end

function open_roulette_gui(data1, data2, data3, data4, msg)
    local roulette_gui = aris.client.create_window()

    local roulette = aris.client.create_image_renderer(aris.client.load_image("roulette.png"))

    roulette:set_width(1920)
    roulette:set_height(1080)
    roulette_gui:add_child(roulette)

    roulette_gui:set_can_exit_with_esc(true)
    
    local data_list1 = split(data1, "||")
    local data_list2 = split(data2, "||")
    local data_list3 = split(data3, "||")
    local data_list4 = split(data4, "||")

    local text2 = aris.client.create_default_text_renderer("§l"..data_list2[#data_list2], 0xFFFFFF)
    text2:set_x(center_x(data_list2[#data_list2], 6))
    aris.log_info(data_list2[#data_list2] .. " : " .. center_x(data_list2[#data_list2], 6))
    text2:set_y(330)
    text2:set_scale(6)
    roulette_gui:add_child(text2)

    local text3 = aris.client.create_default_text_renderer("§l0", 0xFFFFFF)
    text3:set_x(center_x("0", 6))
    text3:set_y(420)
    text3:set_scale(6)
    roulette_gui:add_child(text3)

    local text4 = aris.client.create_default_text_renderer("§l"..data_list4[#data_list4], 0xFFFFFF)
    text4:set_x(center_x(data_list4[#data_list4], 6))
    text4:set_y(510)
    text4:set_scale(6)
    roulette_gui:add_child(text4)

    -- local text4 = aris.client.create_default_text_renderer("§l"..data_list4[#data_list4], 0xFFFFFF)
    -- text4:set_x(680)
    -- text4:set_y(540)
    -- text4:set_scale(20)
    -- roulette_gui:add_child(text4)

    roulette_gui:open()

    -- spin_roulette(text1, data_list1, cx, 5)
    spin_roulette(text2, data_list2, 6)
    spin_roulette(text3, data_list3, 6)
    if #data_list4 > 1 then
        spin_roulette(text4, data_list4, 6)
    end

    local msg_text = aris.client.create_default_text_renderer("§l"..msg, 0xFFFFFF)
    msg_text:set_x(center_x(msg, 6))
    msg_text:set_y(600)
    msg_text:set_scale(6)
    roulette_gui:add_child(msg_text)

    local packet_builder = aris.game.client.networking.create_c2s_packet_builder("roulette_complete")
    packet_builder:append_string("done", "true")
    aris.game.client.networking.send_c2s_packet(packet_builder)
end

-- 테스트 용
-- open_roulette_gui("1||1","1||11111111111","1||1","1||1")