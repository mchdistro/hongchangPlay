local debug = false

function open_slicing_gui()
    local gui = aris.client.create_window()

    local catch = false
    local mash_count = 0
    local mash_target = 5
    local mash_time = 5
    local mash_active = false
    local mash_done = false
    local mash_start_time = 0
    local gui_close = false

    local table = aris.client.create_image_renderer(aris.client.load_image("table.png"))
    table:set_width(1920)
    table:set_height(1080)
    table:set_x(0)
    table:set_y(0)
    gui:add_child(table)

    local img1 = aris.client.create_image_renderer(aris.client.load_image("slicing/cutting_board.png"))
    img1:set_width(1920)
    img1:set_height(1080)
    img1:set_x(0)
    img1:set_y(0)
    gui:add_child(img1)

    local img2 = aris.client.create_image_renderer(aris.client.load_image("slicing/cabbage.png"))
    img2:set_width(1920)
    img2:set_height(1080)
    img2:set_x(0)
    img2:set_y(0)
    gui:add_child(img2)

    local img3 = aris.client.create_image_renderer(aris.client.load_image("slicing/knife.png"))
    img3:set_width(1920)
    img3:set_height(1080)
    img3:set_x(5)
    img3:set_y(-2)
    gui:add_child(img3)

    local img4 = aris.client.create_image_renderer(aris.client.load_image(""))
    img4:set_width(1920)
    img4:set_height(1080)
    gui:add_child(img4)

    local click1 = aris.client.create_clickable(function()
        if not catch then
            catch = true
        end
    end, 1570, 636, 139, 382)
    gui:add_child(click1)

    gui:add_render_hook(function(mx, my, delta)
        if catch == true then
            img3:set_x(mx-1620)
            img3:set_y(my-800)
        end
    end)

    -- 연타
    local click2 = aris.client.create_clickable(function()
        if not catch then return end
        if mash_done then return end

        if not mash_active then
            mash_start_time = get_time()
            mash_count = 0
            mash_active = true
            if debug then aris.game.client.send_system_message("연타 시작! " .. mash_target .. "회 / " .. mash_time .. "초") end
            return
        end

        if get_time() - mash_start_time > mash_time * 500 then
            mash_active = false
            if mash_count >= mash_target then
                -- a
            else
                -- aris.game.client.send_system_message("111")
            end
            return
        end

        mash_count = mash_count + 1
        if debug then aris.game.client.send_system_message(mash_count .. " / " .. mash_target) end
        if mash_count >= mash_target then
            mash_active = false
            mash_done = true
            img2:set_image(aris.client.load_image("slicing/cut_cabbage.png"))
            img4:set_image(aris.client.load_image("success.png"))
            gui_close = get_time()
        end
    end, 135, 738, 1259, 322)
    gui:add_child(click2)

    gui:open()

    aris.game.client.hook.add_tick_hook(function()
        if mash_active and get_time() - mash_start_time > mash_time * 5000 then
            mash_active = false
            if mash_count >= mash_target then
                -- a
            else
                -- img4:set_image(aris.client.load_image("failure.png"))
                -- gui_close = get_time()
            end
        end
        if gui_close ~= false then
            if get_time() >= gui_close + 3000 then
                gui:close()
                gui_close = false
                local packet_builder = aris.game.client.networking.create_c2s_packet_builder("game")
                packet_builder:append_string("type", "slicing")
                aris.game.client.networking.send_c2s_packet(packet_builder)
            end
        end
    end)
end

aris.game.client.networking.register_s2c_packet_handler("game", function(v)

    if v.type == "slicing" then
        open_slicing_gui()
    end
    
end)