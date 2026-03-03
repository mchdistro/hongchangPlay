
function open_menu_gui()
    local menu_gui = aris.client.create_window()

    local menu = aris.client.create_image_renderer(aris.client.load_image("menu.png"))

    menu:set_width(1473)
    menu:set_height(559)
    menu:set_x(192)
    menu:set_y(192)
    menu_gui:add_child(menu)

    menu_gui:open()

    local click1 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("마을 이동")
    end, 831, 259, 138, 205)
    menu_gui:add_child(click1)

    local click2 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("로비")
    end, 993, 262, 137, 202)
    menu_gui:add_child(click2)

    local click3 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command(" 낚시터")
    end, 1153, 261, 138, 203)
    menu_gui:add_child(click3)

    local click4 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("우체국")
    end, 1314, 261, 137, 203)
    menu_gui:add_child(click4)

    local click5 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("사냥터입장")
    end, 1476, 261, 136, 203)
    menu_gui:add_child(click5)

    local click6 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("선물함")
    end, 830, 496, 138, 203)
    menu_gui:add_child(click6)

    local click7 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("마을 버프")
    end, 993, 497, 137, 202)
    menu_gui:add_child(click7)

    local click8 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("우편함")
    end, 1146, 497, 156, 202)
    menu_gui:add_child(click8)

    local click9 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("가방")
    end, 1314, 496, 147, 203)
    menu_gui:add_child(click9)

    local click1 = aris.client.create_clickable(function()
        menu_gui:close()
        aris.game.client.invoke_command("쓰레기통")
    end, 1466, 496, 149, 198)
    menu_gui:add_child(click1)



end


local should_open_menu = false

aris.game.client.add_on_key_pressed("menu", function()
    should_open_menu = true
end)

while true do
    if should_open_menu then
        should_open_menu = false
        open_menu_gui()
    end
    task_sleep(1)
end