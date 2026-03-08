function open_seasoning_gui()
    local gui = aris.client.create_window()

    local table = aris.client.create_image_renderer(aris.client.load_image("table.png"))
    table:set_width(1920)
    table:set_height(1080)
    table:set_x(0)
    table:set_y(0)
    gui:add_child(table)

    local img1 = aris.client.create_image_renderer(aris.client.load_image("seasoning/tub.png"))
    img1:set_width(1481)
    img1:set_height(833)
    img1:set_x(-132)
    img1:set_y(-56)
    gui:add_child(img1)

    local img2 = aris.client.create_image_renderer(aris.client.load_image("seasoning/red_pepper_powder.png"))
    img2:set_width(530)
    img2:set_height(298)
    img2:set_x(-37)
    img2:set_y(703)
    gui:add_child(img2)

    local img3 = aris.client.create_image_renderer(aris.client.load_image("seasoning/radish.png"))
    img3:set_width(533)
    img3:set_height(300)
    img3:set_x(407)
    img3:set_y(701)
    gui:add_child(img3)

    local img4 = aris.client.create_image_renderer(aris.client.load_image("seasoning/minced_garlic.png"))
    img4:set_width(536)
    img4:set_height(301)
    img4:set_x(860)
    img4:set_y(701.5)
    gui:add_child(img4)

    local img5 = aris.client.create_image_renderer(aris.client.load_image("seasoning/fish_sauce.png"))
    img5:set_width(815)
    img5:set_height(458)
    img5:set_x(959.5)
    img5:set_y(394)
    gui:add_child(img5)

    local img6 = aris.client.create_image_renderer(aris.client.load_image("seasoning/text.png"))
    img6:set_width(1920)
    img6:set_height(1080)
    img6:set_x(548)
    img6:set_y(-289)
    gui:add_child(img6)


    local img8 = aris.client.create_image_renderer(aris.client.load_image("seasoning/n1.png"))
    img8:set_width(78)
    img8:set_height(78)
    img8:set_x(33)
    img8:set_y(692)
    gui:add_child(img8)

    local img9 = aris.client.create_image_renderer(aris.client.load_image("seasoning/n2.png"))
    img9:set_width(78)
    img9:set_height(78)
    img9:set_x(454)
    img9:set_y(700.5)
    gui:add_child(img9)

    local img10 = aris.client.create_image_renderer(aris.client.load_image("seasoning/n3.png"))
    img10:set_width(78)
    img10:set_height(78)
    img10:set_x(910.5)
    img10:set_y(701)
    gui:add_child(img10)

    local img11 = aris.client.create_image_renderer(aris.client.load_image("seasoning/n4.png"))
    img11:set_width(78)
    img11:set_height(78)
    img11:set_x(1219)
    img11:set_y(490)
    gui:add_child(img11)

    local img7 = aris.client.create_image_renderer(aris.client.load_image(""))
    img7:set_width(1920)
    img7:set_height(1080)
    gui:add_child(img7)

    gui:open()

    local input_order = {}
    local done = false
    local gui_close = false
    local tub_images = { "seasoning/tub_1.png", "seasoning/tub_2.png", "seasoning/tub_3.png", "seasoning/tub_3.png" }

    local function add_ingredient(n)
        if done then return end
        for _, v in ipairs(input_order) do
            if v == n then return end
        end
        input_order[#input_order + 1] = n
        img1:set_image(aris.client.load_image(tub_images[#input_order]))

        if #input_order == 4 then
            done = true
            if input_order[1] == 1 and input_order[2] == 2 and input_order[3] == 3 and input_order[4] == 4 then
                img7:set_image(aris.client.load_image("success.png"))
            else
                img7:set_image(aris.client.load_image("failure.png"))
            end
            gui_close = get_time()
        end
    end

    local click1 = aris.client.create_clickable(function()
        add_ingredient(1)
    end, 2, 702, 444, 283)
    gui:add_child(click1)

    local click2 = aris.client.create_clickable(function()
        add_ingredient(2)
    end, 435, 701, 444, 283)
    gui:add_child(click2)

    local click3 = aris.client.create_clickable(function()
        add_ingredient(3)
    end, 896.5, 691, 463, 283)
    gui:add_child(click3)

    local click4 = aris.client.create_clickable(function()
        add_ingredient(4)
    end, 1272, 487, 248, 178)
    gui:add_child(click4)

    aris.game.client.hook.add_tick_hook(function()
        if gui_close ~= false then
            if get_time() >= gui_close + 1000 then
                gui:close()
                gui_close = false
                local packet_builder = aris.game.client.networking.create_c2s_packet_builder("game")
                local result = "실패"
                if input_order[1] == 1 and input_order[2] == 2 and input_order[3] == 3 and input_order[4] == 4 then
                    result = "성공"
                end
                packet_builder:append_string("type", "seasoning||" .. result)
                aris.game.client.networking.send_c2s_packet(packet_builder)
            end
        end
    end)
end


aris.game.client.networking.register_s2c_packet_handler("game", function(v)

    if v.type == "seasoning" then
        open_seasoning_gui()
    end
    
end)


-- open_seasoning_gui()