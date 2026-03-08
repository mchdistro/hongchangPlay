aris.game.client.networking.register_s2c_packet_handler("game", function(v)

    if v.type == "seasoning" then
        open_seasoning_gui()
    end
    
end)

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

    gui:open()

    local click1 = aris.client.create_clickable(function()
        aris.game.client.send_system_message("1")
    end, 2, 702, 444, 283)
    gui:add_child(click1)

    local click2 = aris.client.create_clickable(function()
        aris.game.client.send_system_message("2")
    end, 435, 701, 444, 283)
    gui:add_child(click2)

    local click3 = aris.client.create_clickable(function()
        aris.game.client.send_system_message("3")
    end, 896.5, 691, 463, 283)
    gui:add_child(click3)

    local click4 = aris.client.create_clickable(function()
        aris.game.client.send_system_message("4")
    end, 1272, 487, 248, 178)
    gui:add_child(click4)
end

open_seasoning_gui()